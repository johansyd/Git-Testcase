package Git::Info;
use strict;
use warnings;
use FindBin qw($Bin);
use Moose;
use Log::Log4perl qw(get_logger);

=head1 AUTHOR

Johan Sydseter C<<johan.sydseter@startsiden.no>>

=head1 NAME

Git::Info;

=head1 DESCRIPTION

This package introspect git to find branch information

=cut

=head3 git_branch

The branch that is tested against

=cut

has 'current_branch' => (
    is  => 'rw',
    isa => 'Str',
    default => sub { 'default' }
);

=head3 git_dir

The git dir where the the git repository information is stored
Looks for a .git folder in the parent of the current dir

=cut

has 'git_dir' => (
    is      => 'rw',
    isa     => 'Str',
    default => sub {
        my $git_dir = $Bin . '/../.git';
        return $git_dir;
});

=head3

Fetch the current git HEAD ref given the existence of a .git directory

=cut
sub fetch_current {
    my ($self, $git_dir) = @_;
    my $logger = get_logger('Git::Branch');

    if (!-d $git_dir) {
        $logger->logdie("$git_dir does not exist.");
    }

    my $git_head_file = "$git_dir/HEAD";

    if(!-e $git_head_file) {
        $logger->logdie("$git_head_file missing. "
            . "Please checkout to a valid branch");
    }

    if(!-r $git_head_file) {
        $logger->logdie("$git_head_file is not readable. "
            . "Check that you have the rights for using "
            . "this git repository.");
    }

    open FILE, '<', $git_head_file or $logger->logdie(
        "Could not open $git_head_file");

    my @lines = <FILE>;
    my $git_ref_str = $lines[0];
    my $git_ref = substr($git_ref_str,16);
    chomp($git_ref);

    return $git_ref;
}

=head3 BUILD

Builds the branch info

=cut

sub BUILD {
    my($self, $args) = @_;

    my $logger = get_logger('Git::Branch');

    my $git_dir = $self->git_dir();

    my $current_branch;

    my $git_dir_arg = $args->{'git_dir'};
    my $git_branch_arg = $args->{'git_branch'};

    if (defined $git_dir_arg) {
        $git_dir = $git_dir_arg;
        $self->git_dir($git_dir);
    }

    if (!-d $git_dir) {
        $logger->logdie("$git_dir does not exist.");
    }

    if(!defined $git_branch_arg) {
        $current_branch = $self->fetch_current($git_dir);
    }

    if ($current_branch) {
        $self->current_branch($current_branch);
    } else {
        $logger->error("No git branch could be retrieved using "
            . "$current_branch.");
    }
}

1;

__END__
