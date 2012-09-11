package Git::Testcase::Helper::LogLoader;

use strict;
use warnings;

use Moose;
use Log::Log4perl qw(get_logger);

=head1 AUTHOR

Johan Sydseter C<<johan.sydseter@startsiden.no>>

=head1 NAME

Git::Testcase::Helper::LogLoader

=head1 DESCRIPTION

This package initalizes a logger
TODO implement logging to file or socket
=cut

=head3 _default_log_config

The default configuration of the logger

=cut

has '_default_log_config' => (
    is  => 'ro',
    isa => 'HashRef',
    default => sub {
        my $log_level = $ENV{'GIT_TESTSUITE_LOG_LEVEL'} || "TRACE";
        my $log_pattern = $ENV{'GIT_TESTSUITE_LOG_PATTERN'}
            || "%d %p %M %m %n";

       my $log_config = {'log4perl.rootLogger' => 
              $log_level . ', Screen',
          'log4perl.appender.Screen' =>
              'Log::Log4perl::Appender::Screen',
          'log4perl.appender.Screen.stderr' => 1,
          'log4perl.appender.Screen.layout' =>
              'Log::Log4perl::Layout::PatternLayout',
          'log4perl.appender.Screen.layout.ConversionPattern' =>
              $log_pattern,
       };
       return $log_config;
});

=head3 log_config

The Log configuration

=cut

has 'log_config' => (
    is => 'ro',
    isa => 'HashRef'
);

=head3 init_rootLogger

Initialize a logger uses the default values if nothing gets set
export GIT_TESTSUITE_LOG_LEVEL to set the log level.
export GIT_TESTSUITE_LOG_PATTERN to set the log ConversionPattern


=cut
sub init_rootLogger {
    my ($self) = @_;

    my $log_config = $self->log_config();

    if(!$log_config) {
        $log_config = $self->_default_log_config();
    }
    Log::Log4perl->init($log_config);
    return 1;
}

1;

__END__
