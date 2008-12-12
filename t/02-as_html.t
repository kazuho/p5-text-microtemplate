use strict;
use warnings;
use Test::More tests => 1;
use Text::MicroTemplate qw(:all);

my $user = 'fo<o';
is eval as_html('hello <?= $user =>'), 'hello fo&lt;o';
