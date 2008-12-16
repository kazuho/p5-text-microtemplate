use strict;
use warnings;
use Test::More tests => 7;

BEGIN {
    use_ok('Text::MicroTemplate::File');
};

do {
    my $mtf = Text::MicroTemplate::File->new(
        include_path => 't/07-file',
    );
    is $mtf->render_file('hello.mt', 'John')->as_string, "Hello, John\n";
    is $mtf->render_file('include.mt', 'John')->as_string, "head\nHello, John\n\nfoot\n";
    is $mtf->render_file('package.mt')->as_string, "main\n", 'default package';
};

do {
    my $mtf = Text::MicroTemplate::File->new(
        include_path => 't/07-file',
        package_name => 'foo',
    );
    is $mtf->render_file('hello.mt', 'John')->as_string, "Hello, John\n";
    is $mtf->render_file('include.mt', 'John')->as_string, "head\nHello, John\n\nfoot\n";
    is $mtf->render_file('package.mt')->as_string, "foo\n", 'package';
};

