=head1 AUTHOR

Johan Sydseter C<< <johan.sydseter@startsiden.no> >>

=head1 DESCRIPTION

This test tests if I can use the packages in this module.

=cut

use strict;
use warnings;
use Test::More tests => 4;

BEGIN {
use_ok( 'Git::Info');
use_ok( 'Git::Testcase' );
use_ok( 'Git::Testcase::ConfigBuilder' );
use_ok( 'Git::Testcase::Config' );
use_ok( 'Git::Testcase::Helper::ConfigLoader' );
use_ok( 'Git::Testcase::Helper::LogLoader');
}

diag( "Testing Git::Testcase $Git::Testsuite::VERSION" );

1;

__END__
