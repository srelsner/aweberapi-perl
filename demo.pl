use Net::aweberapi;
use JSON;

use Data::Dumper;

my $aw = Net::AWeberAPI->new( consumer_key => '',
                              consumer_secret => '',
                              access_token => '',
                              access_token_secret => ''
                            );

my $account = $aw->get('https://api.aweber.com/1.0/accounts/');
print Dumper($account);
