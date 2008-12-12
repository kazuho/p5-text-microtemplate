use strict;
use warnings;
use Test::More tests => 4;
use Text::MicroTemplate;

sub foo { '<hr />' }

my $mt = Text::MicroTemplate->new;
$mt->parse(<<'...');
?= foo()
...
my $code = eval $mt->code();
ok !$@, $mt->code();
my $got = $code->();
is $got, '&lt;hr /&gt;';

$mt = Text::MicroTemplate->new(escape_func => undef);
$mt->parse(<<'...');
?= foo()
...
$code = eval $mt->code();
ok !$@, $mt->code();
$got = $code->();
is $got, '<hr />';
