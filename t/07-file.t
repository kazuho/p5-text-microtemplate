use strict;
use warnings;
use Test::More tests => 12;
use File::Temp qw(tempdir);

BEGIN {
    use_ok('Text::MicroTemplate::File');
};

# simple test
do {
    my $mtf = Text::MicroTemplate::File->new(
        include_path => 't/07-file',
    );
    is $mtf->render_file('hello.mt', 'John')->as_string, "Hello, John\n";
    is $mtf->render_file('include.mt', 'John')->as_string, "head\nHello, John\n\nfoot\n";
    is $mtf->render_file('package.mt')->as_string, "main\n", 'default package';
};

# package name
do {
    my $mtf = Text::MicroTemplate::File->new(
        include_path => 't/07-file',
        package_name => 'foo',
    );
    is $mtf->render_file('hello.mt', 'John')->as_string, "Hello, John\n";
    is $mtf->render_file('include.mt', 'John')->as_string, "head\nHello, John\n\nfoot\n";
    is $mtf->render_file('package.mt')->as_string, "foo\n", 'package';
};

# cache
do {
    my $dir = tempdir(CLEANUP => 1);
    my $rewrite = sub {
        open my $fh, '>', "$dir/t.mt"
            or die "cannot open $dir/t.mt:$!";
        print $fh @_;
        close $fh;
    };
    my $mtf =Text::MicroTemplate::File->new(
        include_path => $dir,
        use_cache    => 1,
    );
    $rewrite->(1);
    is $mtf->render_file('t.mt')->as_string, '1', 'cache=1 read';
    is $mtf->render_file('t.mt')->as_string, '1', 'cache=1 retry';
    sleep 2;
    $rewrite->(2);
    is $mtf->render_file('t.mt')->as_string, '2', 'cache=1 update';
    is $mtf->render_file('t.mt')->as_string, '2', 'cache=1 update retry';
    # set mode to 2 and remove
    $mtf->use_cache(2);
    unlink "$dir/t.mt"
        or die "failed to remove $dir/t.mt:$!";
    is $mtf->render_file('t.mt')->as_string, '2', 'cache=2 read after cached';
};
