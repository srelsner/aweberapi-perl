package Net::AWeberAPI;

use parent qw(Net::OAuth::Simple);
use JSON;

our $VERSION = '0.1.1';

sub new {
    my $class = shift;
    my %tokens = @_;

    my %urls = {
                    authorization_url => 'https://auth.aweber.com/1.0/oauth/authorize',
                    request_token_url => 'https://auth.aweber.com/1.0/oauth/request_token',
                    access_token_url => 'https://auth.aweber.com/1.0/oauth/access_token'
                };

    my $base_url = 'https://api.aweber.con/1.0';

    return $class->SUPER::new( tokens => \%tokens,
                               protocol_version => '1.0a',
                               urls => \%urls,
                               browser => Net::AWeberAPI::UserAgent->new()
                              );
}

sub get {
    my $response = get_raw(@_);
    return decode_json($response->content) if $response->content;
}

sub get_raw {
    my ($self, $url, %params) = @_;
    return $self->make_restricted_request($url, 'GET', %params);
}

sub post {

}

sub put {

}

sub patch {

}

package Net::AWeberAPI::UserAgent;
=head2 Custom UA

Adds basic debug output to our API client and gives us a unique UA string

=cut
use parent 'LWP::UserAgent';

use Env qw(AWEBERAPI_DEBUG);

sub new {
    my $class = shift;
    return $class->SUPER::new();
}

sub request {
    my ($self, $request, @params) = @_;
    $self->agent('Net::AweberAPI Perl/'.$VERSION);

    my $response = $self->SUPER::request($request, @params);

    if (defined $AWEBERAPI_DEBUG && $AWEBERAPI_DEBUG == 1) {
        print "REQUEST:\n".$request->as_string . "\n";
        print "RESPONSE BODY:\n".$response->content . "\n";
    }
    return $response;
}
1;
