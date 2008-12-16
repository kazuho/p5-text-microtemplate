use strict;
use warnings;
use Test::More tests => 2;
use Text::MicroTemplate qw(:all);
use IO::Scalar;

my $w;
tie *STDERR, 'IO::Scalar', \$w;
my $out;
eval {
    $out = render_mt(<< '...', 1)->as_string;
hello
? my %h = @_;
world
...
};
is $out, "hello\nworld\n", 'output on warn';
like $w, qr/ at line 2 .* $0 at line \d+/, 'warn location';
