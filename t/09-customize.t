use strict;
use warnings;
use Test::More tests => 2;
use Text::MicroTemplate;

my $mt = Text::MicroTemplate->new(
    raw_expression_mark => '=',
    expression_mark => '=e',
    template => '<?= $_[0] ?> <?=e $_[0] ?>',
);

my $got = eval { $mt->build->('<foo>')->as_string };

ok !$@;
is $got => '<foo> &lt;foo&gt;';
