use strict;
use warnings;
use Test::More tests => 2;
use Text::MicroTemplate qw(:all);

is render_mt('<?= __PACKAGE__ ?>')->as_string, 'main', 'default package';
is(
    render_mt({
        package_name => 'foo',
        template     => '<?= __PACKAGE__ ?>',
    })->as_string,
    'foo',
    'explicit package',
);
