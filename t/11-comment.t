use strict;
use warnings;
use Test::More tests => 2;
use Text::MicroTemplate ':all';

my $warn = q[];
$SIG{__WARN__} = sub {
    $warn = $_[0];
};

is render_mt(<<'EOT')->as_string, "abc\n", 'empty template ok';
? if (1) { # comment
abc
? } # comment 2
EOT

is $warn, q[], 'no warnings occurred ok';
