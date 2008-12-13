use strict;
use warnings;
use Test::More tests => 2;
use Text::MicroTemplate qw(:all);

# expr (expected behaviour from code)
do {
    my $called;
    my $foo = sub { $called = 1 };
    is eval as_html(<<'...'), "abc 1 def\n";
abc <?= 1
 $foo->() ?> def
...
    ok $called;
};

# raw expr (expected behaviour from code)
do {
    my $called;
    my $foo = sub { $called = 1 };
    is eval as_html(<<'...'), "abc 1 def\n";
abc <?=r 1
 $foo->() ?> def
...
    ok $called;
};
