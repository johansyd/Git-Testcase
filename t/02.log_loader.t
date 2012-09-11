use strict;
use warnings;
use Test::More tests => 1;
use Git::Testcase::Helper::LogLoader;

=head1 AUTHOR

Johan Sydseter C<<johan.sydseter@startsiden.no>>

=head1 DESCRIPTION

This test tests the Git::Testcase::Helper::LogLoader

=cut

my $log_loader = new Git::Testcase::Helper::LogLoader();

ok($log_loader->init_rootLogger(), "The rootlooger works.");

done_testing();
1;

__END__
