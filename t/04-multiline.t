use strict;
use warnings;
use Test::More tests => 7;
use Text::MicroTemplate qw(:all);

# expr (expected behaviour from code)
do {
    my $called;
    my $foo = sub { $called = 1 };
    is eval as_html(<<'...'), "abc 1 def\n", 'multiline expr';
abc <?= 1
 $foo->() ?> def
...
    ok $called;
};

# raw expr (expected behaviour from code)
do {
    my $called;
    my $foo = sub { $called = 1 };
    is eval as_html(<<'...'), "abc 1 def\n", 'multiline rawexpr';
abc <?=r 1
 $foo->() ?> def
...
    ok $called;
};

# automatic semicolon insertion
is eval as_html(<<'...'), "1\n-1\n", 'expr auto-sci';
?= 1
?= -1
...
is eval as_html(<<'...'), "1\n-1\n", 'expr auto-sci';
?=r 1
?=r -1
...

# no automatic semicolon insertion for code
is eval as_html(<<'...'), "0\n", 'no auto-sci for code';
? my $a = 1
? - 1
?= $a
...
