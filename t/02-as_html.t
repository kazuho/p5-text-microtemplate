use strict;
use warnings;
use Test::More tests => 4;
use Text::MicroTemplate qw(:all);

is(
    as_html('hello <?= $args->{user} ?>', { user => 'fo<o' })->as_string,
    'hello fo&lt;o',
);
is(
    as_html('hello <?= $args->{user} ?>', user => 'fo<o')->as_string,
    'hello fo&lt;o',
);

do {
    local $@;
    my $s = 0;
    eval {
        as_html('hello <?= $nonexistent ?>');
        $s = 1;
    };
    is $s, 0, 'die on access to nonexistent value';
    like $@, qr/ at line 1 .*$0 at line 19/;
};
