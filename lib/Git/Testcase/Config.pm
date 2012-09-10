package Git::Testcase::Config;

use strict;
use warnings;

use Moose;

=head1 AUTHOR

Johan Sydseter C<<johan.sydseter@startsiden.no>>

=head1 NAME

Git::Testcase::Config

=head1 DESCRIPTION

This package contains the git testsuite config object

=cut

=head3 base_url

The base url to do testing against

=cut

has 'base_url' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1
);
