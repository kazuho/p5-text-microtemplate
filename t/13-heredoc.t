use strict;
use warnings;
use Test::More tests => 1;
use Text::MicroTemplate qw(:all);

is render_mt(<<'...')->as_string, "abc123\ndef\n";
abc<?= <<'EOT';
123
EOT
?>def
...
