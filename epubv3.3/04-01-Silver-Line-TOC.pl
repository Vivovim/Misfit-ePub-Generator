#!/usr/bin/perl -w
## Thu Sep  1 18:33:04 PDT 2011
## Christopher ctopher@mac.com


use strict;

my @pages = <Chapter*.xhtml>;


my @titles = ();
my @chapters = ();

my @group	= ();


foreach my $file (@pages) {


		my $tit	= "";
		my $chap	= "";

	open (FI, $file) || die "sorry dave it's 2011 $file $!";

	while (<FI>) {



		if (/<title>/) {
			chomp;
			my $title = $_;
			$title =~ s/(<title>)(.*)(<\/title>)/$2/i;
			push @titles, $title;
			
			$tit	= $title;
		}

		if (/Chapter/) {
			chomp;
			my $chapter = $_;

			$chapter =~ s/(<p class="chapter-number">)(.*)(<\/p>)/$2/i;
			# print "$chapter\n";

			push @chapters, $chapter;


			$chap	= $chapter;
			}



		if ($chap ne "" && $tit ne "") {
		my $href	= "<a href=\"" . $file . "\">";
		my $endhref	= "</a>";

		my $test	= join(" - ", $chap, $tit);

		my $var 	= $href . $test . $endhref;

		push @group, $var;

		}



	}
}




my @uniq	= ();
my %seen	= ();

foreach my $dat (@group) {

	unless ($seen{$dat}) {

		$seen{$dat} = 1;
		push @uniq, $dat;

		}


}


# foreach my $item (@uniq) {
# 	print "$item\n";
# }







	my @data = @uniq;

	my $dataout	= "toc.xhtml";


	my $out_FILE = $dataout;
	my $chapter_number	= "Table of Contents";




	open (FO, ">$out_FILE") || die "Sorry Dave, file handler error out 2012, $out_FILE $!";


	print FO '<?xml version="1.0" encoding="utf-8"?>' . "\n";




	print FO '<html xmlns="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops" xml:lang="en" lang="en">';



	print FO '<head>' . "\n";


	print FO '<meta charset="utf-8"/>' . "\n";

	print FO '<title>' . $chapter_number . '</title>' . "\n";
	print FO '<link href="stylesheet.css" rel="stylesheet" type="text/css" />' . "\n";


	print FO '</head>' . "\n";
	print FO '<body>' . "\n\n";
	
	print FO '<p class="chapter-title">Contents</p>' ."\n";

	print FO ' <nav epub:type="toc" id="toc">';
	print FO '<ol>';

	

	print FO '<li><a href="Title.xhtml">Title Page</a></li>' . "\n";

	print FO '<li><a href="Copyright.xhtml">Copyright</a></li>' . "\n";


#	print FO '<p><a href="Dedication.xhtml">Dedication</a></p>' . "\n";

#	print FO '<p><a href="Forward.xhtml">Forward</a></p>' . "\n";




foreach my $item (@data) {

	print FO "<li>$item</li>\n";

}



print FO '</ol>';

print FO '</nav>';

print FO "</body>\n</html>\n\n";












