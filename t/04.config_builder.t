use strict;
use warnings;
use Test::More tests => 1;
use Git::Testcase::ConfigBuilder;

=head1 AUTHOR

Johan Sydseter C<<johan.sydseter@startsiden.no>>

=head1 DESCRIPTION

This test tests the ConfigLoader

=cut

my $config_loader = new Git::Testcase::Helper::ConfigLoader(
    'config_dir' => 't/dataprovider'
);

my $config_builder = new Git::Testcase::ConfigBuilder(
    'config_loader' => $config_loader
);
$config_builder->build_branch_config('default');
my $config = $config_builder->config();

my $base_url = $config->base_url();

ok($base_url eq 'test', "The basepath was $base_url");

done_testing();

1;

__END__

