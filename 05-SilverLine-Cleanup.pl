#!/usr/bin/perl -w
## Sat Jan  8 08:53:59 PST 2011
## Christopher ctopher@mac.com


use strict;


my $file = "content.opf";
my $content = "";

open (FI, $file) || die "Sorry dave crash mode $file $!";


while(<FI>) {
#	chomp;
	s/<clear>//g;
	$content .= $_;

}

system("rm $file");


open (FO, ">>$file") || die "Sorry dave crash on $file output $!";

print FO "$content";
print FO "\n\n\n";

close(FO);

exit(0);


