use strict;
use warnings;
use Test::More tests => 5;
use Text::MicroTemplate qw(:all);

sub html {
    render_mt('<?= $_[0] ?>', @_)->as_string
}

is html('&'), '&amp;';
is html('>'), '&gt;';
is html('<'), '&lt;';
is html(q{"}), '&quot;';
is html(q{'}), '&#39;';

