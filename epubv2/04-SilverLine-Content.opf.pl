#!/usr/bin/perl -w
## Mon Jan  3 18:05:38 PST 2011
## Christopher neo@ctopher.me


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


if ($answer == "0") {

	$bookcover = "BookCover.xhtml";
	$titlepage = "Title.xhtml";
	$copyright = "Copyright.xhtml";
	push @xhtml, ($bookcover, $titlepage, $copyright);




} elsif ($answer == "1")  {


	$bookcover = "BookCover.xhtml";
	$titlepage = "Title.xhtml";
	$copyright = "Copyright.xhtml";
	$dedication = "Dedication.xhtml";

	push @xhtml, ($bookcover, $titlepage, $copyright, $dedication);


} elsif ($answer == "2") {


	$bookcover = "BookCover.xhtml";
	$titlepage = "Title.xhtml";
	$copyright = "Copyright.xhtml";
	$dedication = "Dedication.xhtml";
	$disclaimer = "Disclaimer.xhtml";

	push @xhtml, ($bookcover, $titlepage, $copyright, $dedication, $disclaimer);


} elsif ($answer == "3") {

	$bookcover = "BookCover.xhtml";
	$titlepage = "Title.xhtml";
	$copyright = "Copyright.xhtml";
	$dedication = "Dedication.xhtml";
	$disclaimer = "Disclaimer.xhtml";
	$forward = "Forward.xhtml";

	push @xhtml, ($bookcover, $titlepage, $copyright, $dedication, $disclaimer, $forward);


} elsif ($answer == "4") {
	$bookcover = "BookCover.xhtml";
	$titlepage = "Title.xhtml";
	$copyright = "Copyright.xhtml";
	$disclaimer = "Disclaimer.xhtml";

	push @xhtml, ($bookcover, $titlepage, $copyright, $disclaimer);
	

} elsif ($answer == "5") {
	$bookcover = "BookCover.xhtml";
	$titlepage = "Title.xhtml";
	$copyright = "Copyright.xhtml";
	$forward = "Forward.xhtml";


	push @xhtml, ($bookcover, $titlepage, $copyright, $forward);


} elsif ($answer == "6") {
	$bookcover = "BookCover.xhtml";
	$titlepage = "Title.xhtml";
	$copyright = "Copyright.xhtml";
	$dedication = "Dedication.xhtml";
	$forward = "Forward.xhtml";

	push @xhtml, ($bookcover, $titlepage, $copyright, $dedication, $forward);


} elsif ($answer == "7") {

	$bookcover = "BookCover.xhtml";
	$titlepage = "Title.xhtml";
	$copyright = "Copyright.xhtml";
	$disclaimer = "Disclaimer.xhtml";
	$forward = "Forward.xhtml";

	push @xhtml, ($bookcover, $titlepage, $copyright, $disclaimer, $forward);


}


# exit(0);

################################################################

my $export = "content.opf";
open (FO, ">>$export") || die "Sorry Dave export $export fails 2010 error $!";

print FO "<?xml version='1.0' encoding='utf-8'?>\n";

print FO "<package xmlns=\"http://www.idpf.org/2007/opf\" xmlns:dc=\"http://purl.org/dc/elements/1.1/\" version=\"2.0\" unique-identifier=\"uuid_id\">\n";

print FO "<metadata>";
print FO "<meta name=\"generator\" content=\"Misfit Epub Gen\"/>";

foreach my $element (@data) {
	my ($left, $right) = splice(@tags,0,2);
#		print "$left <-- left ----> $right\n";
		print FO "$left" . "$element" . "$right";
}
print FO "<meta name=\"cover\" content=\"Cover\"/>\n";


print FO "<\/metadata>\n";








my @chapters = <Chapter-*.xhtml>;
my @jpgs = <images/*.jpg>;
my @css = <*.css>;
my @spine = ();


foreach my $file_s (@chapters) {

	push @xhtml, $file_s;
}














print FO "<manifest>";

print FO "<item id=\"ncx\" href=\"toc.ncx\" media-type=\"application\/x-dtbncx+xml\"\/>";



foreach my $itema (@xhtml) {
	my ($ant, $rnt) = split(/\./, $itema);
	print FO "<item id=\"" . $ant . "\" href=\"" . $itema . "\" media-type=\"application\/xhtml+xml\" \/>\n";

	push @spine, $ant;
}


foreach my $el1 (@css) {
	my ($ant, $rnt) = split(/\./, $el1);
	print FO "<item id=\"" . $ant . "\" href=\"" . $el1 . "\" media-type=\"text\/css\" \/>\n";
}


foreach my $el2 (@jpgs) {
	my ($ant, $rnt) = split(/\./, $el2);
	my ($lead, $file) = split(/\//, $ant);

	print FO "<item id=\"" . $file . "\" href=\"" . $el2 . "\" media-type=\"image\/jpeg\" \/>\n";
}


print FO "<\/manifest>\n";

print FO "<spine toc=\"ncx\">\n";

foreach my $toc (@spine) {
	print FO "<itemref idref=\"" . $toc . "\" />";
}

print FO "<\/spine>\n";



print FO "<guide><reference href=\"$bookcover\" type=\"cover\" title=\"Cover\"/></guide> \n";

print FO "<\/package>\n";


exit(0);
