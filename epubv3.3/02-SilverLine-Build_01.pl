#!/usr/bin/perl -w
## Sat Sep  3 15:21:34 PDT 2011
## Christopher ctopher@mac.com


use strict;

# my $file = "test.txt";

my @files = <*.data>;


foreach my $file (@files) {

my @datax = ();
	

open (FI, $file) || die "Sorry about that $file dave, things are fucked up. $!";

my ($fileo, $ext) = split(/\./, $file);
my $file_OUT = $fileo . ".rad";
open (FO, ">>$file_OUT") || die "Sorry about that $file dave, things are fucked up $!";

my $count = 0;

while (<FI>) {

	chomp;
	s/\s+/\ /g;
	next unless length;
	s/\'/\&#8217;/g;

	s/
			( " (\\.|[^"\\] * )" )		

		/\&#8220\;<em>$2<\/em>\&#8221\;/sxg;


		if ($count == 0) {


		my $line = "<p class=\"chapter-number\">$_</p>\n\n";
		push @datax, $line;

} elsif ($count == 1) {

		my $line = "<p class=\"chapter-title\">$_</p>\n\n";
		push @datax, $line;

} else {

		my $line = "<p class=\"body-style\">$_</p>\n\n";
		push @datax, $line;

}
		$count++;



#	print FO "<p class=\"body-style\">$_</p>\n\n";

	}



foreach my $item (@datax) {

	print FO "$item";
}






}


exit(0);


