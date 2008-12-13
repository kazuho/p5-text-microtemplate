use strict;
use warnings;
use Test::More tests => 6;
use Text::MicroTemplate qw(:all);

do {
    my $s = 'foo<a';
    is eval as_html('<?= $s ?>'), 'foo&lt;a';
    is eval as_html('<?=r $s ?>'), 'foo<a';
    my $rs = raw_string($s);
    is eval as_html('<?= $rs ?>'), 'foo<a';
    is eval as_html('<?=r $rs ?>'), 'foo<a';
};

do {
    use utf8;
    my $s = 'い<';
    is eval as_html('あ<?= $s ?>う'), 'あい&lt;う';
    my $rs = raw_string($s);
    is eval as_html('あ<?= $rs ?>う'), 'あい<う';
}
