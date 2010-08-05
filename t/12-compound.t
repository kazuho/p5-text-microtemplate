use strict;
use warnings;
use Test::More tests => 2;

use Text::MicroTemplate;

my $mt = Text::MicroTemplate->new(template => << '...');
<? if (1) { ?>Hello<? } ?>
<? if (1) { ?>World!<? } ?>
...

my $code = eval $mt->code;
ok !$@, $mt->code;

my $got = $code->();
is $got, "Hello\nWorld!\n";
