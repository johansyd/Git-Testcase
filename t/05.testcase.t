use strict;
use warnings;
use Test::More tests => 1;
use Git::Testcase;
use Git::Testcase::Helper::ConfigLoader;
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

my $testcase = new Git::Testcase(
    'config_builder' => $config_builder
);

my $config = $testcase->config();

my $url = $config->base_url();

ok($url eq 'test', "The base_url was $url");

done_testing();

1;

__END__
