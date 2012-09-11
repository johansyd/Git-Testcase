package Git::Testcase::Config;

use strict;
use warnings;
use Moose;
use Log::Log4perl qw(get_logger);

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
    is       => 'rw',
    isa      => 'Str'
);

sub populate_config {
    my($self, $configuration) = @_;
    my $logger = get_logger('Git::Testcase::Config');
    my $base_url = $configuration->{'baseurl'};

    if (!$base_url) {
        $logger->logdie("You forgot to specify a baseurl to test against");
    }
    $self->base_url($base_url);
}

1;
__END__
