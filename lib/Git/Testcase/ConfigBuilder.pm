package Git::Testcase::ConfigBuilder;

use strict;
use warnings;
use Log::Log4perl qw(get_logger);
use Moose;
use Git::Testcase::Helper::ConfigLoader;
use Git::Info;
use Git::Testcase::Config;

=head1 AUTHOR

Johan Sydseter C<<johan.sydseter@startsiden.no>>

=head1 NAME

Git::Testcase::ConfigBuilder;

=head1 DESCRIPTION

This package builds the testsuite

=cut

=head3 config_loader

Loads the configuration file

=cut
has 'config_loader' => (
    is      => 'ro',
    isa     => 'Git::Testcase::Helper::ConfigLoader',
    default => sub {
        my $configLoader = new Git::Testcase::Helper::ConfigLoader();
        return $configLoader;
});


has 'config' => (
    is      => 'rw',
    isa     => 'Git::Testcase::Config',
    default => sub {
        my $config = new Git::Testcase::Config();
        return $config;
});

=head3 build_config

Builds the config

Takes the name of a git branch and uses that to search for a config

=cut
sub build_branch_config {
    my($self, $git_branch) = @_;
    my $logger = get_logger('Git::Testcase::ConfigBuilder');

    my $config_loader = $self->config_loader();    

    my $configuration = $config_loader->config();

    $configuration = $configuration->{$git_branch}; 

    if (!$configuration) {
        $logger->logdie("You didn't specify any configuration for the " 
            . "branch $git_branch");
    }

    my $config = $self->config();
    $config->populate_config($configuration);
}

1;

__END__
