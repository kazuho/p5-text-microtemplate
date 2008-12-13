use strict;
use warnings;
use Test::More tests => 4;
use Text::MicroTemplate qw(:all);

do {
    my $s = 'foo<a';
    is eval as_html('<?= $s ?>'), 'foo&lt;a';
    is eval as_html('<?=r $s ?>'), 'foo<a';
    my $rs = raw_string($s);
    is eval as_html('<?= $rs ?>'), 'foo<a';
    is eval as_html('<?=r $rs ?>'), 'foo<a';
};
