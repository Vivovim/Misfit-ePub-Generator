#!/usr/bin/perl -w
## Wed Apr 13 23:12:25 MST 2016
## Christopher ctopher@mac.com

use strict;

print "Enter the epub name:";

my $file		= "";

chomp($file		= <STDIN>);

# zip -0Xq Dear_Goth.epub mimetype 
# zip -Xr9Dq Dear_Goth.epub *



system("zip -0Xq $file mimetype");
system("zip -Xr9Dq $file *");


exit(0);



