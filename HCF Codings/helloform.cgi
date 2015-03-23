#!/usr/bin/perl
 print "Content-type: text/html\n\n";
 print "Hello World.\n";
 print "Heres the form info:<P>\n";
 my($buffer);
 my(@pairs);
 my($pair);
 read(STDIN,$buffer,$ENV{'CONTENT_LENGTH'});
 @pairs = split(/&/, $buffer);
 foreach $pair (@pairs)
   {
   print "$pair<BR>\n"
   }
print "<P>Note that further parsing is\n";
print "necessary to turn the plus signs\n";
print "into spaces and get rid of some\n";
print "other web encoding.\n";

	

#path to perl
#so output produces web page
#we believe in tradition

#various declarations


#POST method uses stdin
#Control/value pairs & delimited
#print each ctrl/value pair
