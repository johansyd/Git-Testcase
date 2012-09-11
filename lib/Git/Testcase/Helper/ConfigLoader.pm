package Git::Testcase::Helper::ConfigLoader;

use strict;
use warnings;

use Moose;
use Cwd qw(getcwd);

use Config::Any qw(load_files);
use Log::Log4perl qw(get_logger);

=head1 AUTHOR

Johan Sydseter C<<johan.sydseter@startsiden.no>>

=head1 NAME

Git::Testcase::Helper::ConfigLoader

=head1 DESCRIPTION

This package will load the config

=cut

=head3 config

The Configuration for the testsuite

=cut
has 'config' => (
    is      => 'rw',
    isa     => 'HashRef',
    default => sub { {} }
);

=head3 config_dir

The base dir of the configuration files.
Checks for a configuration folder in the parrent of the current dir.

=cut
has 'config_dir' => (
    is      => 'rw',
    isa     => 'Str',
    default => sub { getcwd() . '/etc' }
);

=head3 config_basepath

The basepath of the configuration file
Looks for a config folder in the containing folder of the tests

=cut

has 'config_basepath' => (
    is      => 'rw',
    isa     => 'Str',
    default => sub { 'testsuite' }
);

=head3 _config_suffix

File ending.
TODO implement multiple config types

=cut

has '_config_suffix' => (
    is  => 'ro',
    isa => 'Str',
    default => sub { 'yml' }
);

=head3 _load_config

Loading the config

=cut

sub _load_config {
    my ($self) = @_;
    my $logger = get_logger('Git::Testcase::Helper::ConfigLoader');
    my @files = ();
    my $config_dir = $self->config_dir();
    my $config_basepath = $self->config_basepath();
    my $config_suffix = $self->_config_suffix();

    my $config_file = "$config_dir/$config_basepath.$config_suffix";

    $logger->logdie('config file'
        . $config_file . ' does not exist') unless (-e $config_file);
    $logger->logdie('config file'
        . $config_file . ' is not readable') unless (-r $config_file);

    push(@files, $config_file);

    my $configurations = Config::Any->load_files( {
        files => \@files, 'use_ext' => 1});

    my $configuration = @$configurations[0]->{$config_file};

    if(!defined $configuration || !$configuration) {
        $logger->logdie("$config_file has no configuration.");
    }

    $self->config($configuration);
}
=head1 BUILD

=cut
sub BUILD {
    my ($self, $args) = @_;

    my $logger = get_logger('Git::Testcase::Helper::ConfigLoader');

    my $config_dir = $self->config_dir();

    my $config_dir_arg = $args->{'config_dir'};

    if (defined $config_dir_arg) {
        $config_dir = $config_dir_arg;
    }

    if (!-d $config_dir) {
        $logger->logdie("$config_dir does not exist.");
    }

    $self->config_dir($config_dir);
    $self->_load_config();
}
1;
__END__

