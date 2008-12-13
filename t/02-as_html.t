use strict;
use warnings;
use Test::More tests => 4;
use Text::MicroTemplate qw(:all);

do {
    my $user = 'fo<o';
    is eval as_html('hello <?= $user =>'), 'hello fo&lt;o';
};

do {
    local $@;
    ok ! defined eval as_html('hello <?= $nonexistent ?>');
    ok $@;
};

do {
    local $@;
    eval {
        eval as_html('hello <?= $nonexistent ?>')
            or die $@;
    };
    ok $@;
};
