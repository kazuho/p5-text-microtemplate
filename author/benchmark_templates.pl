#!/usr/bin/env perl

use strict;
use warnings;
use HTML::Template;
use HTML::Template::Pro;
use Template;
use Text::MicroTemplate::File;
use Config;
use FindBin '$Bin';

my @modules = qw(
    HTML::Template HTML::Template::Compiled HTML::Template::Pro
    Template
    Text::MicroTemplate
);

my $has_htc = eval "use HTML::Template::Compiled speed => 1; 1;";
push @modules, 'HTML::Template::Compiled' if $has_htc;

use Benchmark qw(timethese cmpthese);

printf "Perl/%vd (%s)\n", $^V, $Config{archname};
foreach my $module (@modules){
    print "$module/", $module->VERSION, "\n";
}

my @LANGUAGES = (
    { language => 'Perl', ll => 1 },
    { language => 'Ruby', ll => 1 },
    { language => 'Python', ll => 1 },
    { language => 'PHP', ll => 1 },
    { language => 'Java' },
    { language => 'C' },
    { language => 'C++' },
    { language => 'C#' },
    { language => 'VB' },
    { language => 'VB.NET' },
    { language => 'ASP.NET' },
    { language => 'Delphi' },
    { language => 'Erlang' },
    { language => 'Scala', ll => 1 },
    { language => 'Go' },
);
my $cache = shift @ARGV || 0;
 
my $mt = undef;
sub mt {
    my %args = (use_cache => $cache, include_path => ["$Bin/templates"]);
    if ($cache) {
        $mt ||= Text::MicroTemplate::File->new(%args);
    } else {
        $mt = Text::MicroTemplate::File->new(%args);
    }
 
    my $s = $mt->render_file(
        "small.mt",
        {
            page_title => 'LL Programming languages',
            languages => \@LANGUAGES,
        }
    )->as_string;
}
my $ht = undef;
sub ht {
    my %args = (
        filename => "$Bin/templates/small.ht",
        case_sensitive => 1,
        die_on_bad_params => 0,
        cache => $cache,
    );
    if ($cache) {
        $ht ||= HTML::Template->new(%args);
    } else {
        $ht = HTML::Template->new(%args);
    }
    $ht->param(
        page_title => 'LL Programming languages',
        languages => \@LANGUAGES,
    );
    my $s = $ht->output;
}
 
my $htc = undef;
sub htc {
    my %args = (
        filename => "$Bin/templates/small.ht",
        case_sensitive => 1,
        die_on_bad_params => 0,
        cache => $cache,
    );
    if ($cache) {
        $htc ||= HTML::Template::Compiled->new(%args);
    } else {
        $htc = HTML::Template::Compiled->new(%args);
    }
    $htc->param(
        page_title => 'LL Programming languages',
        languages => \@LANGUAGES,
    );
    my $s = $htc->output;
}
 
my $htp = undef;
sub htp {
    my %args = (
        filename => "$Bin/templates/small.ht",
        case_sensitive => 1,
        die_on_bad_params => 0,
        cache => $cache,
    );
    if ($cache) {
        $htp ||= HTML::Template::Pro->new(%args);
    } else {
        $htp = HTML::Template::Pro->new(%args);
    }
    $htp->param(
        page_title => 'LL Programming languages',
        languages => \@LANGUAGES,
    );
    my $s = $htp->output;
}
 
my $tt = undef;
sub tt {
    my %args = (
        INCLUDE_PATH => ["$Bin/templates"],
        CACHE_SIZE   => $cache ? undef : 0,
    );
    if ($cache) {
        $tt ||= Template->new(%args);
    } else {
        $tt = Template->new(%args);
    }
    $tt->process(
        "small.tt",
        {
            page_title => 'LL Programming languages',
            languages => \@LANGUAGES,
        },
        \my $out,
    ) or die $tt->error() . "\n";
}
 
# main
cmpthese timethese -1, {
    'MT'      => \&mt,
    'HT'      => \&ht,
    'HT::Pro' => \&htp,
    $has_htc ? ('HT::C'   => \&htc) : (),
    'TT'      => \&tt,
};

