use strict;
use warnings;
use Test::More tests => 3;
use Text::MicroTemplate qw(:all);

is(
    render_mt('hello <?= $_[0] ?>', 'fo<o')->as_string,
    'hello fo&lt;o',
);

do {
    local $@;
    my $s = 0;
    eval {
        render_mt('hello <?= $nonexistent ?>');
        $s = 1;
    };
    is $s, 0, 'die on access to nonexistent value';
    like $@, qr/ at line 1 .*$0 at line \d+/;
};
