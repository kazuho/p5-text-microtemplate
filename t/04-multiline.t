use strict;
use warnings;
use Test::More tests => 4;
use Text::MicroTemplate qw(:all);

# expr (expected behaviour from code)
do {
    my $y;
    is(render_mt(<<'...', sub { $y = 1 })->as_string, "abc 0,1,2 def\n", 'multiline expr');
abc <?= join ",", 0,
$_[0]->(),
2 ?> def
...
    ok $y;
};

# automatic semicolon insertion
is render_mt(<<'...')->as_string, "abc\n1\n-1\ndef\n", 'expr auto-sci';
abc
?= 1
?= -1
def
...

# no automatic semicolon insertion for code
is render_mt(<<'...')->as_string, "abc\n0\ndef\n", 'no auto-sci for code';
abc
? my $a = 1
? - 1
?= $a
def
...
