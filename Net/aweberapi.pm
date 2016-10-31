package Net::AWeberAPI;

use strict;
use base qw(Net::OAuth::Simple);
use JSON;

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
                               urls => \%urls
                              );
}

sub get {
    my $self = shift;
    my $url = shift;
    my $response =  $self->make_restricted_request($url, 'GET');
    if ($response->content) {
        return decode_json($response->content);
    }
}

sub get_raw {
    my $self = shift;
    my $url = shift;
    return $self->make_restricted_request($url, 'GET');
}

sub post {

}

sub put {

}

sub patch {

}
1;
