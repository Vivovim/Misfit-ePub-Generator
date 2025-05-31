#!/usr/bin/perl -w
## Thu Sep  1 18:33:04 PDT 2011
## Christopher ctopher@mac.com


use strict;



my @files = <*.rad>;

	my $set = "00001";
	my @data = ();
	my @chaps = ();




mkdir("xhtml");



foreach my $file (@files) {

	open (FI, $file)  || die "Sorry Dave, HAL 9000 is out of memory again. $file $!";

		while (<FI>) {
		chomp;

		next unless length;

		push @data, $_;

	
		}









	my $out = "Chapter-";
	my $ext = ".xhtml";
	my $out_FILE = $out . $set . $ext;
	my $chapter_number = $out . $set;




	open (FO, ">>xhtml/$out_FILE") || die "Sorry Dave, file handler error out 2012, $out_FILE $!";


	print FO '<?xml version="1.0" encoding="utf-8"?>' . "\n";
	
	
	print FO '<html xmlns="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops" xml:lang="en" lang="en">' . "\n";
	
	
	
	

	
	
	
	
	
	print FO '<head>' . "\n";


	print FO '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />' . "\n";
	print FO '<title>' . $chapter_number . '</title>' . "\n";
	print FO '<link href="stylesheet.css" rel="stylesheet" type="text/css" />' . "\n";

	





	print FO '</head>' . "\n";
	print FO '<body>' . "\n\n<div>\n\n";






foreach my $item (@data) {

	print FO "$item\n";

}








print FO "</div>\n</body>\n</html>\n\n";

@data = ();

$set++;

}



