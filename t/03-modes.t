use strict;
use warnings;
use Test::More tests => 8;
use Text::MicroTemplate qw(:all);

# comment
is render_mt(<<'...')->as_string, "aaa\nbbb\n";
aaa
?# 
bbb
?# 
...
is render_mt('aaa<?# a ?>bbb')->as_string, "aaabbb";

# expression and raw expression
do {
    is render_mt('<?= $args ?>', 'foo<a')->as_string, 'foo&lt;a';
    is render_mt('<?=r $args ?>', 'foo<a')->as_string, 'foo<a';
    my $rs = encoded_string('foo<a');
    is render_mt('<?= $args ?>', $rs)->as_string, 'foo<a';
    is render_mt('<?=r $args ?>', $rs)->as_string, 'foo<a';
};
do {
    use utf8;
    is render_mt('あ<?= $args ?>う', 'い<')->as_string, 'あい&lt;う';
    my $rs = encoded_string('い<');
    is render_mt('あ<?= $args ?>う', $rs)->as_string, 'あい<う';
}
