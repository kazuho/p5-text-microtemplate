use strict;
use warnings;
use Test::More;

BEGIN {
    eval { require IO::Scalar };
    if ($@) {
        plan( skip_all => "IO::Scalar is not installed" );
    } else {
        plan( tests => 2);
    }
}

use Text::MicroTemplate qw(:all);

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
