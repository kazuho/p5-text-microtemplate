use strict;
use warnings;
use Test::More tests => 2;

use Text::MicroTemplate;

my $mt = Text::MicroTemplate->new(template => << '...');
1
2<? if (1) { ?>Hello<? } ?>3
<? if (1) { ?>World!<? } ?>4
5
...

my $code = eval $mt->code;
ok !$@, $mt->code;

my $got = $code->();
is $got, "1\n2Hello3\nWorld!4\n5\n";
