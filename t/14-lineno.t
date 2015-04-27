use strict;
use warnings;
use Test::More;
use Text::MicroTemplate qw(:all);

my $mt = Text::MicroTemplate->new(
    template => <<'***',
L001 <?= L001
L002
L003
=> L004 <?
L005
L006
=><? L007 ?>
? L008
? L009
?= L010
<?#
?> L(fixme-lineno-after-multiline-comment-becomens-incorrect)012
***
);
my $code = $mt->code;

my @lines = split /\n/, $code;
for (my $i = 0; $i < @lines; ++$i) {
    my $ok = 1;
    while ($lines[$i] =~ /L([0-9]{3})/g) {
        my $expected = $1;
        $ok = undef
            if $expected != $i + 1;
    }
    ok $ok, "line @{[$i + 1]}";
    diag $lines[$i]
        unless $ok;
}

done_testing;
