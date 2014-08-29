#!/usr/bin/perl
use strict;
use warnings;

our ($progname) = $0 =~ m#(?:.*/)?([^/]*)#;

sub show_usage {
    print STDERR "Error: $_[0]" . "\n\n";

    print STDERR "Usage:\n";
    print STDERR "- Convert ptt-crawler data format to json\n";
    print STDERR "cat some-ptt-article.txt | $progname > some-ptt-article.json\n";
    exit($_[1]);
}

my $line = 0;
my $is_footer = 0;
while (<>) {
    $line++;
    if ($_ =~ /^ 時間  (.*) /) {
        print "time: " . $1 . "\n";
    }
    if ($_ =~ /^ 標題  (.*) /) {
        print "title: " . $1 . "\n";
    }
    if ($_ =~ /^ 看板  (.*) /) {
        print "board: " . $1 . "\n";
    }
    if ($_ =~ /^ 作者  (.*) /) {
        print "author: " . $1 . "\n";
    }
    if ($is_footer || $_ =~ /.*※ 發信站.*/) {
        $is_footer = 1;
        print "footer: " . $_;
    } elsif ($line >= 6) {
        print "content: " . $_ ;
    }
}

exit (0);

