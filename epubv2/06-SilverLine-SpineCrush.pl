#!/usr/bin/perl -w
## Tue Jan  4 07:21:18 PST 2011
## Christopher neo@ctopher.me


use strict;



my @pages = ();


############################################




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

print "Make a choice and press enter:____";


chomp( my $answer = <STDIN>);


# print "$answer\n";


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
	push @pages, ($bookcover, $titlepage, $copyright);




} elsif ($answer == "1")  {


	$bookcover = "BookCover.xhtml";
	$titlepage = "Title.xhtml";
	$copyright = "Copyright.xhtml";
	$dedication = "Dedication.xhtml";

	push @pages, ($bookcover, $titlepage, $copyright, $dedication);


} elsif ($answer == "2") {


	$bookcover = "BookCover.xhtml";
	$titlepage = "Title.xhtml";
	$copyright = "Copyright.xhtml";
	$dedication = "Dedication.xhtml";
	$disclaimer = "Disclaimer.xhtml";

	push @pages, ($bookcover, $titlepage, $copyright, $dedication, $disclaimer);


} elsif ($answer == "3") {

	$bookcover = "BookCover.xhtml";
	$titlepage = "Title.xhtml";
	$copyright = "Copyright.xhtml";
	$dedication = "Dedication.xhtml";
	$disclaimer = "Disclaimer.xhtml";
	$forward = "Forward.xhtml";

	push @pages, ($bookcover, $titlepage, $copyright, $dedication, $disclaimer, $forward);


} elsif ($answer == "4") {
	$bookcover = "BookCover.xhtml";
	$titlepage = "Title.xhtml";
	$copyright = "Copyright.xhtml";
	$disclaimer = "Disclaimer.xhtml";

	push @pages, ($bookcover, $titlepage, $copyright, $disclaimer);
	

} elsif ($answer == "5") {
	$bookcover = "BookCover.xhtml";
	$titlepage = "Title.xhtml";
	$copyright = "Copyright.xhtml";
	$forward = "Forward.xhtml";


	push @pages, ($bookcover, $titlepage, $copyright, $forward);


} elsif ($answer == "6") {
	$bookcover = "BookCover.xhtml";
	$titlepage = "Title.xhtml";
	$copyright = "Copyright.xhtml";
	$dedication = "Dedication.xhtml";
	$forward = "Forward.xhtml";

	push @pages, ($bookcover, $titlepage, $copyright, $dedication, $forward);


} elsif ($answer == "7") {

	$bookcover = "BookCover.xhtml";
	$titlepage = "Title.xhtml";
	$copyright = "Copyright.xhtml";
	$disclaimer = "Disclaimer.xhtml";
	$forward = "Forward.xhtml";

	push @pages, ($bookcover, $titlepage, $copyright, $disclaimer, $forward);


}


############################################




my @files = <Chapter*.xhtml>;


push @pages, @files;




my @titles = ();
my @chapters = ();


foreach my $file (@pages) {

	open (FI, $file) || die "sorry dave it's 2011 $file $!";

	while (<FI>) {
#		next unless /<title>/;
#		chomp;
#		my $tile = $_;
#		$tile =~ s/(<title>)(.*)(<\/title>)/$2/i;

# begin Edit


		if (/<title>/) {
			chomp;
			my $title = $_;
			$title =~ s/(<title>)(.*)(<\/title>)/$2/i;
			push @titles, $title;
			
		}

		if (/Chapter/) {
			chomp;
			my $chapter = $_;

			$chapter =~ s/(<p class="chapter-number">)(.*)(<\/p>)/$2/i;
			print "$chapter\n";

			push @chapters, $chapter;
			}









# end edit
	
#		push @titles, $tile;
	}
}

my $isbn = "";

print "Enter your ISBN NUMBER: ";
chomp($isbn = <STDIN>);

my $title1 = "";
print "Enter your Book Title: ";
chomp($title1 = <STDIN>);



my $file_header = "<?xml version=\"1.0\"?>\n<ncx xmlns=\"http://www.daisy.org/z3986/2005/ncx/\" version=\"2005-1\" xml:lang=\"en\">\n<head>\n<meta content=\"$isbn\" name=\"dtb:uid\"/>\n<meta name=\"dtb:depth\" content=\"2\"/>\n<meta name=\"dtb:totalPageCount\" content=\"0\"/>\n<meta name=\"dtb:maxPageNumber\" content=\"0\"/>\n</head>\n\n";


my $file0 = "toc.ncx";
open (FO, ">>$file0") || die "Sorry Dave 2012 error! $file0 $!";




 
print FO "$file_header\n";


print FO "<docTitle><text>$title1</text></docTitle>\n";



print FO "<navMap>\n";



	my $count = "1";

foreach my $item (@pages) {

	my $title = shift(@titles);

	my $nav = "navpoint-" . "$count";
	print FO "<navPoint id=\"$nav\" playOrder=\"$count\">";

	if ($item =~ m/Chapter/) {
			my $chap = shift(@chapters);

			print "$chap" . "\ " . "$title\n";


			print FO "<navLabel><text>". $chap . "\ -\ " . $title . "</text></navLabel>";




		} else {


				print FO "<navLabel><text>" . $title . "</text></navLabel>";

		}










	print FO "<content src=\"" . $item ."\" />";
	print FO "<\/navPoint>\n";

	$count++;

}


print FO "</navMap>\n";

print FO "</ncx>";

print FO "\n\n";



close(FO);

exit(0);



