use strict;
use warnings;
use Test::More tests => 2;
use Text::MicroTemplate qw/render_mt/;

{
my $got = render_mt(<< '...')->as_string;
? $_mt->filter(sub { s/hello/hi/ })->(sub {
hello hyoshiok
? });
...
is $got, "hi hyoshiok\n";
}

{
my $got = render_mt(<< '...')->as_string;
? $_mt->filter(sub { $_[0] . 'roshi' })->(sub {
hi
? });
...
is $got, "hi\nroshi";
}
