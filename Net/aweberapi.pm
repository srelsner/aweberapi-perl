package Net::AWeberAPI;

use parent qw(Net::OAuth::Simple);
use JSON;

our $debug = 1;
our $VERSION = '0.1.0';

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

#TODO: fix the scoping issue around $debug so that this works:
sub debug {
    my $self = shift;
    if (@_) {
        $self->{debug} = shift;
    }
    return $self->{debug};
}

sub get {
    my $response = get_raw(@_);
    if ($response->content) {
        return decode_json($response->content);
    }
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

sub new {
    my $class = shift;
    return $class->SUPER::new();
}

sub request {
    my ($self, $request, @params) = @_;

    $self->agent('Net::AweberAPI Perl/'.$VERSION);

    my $response = $self->SUPER::request($request, @params);
    if ($Net::AWeberAPI::debug) {
        print "REQUEST:\n".$request->as_string . "\n";
        print "RESPONSE BODY:\n".$response->content . "\n";
    }
    return $response;
}
1;
