use strict;
use warnings;
use Test::More tests => 5;
use Text::MicroTemplate qw(:all);

sub html {
    render_mt('<?- $_[0] ?>', @_)->as_string
}

is html('&'), '&';
is html('>'), '>';
is html('<'), '<';
is html(q{"}), '"';
is html(q{'}), "'";

