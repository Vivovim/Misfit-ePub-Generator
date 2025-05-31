#!/usr/bin/perl -w
## Sat Sep  3 15:21:34 PDT 2011
## Christopher ctopher@mac.com


use strict;

# my $file = "test.txt";

my @files = <*.data>;

foreach my $file (@files) {

	

open (FI, $file) || die "Sorry about that $file dave, things are fucked up. $!";

my ($fileo, $ext) = split(/\./, $file);
my $file_OUT = $fileo . ".rad";
open (FO, ">>$file_OUT") || die "Sorry about that $file dave, things are fucked up $!";

while (<FI>) {

	chomp;
	s/\s+/\ /g;
	next unless length;
	s/\'/\&rsquo;/g;

	s/
			( " (\\.|[^"\\] * )" )		

		/\&#8220;\;<em>$2<\/em>\&#8221;\;/sxg;







	print FO "<p class=\"body-style\">$_</p>\n\n";

	}

}


exit(0);


