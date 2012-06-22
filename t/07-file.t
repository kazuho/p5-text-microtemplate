use strict;
use warnings;
use Test::More tests => 26;
use Cwd qw(abs_path);
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
    is $mtf->render_file('wrapped.mt')->as_string, "abc\nheader\ndef\n\nfooter\nghi\n", 'wrapper';
    is $mtf->render_file('wrapped2.mt')->as_string, "abc\nheader\ndef\nheader\nghi\n\nfooter\njkl\n\nfooter\nmno\n", 'wrapper';
    is $mtf->render_file('wrapped3.mt')->as_string, "abc\nheader\n\ndef\n\nfooter\nghi\n", 'wrapper';
    is $mtf->render_file('wrapped_escape.mt')->as_string, "abc\nheader\n<def>\n\nfooter\nghi\n", 'wrapper';
    is $mtf->render_file('pod.mt')->as_string, "0\n", 'pod';
};

# accessor
do {
    my $mtf = Text::MicroTemplate::File->new(
        include_path => 't/07-file',
    );
    is_deeply $mtf->include_path, ['t/07-file'];
    is $mtf->open_layer, ':utf8';
    is $mtf->use_cache, '0';
    is $mtf->package_name, 'main';
};

# absolute path
do {
    my $mtf = Text::MicroTemplate::File->new();
    my $filepath = abs_path('t/07-file/hello.mt');
    is $mtf->render_file($filepath, 'John')->as_string, "Hello, John\n";
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

# open_layer (default=:utf8)
do {
    use utf8;
    my $mtf = Text::MicroTemplate::File->new(
        include_path => 't/07-file',
    );

    my $output = $mtf->render_file('konnitiwa.mt', '世界')->as_string;
    is $output, 'こんにちは、世界', 'utf8 flagged render ok';
    ok utf8::is_utf8($output), 'utf8 flagged output ok';
};

SKIP: {
    skip "Perl < 5.8.3 has bug around join.see perl583delta.pod", 2 if $] < 5.008003;
    # perl583delta.pod says
    # > join() could return garbage when the same join() statement was used to process 8 bit data having earlier processed UTF8 data, due to the flags on that statement's temporary workspace not being reset correctly. This is now fixed.
    # We hope, this is not critical issue in real world.
    no utf8;
    my $mtf = Text::MicroTemplate::File->new(
        include_path => 't/07-file',
        open_layer   => '',
    );

    my $output = $mtf->render_file('konnitiwa.mt', '世界')->as_string;
    is $output, 'こんにちは、世界', 'utf8 bytes render ok';
    ok !utf8::is_utf8($output), 'utf8 bytes output ok';
};
