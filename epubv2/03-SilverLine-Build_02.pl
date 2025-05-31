#!/usr/bin/perl -w
## Thu Sep  1 18:33:04 PDT 2011
## Christopher neo@ctopher.me


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
	print FO '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">' . "\n";
	print FO '<html xmlns="http://www.w3.org/1999/xhtml">' . "\n";
	print FO '<head>' . "\n";


	print FO '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />' . "\n";
	print FO '<title>' . $chapter_number . '</title>' . "\n";
	print FO '<link href="stylesheet.css" rel="stylesheet" type="text/css" />' . "\n";

	print FO '<style type="text/css">' . "\n";


	print FO 'body,td,th {' . "\n";
	print FO '	font-family: "Times New Roman", Times, serif;' . "\n";
	print FO '	color: #000;' . "\n";
	print FO '}' . "\n";


	print FO 'body {' . "\n";
	print FO '	text-size: 62.5%;' . "\n";
	print FO '	background-color: #FFF;' . "\n";
	print FO '}' . "\n";

	print FO '</style>' . "\n";





	print FO '</head>' . "\n";
	print FO '<body xml:lang="EN-US">' . "\n\n<div>\n\n";






foreach my $item (@data) {

	print FO "$item\n";

}








print FO "</div>\n</body>\n</html>\n\n";

@data = ();

$set++;

}



