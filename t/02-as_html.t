use strict;
use warnings;
use Test::More tests => 1;
use Text::MicroTemplate qw(as_html);

my $user = 'fo<o';
is eval Text::MicroTemplate::as_html('hello <?= $user =>'), 'hello fo&lt;o';
