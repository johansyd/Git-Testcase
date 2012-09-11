package Git::Testcase;

use strict;
use warnings;

use Moose;
use Log::Log4perl qw(get_logger);
use Git::Info;
use Git::Testcase::ConfigBuilder;

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

=head3 configBuilder

The config builder

=cut
has 'config_builder' => (
    is  => 'ro',
    isa => 'Git::Testcase::ConfigBuilder',
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
    my $config_builder = $args->{'config_builder'};

    $config_builder->build_branch_config($git_branch);

    my $config = $config_builder->config();

    $self->config($config);
}

1;
__END__
