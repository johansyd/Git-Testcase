package Git::Testcase;

use strict;
use warnings;

use Moose;
use Log::Log4perl qw(get_logger);
use Git::Info;
use Git::Testcase::Bootstrap;

our $VERSION = '0.01';

=head1 AUTHOR

Johan Sydseter C<<johan.sydseter@startsiden.no>>

=head1 NAME

Git::Testcase

=head1 DESCRIPTION

This package will prepare the builder testsuite

=cut

=head3 configLoader

The testsuite configuration

=cut
has 'config' => (
    is  => 'rw',
    isa => 'Git::Testcase::Config'
);

=head3 Bootstrap

The config builder

=cut
has 'bootstrap' => (
    is  => 'ro',
    isa => 'Git::Testcase::Bootstrap',
    required => 1
);

=head3 git_info

Gets info about the git repository

=cut
has 'git_info' => (
    is      => 'ro',
    isa     => 'Git::Info',
    default => sub {
        my $git_branch = new Git::Info();
        return $git_branch;
});

sub BUILD {
    my($self, $args) = @_;
    
    my $git_info = $self->git_info();
    my $git_branch = $git_info->current_branch();
    my $bootstrap = $args->{'bootstrap'};

    $bootstrap->build_branch_config($git_branch);

    my $config = $bootstrap->config();

    $self->config($config);
}

1;
__END__
