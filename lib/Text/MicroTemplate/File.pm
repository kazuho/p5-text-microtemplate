package Text::MicroTemplate::File;

use strict;
use warnings;
use Text::MicroTemplate;

use Carp qw(croak);

our @ISA = qw(Text::MicroTemplate);

sub new {
    my $klass = shift;
    my $self = $klass->SUPER::new(@_);
    $self->{open_layer}   ||= ':utf8';
    $self->{include_path} ||= [ '.' ];
    unless (ref $self->{include_path}) {
        $self->{include_path} = [ $self->{include_path} ];
    }
    $self->{use_cache} ||= 0;
    $self->{cache} = {};  # file => { mtime, sub }
    $self;
}

sub open_layer {
    my $self = shift;
    $self->{open_layer} = $_[0]
        if @_;
    $self->{open_layer};
}

sub use_cache {
    my $self = shift;
    $self->{use_cache} = $_[0]
        if @_;
    $self->{use_cache};
}

sub build_file {
    my ($self, $file) = @_;
    # return cached entry
    if ($self->{use_cache} == 2) {
        if (my $e = $self->{cache}->{$file}) {
            return $e->[1];
        }
    }
    # iterate
    foreach my $path (@{$self->{include_path}}) {
        my $filepath = $path . '/' . $file;
        if (my @st = stat $filepath) {
            if (my $e = $self->{cache}->{$file}) {
                return $e->[1]
                    if $st[9] == $e->[0];
            }
            open my $fh, "<$self->{open_layer}", $filepath
                or croak "failed to open:$filepath:$!";
            my $src = do { local $/; join '', <$fh> };
            close $fh;
            $self->parse($src);
            $self->{cache}->{$file} = [
                $st[9],
                my $f = $self->build(),
            ];
            return $f;
        }
    }
    die "could not find template file: $file\n";
}

sub render_file {
    my $self = shift;
    my $file = shift;
    $self->build_file($file)->(@_);
}

1;
