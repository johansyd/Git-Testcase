use strict;
use warnings;
use Test::More tests => 3;
use Git::Info;

=head1 AUTHOR

Johan Sydseter C<<johan.sydseter@startsiden.no>>

=head1 DESCRIPTION

This test tests the Git::Info

=cut

my $git_info = new Git::Info();

my $git_branch = $git_info->current_branch();
ok($git_branch, "The branch $git_branch was returned.");

ok($git_branch ne 'default', 
    "The git branch $git_branch was not the default value.");

ok($git_branch eq $git_info->fetch_current('./../.git'), 
    "fetch_current Git::Info->current_branch() delivers $git_branch");

done_testing();

1;

__END__
