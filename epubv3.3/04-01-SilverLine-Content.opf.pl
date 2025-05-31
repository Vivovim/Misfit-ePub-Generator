#!/usr/bin/perl -w
## Mon Jan  3 18:05:38 PST 2011
## Christopher ctopher@mac.com


use strict;

my @tags = ();
my $file = "../resource/tag-data.txt";
open (FI, $file) || die "Sorry dave not 2010 anymore were in crash mode for 2012 $file $!";

while (<FI>) {
	chomp;
	my ($left, $right) = split(/\t/, $_);
	push @tags, $left, $right;
}


my $data_file = "../resource/data.txt";
my @data = ();
open (FIN, $data_file) || die "Sorry dave, no can do; crash mode $file, $!";

while (<FIN>) {
	chomp;
	push @data, $_;
}


### Date Functions #####

my ($sec, $min, $hour, $mday, $mon, $year) = gmtime();

$year += 1900;    # gmtime gives years since 1900
$mon  += 1;       # gmtime gives month as 0-11

my $iso_time = sprintf("%04d-%02d-%02dT%02d:%02d:%02dZ",
    $year, $mon, $mday, $hour, $min, $sec);



################################################################



print "Select the pages you want included in your epub doc: \n";


my %choices = (

	"0" => "Book Cover, Title Page, Copyright",
	"1" => "Book Cover, Title Page, Copyright, Dedication",
	"2" => "Book Cover, Title Page, Copyright, Dedication, Disclaimer",
	"3" => "Book Cover, Title Page, Copyright, Dedication, Disclaimer, Forward",
	"4" => "Book Cover, Title Page, Copyright, Disclaimer",
	"5" => "Book Cover, Title Page, Copyright, Forward",
	"6" => "Book Cover, Title Page, Copyright, Dedication, Forward",
	"7" => "Book Cover, Title Page, Copyright, Disclaimer, Forward"
);


my @key_choice = keys %choices;

my @sorter = sort { $a <=> $b } @key_choice;


foreach my $item (@sorter) {
	print "$item\t $choices{$item}\n";
}

print "Make a choice and press enter:";


chomp( my $answer = <STDIN>);




my @xhtml = ();

my $bookcover = "";
my $titlepage = "";
my $copyright = "";
my $dedication = "";
my $disclaimer = "";
my $forward = "";
my $toclistp = "";

if ($answer == "0") {

	$bookcover = "BookCover.xhtml";
	$titlepage = "Title.xhtml";
	$copyright = "Copyright.xhtml";
	$toclistp	= "toc.xhtml";

	push @xhtml, ($bookcover, $titlepage, $copyright, $toclistp);




} elsif ($answer == "1")  {


	$bookcover = "BookCover.xhtml";
	$titlepage = "Title.xhtml";
	$copyright = "Copyright.xhtml";
	$dedication = "Dedication.xhtml";
	$toclistp	= "toc.xhtml";

	push @xhtml, ($bookcover, $titlepage, $copyright, $toclistp, $dedication);


} elsif ($answer == "2") {


	$bookcover = "BookCover.xhtml";
	$titlepage = "Title.xhtml";
	$copyright = "Copyright.xhtml";
	$dedication = "Dedication.xhtml";
	$disclaimer = "Disclaimer.xhtml";
	$toclistp	= "toc.xhtml";

	push @xhtml, ($bookcover, $titlepage, $copyright, $toclistp, $dedication, $disclaimer);


} elsif ($answer == "3") {

	$bookcover = "BookCover.xhtml";
	$titlepage = "Title.xhtml";
	$copyright = "Copyright.xhtml";
	$dedication = "Dedication.xhtml";
	$disclaimer = "Disclaimer.xhtml";
	$forward = "Forward.xhtml";
	$toclistp	= "toc.xhtml";

	push @xhtml, ($bookcover, $titlepage, $copyright, $toclistp, $dedication, $disclaimer, $forward);


} elsif ($answer == "4") {
	$bookcover = "BookCover.xhtml";
	$titlepage = "Title.xhtml";
	$copyright = "Copyright.xhtml";
	$disclaimer = "Disclaimer.xhtml";
	$toclistp	= "toc.xhtml";

	push @xhtml, ($bookcover, $titlepage, $copyright, $toclistp, $disclaimer);
	

} elsif ($answer == "5") {
	$bookcover = "BookCover.xhtml";
	$titlepage = "Title.xhtml";
	$copyright = "Copyright.xhtml";
	$forward = "Forward.xhtml";
	$toclistp	= "Table-Of-Contents.xhtml";


	push @xhtml, ($bookcover, $titlepage, $copyright, $toclistp, $forward);


} elsif ($answer == "6") {
	$bookcover = "BookCover.xhtml";
	$titlepage = "Title.xhtml";
	$copyright = "Copyright.xhtml";
	$dedication = "Dedication.xhtml";
	$forward = "Forward.xhtml";
	$toclistp	= "Table-Of-Contents.xhtml";

	push @xhtml, ($bookcover, $titlepage, $copyright, $toclistp, $dedication, $forward);


} elsif ($answer == "7") {

	$bookcover = "BookCover.xhtml";
	$titlepage = "Title.xhtml";
	$copyright = "Copyright.xhtml";
	$disclaimer = "Disclaimer.xhtml";
	$forward = "Forward.xhtml";
	$toclistp	= "Table-Of-Contents.xhtml";

	push @xhtml, ($bookcover, $titlepage, $copyright, $toclistp, $disclaimer, $forward);


}


# exit(0);

################################################################

my $export = "content.opf";
open (FO, ">>$export") || die "Sorry Dave export $export fails 2010 error $!";

print FO "<?xml version='1.0' encoding='utf-8'?>\n";

print FO "<package xmlns=\"http://www.idpf.org/2007/opf\" version=\"3.0\" unique-identifier=\"BookID\" xml:lang=\"en\">\n";

print FO '<metadata xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:opf="http://www.idpf.org/2007/opf">';

print FO "<meta name=\"generator\" content=\"Misfit Epub Gen\"/>\n";

foreach my $element (@data) {
	my ($left, $right) = splice(@tags,0,2);
#		print "$left <-- left ----> $right\n";
		print FO "$left" . "$element" . "$right\n";
}


print FO '<meta property="dcterms:modified">' . $iso_time . '</meta>';





print FO "<\/metadata>\n";








my @chapters = <Chapter-*.xhtml>;
my @jpgs = <images/*.jpg>;
my @css = <*.css>;
my @spine = ();


foreach my $file_s (@chapters) {

	push @xhtml, $file_s;
}














print FO "<manifest>";




foreach my $itema (@xhtml) {
	my ($ant, $rnt) = split(/\./, $itema);

	if ($ant eq "toc") {

	print FO "<item id=\"" . $ant . "\" href=\"" . $itema . "\" media-type=\"application\/xhtml+xml\" properties=\"nav\" \/>\n";

	} else {

	print FO "<item id=\"" . $ant . "\" href=\"" . $itema . "\" media-type=\"application\/xhtml+xml\" \/>\n";

	push @spine, $ant;
	}
}


foreach my $el1 (@css) {
	my ($ant, $rnt) = split(/\./, $el1);
	print FO "<item id=\"" . $ant . "\" href=\"" . $el1 . "\" media-type=\"text\/css\" \/>\n";
}


foreach my $el2 (@jpgs) {
	my ($ant, $rnt) = split(/\./, $el2);
	my ($lead, $file) = split(/\//, $ant);

	print FO "<item id=\"" . $file . "\" href=\"" . $el2 . "\" media-type=\"image\/jpeg\" properties=\"cover-image\" \/>\n";
}


print FO "<\/manifest>\n";

print FO "<spine>\n";

foreach my $toc (@spine) {
	print FO "<itemref idref=\"" . $toc . "\" />\n";
}

print FO "<\/spine>\n";




print FO "<\/package>\n";


exit(0);
