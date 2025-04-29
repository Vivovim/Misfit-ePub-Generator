# Misfit-ePub-Generator
Perl ePub Generator to create ePub from .TXT file. 


Epub scripts

this can be complex. you should have patience. (and troubleshooting skills)
put .pl scripts in home bin directory and run from shell of choice.
do not follow instructions as written use common sense when moving files
basic unix understanding is required, if you know what your doing be safe.

only works with utf-8 data files.
straiten quotes - make sure your data is clean 
zap gremlins - make sure your data is clean
make sure carriage returns are unix \n

bbedit helps a lot.

every chapter must start with chapter number \n chapter-title \n followed by the chapter.

Make sure that EVERY SINGLE " (double quote is closed with a match.) or edit code.

mkdir YOURBOOK.dir


create your text file with chapter markers 

##-->Here! 


in every place you want a new chapter including the first line of the file.

run 01-Silver-Line YOURFILE.txt
run 02-Silver-Line
run 03-Silver-Line

mkdir junk
mv *.rad junk/.
mv *.data junk/.
mv filename.txt #### someplace safe
rm -fR junk/  #### Delete the junk folder. it's toast.



mv xhtml OEBPS

mv contents of skeleton directory OEBPS into OEBPS

mv contents of skeleton directory into dir without moving OEBPS

edit each chapter xhtml by hand in xhtml with the following

<p class="body-style">Chapter One</p>

Change to:

<p class="chapter-number">Chapter One</p>

And. . .

<p class="body-style">The Long Road Home</p>

Change to:

<p class="chapter-title">The Long Road Home</p>



in the <head> of the document change the xhtml title of the document to match chapter-title


<Title> _____ Change title here ______ </title>

The title should match the chapter-title css property (See css stylesheet) 

change the css body tag for chapter-number in html css to the right tag
change the css body tag for chapter-title in html css to the right tag


****** Warning
****** The word: "Chapter" is reserved and should only be used for class="chapter-number" in any of the text used for creating epub documents. This will throw errors if you fail to heed the warning. Beware.

untar resource.tar and move into dir above OEBPS


edit file with data.txt to right information leave file where is until you run 08

run 04-Silver-Line
run 05-Silver-Line
run 06-Silver-Line


put cover artwork as "Cover.jpg" in images directory. 

make sure there are no other files in the dir besides mime-type, OEBPS, META-INF


run 08-Silver-Line and put the name of the ePub file

be sure to run ePub check on your file to make sure it's valid.

ps. this doesn't work on Mac OS because of the ._DS_Store File getting included. pick a unix. or change code.


move .epub file out of dir and check for errors.

