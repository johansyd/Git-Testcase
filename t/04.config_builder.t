use strict;
use warnings;
use Test::More tests => 1;
use Git::Testcase::Bootstrap;

=head1 AUTHOR

Johan Sydseter C<<johan.sydseter@startsiden.no>>

=head1 DESCRIPTION

This test tests the ConfigLoader

=cut

my $config_loader = new Git::Testcase::Helper::ConfigLoader(
    'config_dir' => './dataprovider'
);

my $bootstrap = new Git::Testcase::Bootstrap(
    'config_loader' => $config_loader
);
$bootstrap->build_branch_config('default');
my $config = $bootstrap->config();

my $base_url = $config->base_url();

ok($base_url eq 'test', "The basepath was $base_url");

done_testing();

1;

__END__

