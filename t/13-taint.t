#!perl -T
use strict;
use warnings;
use Test::More tests => 8;

BEGIN {
    use_ok('Text::MicroTemplate::File');
};

{
    chmod 0600, map { /\A (.*) \z/xms; $1  } <t/07-file/*.mt>;
}

my $mtf = Text::MicroTemplate::File->new(
    include_path => 't/07-file',
);
is $mtf->render_file('hello.mt', 'John')->as_string, "Hello, John\n";
is $mtf->render_file('include.mt', 'John')->as_string, "head\nHello, John\n\nfoot\n";
is $mtf->render_file('package.mt')->as_string, "main\n", 'default package';
is $mtf->render_file('wrapped.mt')->as_string, "abc\nheader\ndef\n\nfooter\nghi\n", 'wrapper';
is $mtf->render_file('wrapped2.mt')->as_string, "abc\nheader\ndef\nheader\nghi\n\nfooter\njkl\n\nfooter\nmno\n", 'wrapper';
is $mtf->render_file('wrapped_escape.mt')->as_string, "abc\nheader\n<def>\n\nfooter\nghi\n", 'wrapper';
is $mtf->render_file('pod.mt')->as_string, "0\n", 'pod';
