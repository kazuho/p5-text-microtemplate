use strict;
use warnings;
use Test::More tests => 4;
use Text::MicroTemplate;

sub foo { '<hr />' }

my $mt = Text::MicroTemplate->new(template => << '...');
abc
?= foo()
def
? 
? 
ghi
...
my $code = eval $mt->code();
ok !$@, $mt->code();
my $got = $code->();
is $got, "abc\n&lt;hr /&gt;\ndef\nghi\n";

$mt = Text::MicroTemplate->new(escape_func => undef);
$mt->parse(<<'...');
abc
?= foo()
def
...
$code = eval $mt->code();
ok !$@, $mt->code();
$got = $code->();
is $got, "abc\n<hr />\ndef\n";
