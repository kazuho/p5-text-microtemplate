use strict;
use warnings;
use Test::More tests => 7;
use Text::MicroTemplate qw(:all);

# expr (expected behaviour from code)
do {
    my $y;
    is(as_html(<<'...', sub { $y = 1 })->as_string, "abc 1 def\n", 'multiline expr');
abc <?= 1
 $args->() ?> def
...
    ok $y;
};

# raw expr (expected behaviour from code)
do {
    my $y;
    is as_html(<<'...', sub { $y = 1 })->as_string, "abc 1 def\n", 'multiline rawexpr';
abc <?=r 1
 $args->() ?> def
...
    ok $y;
};

# automatic semicolon insertion
is as_html(<<'...')->as_string, "abc\n1\n-1\ndef\n", 'expr auto-sci';
abc
?= 1
?= -1
def
...
is as_html(<<'...')->as_string, "abc\n1\n-1\ndef\n", 'expr auto-sci';
abc
?=r 1
?=r -1
def
...

# no automatic semicolon insertion for code
is as_html(<<'...')->as_string, "abc\n0\ndef\n", 'no auto-sci for code';
abc
? my $a = 1
? - 1
?= $a
def
...
