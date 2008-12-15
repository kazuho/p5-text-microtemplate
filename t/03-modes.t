use strict;
use warnings;
use Test::More tests => 8;
use Text::MicroTemplate qw(:all);

# comment
is as_html(<<'...')->as_string, "aaa\nbbb\n";
aaa
?# 
bbb
?# 
...
is as_html('aaa<?# a ?>bbb')->as_string, "aaabbb";

# expression and raw expression
do {
    is as_html('<?= $args ?>', 'foo<a')->as_string, 'foo&lt;a';
    is as_html('<?=r $args ?>', 'foo<a')->as_string, 'foo<a';
    my $rs = encoded_string('foo<a');
    is as_html('<?= $args ?>', $rs)->as_string, 'foo<a';
    is as_html('<?=r $args ?>', $rs)->as_string, 'foo<a';
};
do {
    use utf8;
    is as_html('あ<?= $args ?>う', 'い<')->as_string, 'あい&lt;う';
    my $rs = encoded_string('い<');
    is as_html('あ<?= $args ?>う', $rs)->as_string, 'あい<う';
}
