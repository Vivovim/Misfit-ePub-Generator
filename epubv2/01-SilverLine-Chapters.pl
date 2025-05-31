#!/usr/bin/perl -w
## Thu Sep  8 14:06:13 PDT 2011
## Christopher neo@ctopher.me

use strict;


my $file = <@ARGV>;

open (FI, $file) || die "Sorry dave, it's a bummer about $file $!";





my $num = "01";
my $fileout = "";



while(<FI>) {




	next unless length;
	chomp;

	if (/^##-->Here!/) { 
		$fileout = "Chapter-" . $num . ".data"; 
		$num++; 
	}

	open (FO, ">>$fileout") || die "Sorry Dave, choked on file with cigarette smoke in it. $fileout $!";



		my $answer = $_;
		if ($answer ne "##-->Here!") {
		print FO "$answer\n";

		}

	

}



