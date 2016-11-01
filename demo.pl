use Net::aweberapi;
use JSON;

use Data::Dumper;

=head1 DEMO

Simple demo of how to use the Net::aweberapi module

=head2 Getting Started

This script, as written, shows how to hard code your access tokens.
In production, you probably don't want to do that. One alternative is
to load the tokens from an init file. Net::OAuth::Simple provides convenience
functions for that. In the context of this demo, it could look like this:

    my $CONFIG = ".aweberapi_config";
    my %tokens = Net::OAuth::Simple->load_tokens($CONFIG);
    my $aw = Net::AWeberAPI->new(%tokens);

=cut

my $aw = Net::AWeberAPI->new( consumer_key => '',
                              consumer_secret => '',
                              access_token => '',
                              access_token_secret => ''
                            );

my $account = $aw->get('https://api.aweber.com/1.0/accounts/');
print Dumper($account);
