use strict;
use warnings;
use Test::More tests => 1;
use Git::Testcase::Helper::ConfigLoader;

=head1 AUTHOR

Johan Sydseter C<<johan.sydseter@startsiden.no>>

=head1 DESCRIPTION

This test tests the Git::Testcase::Helper::ConfigLoader

=cut

my $config_loader = new Git::Testcase::Helper::ConfigLoader(
    'config_dir' => './dataprovider'
);

my $config = $config_loader->config();

my $basepath = $config->{'default'}->{'baseurl'};

ok($basepath eq 'test', "The basepath was correct. Fetched $basepath");

done_testing();

1;

__END__
