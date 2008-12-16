package Text::MicroTemplate::File;

use strict;
use warnings;
use Text::MicroTemplate;

our @ISA = qw(Text::MicroTemplate);

sub new {
    my $klass = shift;
    my $self = $klass->SUPER::new(@_);
    $self->{open_layer}   ||= ':utf8';
    $self->{include_path} ||= [ '.' ];
    unless (ref $self->{include_path}) {
        $self->{include_path} = [ $self->{include_path} ];
    }
    $self;
}

sub open_layer {
    my $self = shift;
    $self->{open_layer} = $_[0]
        if @_;
    $self->{open_layer};
}

sub build_file {
    my ($self, $file) = @_;
    foreach my $path (@{$self->{include_path}}) {
        if (open my $fh, "<$self->{open_layer}", $path . '/' . $file) {
            my $src = do { local $/; join '', <$fh> };
            close $fh;
            $self->parse($src);
            return $self->build();
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
