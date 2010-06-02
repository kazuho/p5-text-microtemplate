use strict;
use warnings;
use Test::More tests => 4;
use Text::MicroTemplate ':all';

my $warn = q[];
$SIG{__WARN__} = sub {
    $warn = $_[0];
};

is render_mt('')->as_string, '', 'empty template ok';
is $warn, q[], 'no warnings occurred ok';

$warn = '';
is render_mt('0')->as_string, '0', '"0" template ok';
is $warn, q[], 'no warnings occurred ok';
