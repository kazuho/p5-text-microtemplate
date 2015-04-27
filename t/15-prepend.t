use strict;
use warnings;
use Test::More tests => 1;

use Text::MicroTemplate qw(:all);

is(
    render_mt({
        prepend   => 'my $prepend = 1;',
        template  => '<?= $prepend ? "ok" : "failure" ?>',
    })->as_string,
    'ok',
    'prepending code',
);
