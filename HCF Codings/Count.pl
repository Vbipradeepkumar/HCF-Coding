#!/usr/bin/perl
use CGI ':standard';
use GD::Graph::bars;
#use strict;
$counter=0;
$counter1=0;
$LOGFILE ="/home/sseit/public_cgi/result.txt";
open(LOGFILE) or die("Could not open log file.");
foreach $line (<LOGFILE>) {
    chomp ($line);
        ($status) = split(',',$line);
         #print $status;
         if ($status eq "Packet Accepted") {
         $counter++;
         } else {
              $counter1++;
          }
}
#print "Packet Accepted Count :" . $counter . "\n";
#print "Packet Spoofed Count:" . $counter1 . "\n";
# Both the arrays should same number of entries.
my @data = (["Packet Accepted", "Packet Spoofed"],
            [$counter,$counter1]);

my $mygraph = GD::Graph::bars->new(500, 300);
$mygraph->set(
    x_label     => 'Packet Status',
    y_label     => 'Number of Packets',
    title       => 'Graph',
) or warn $mygraph->error;

my $myimage = $mygraph->plot(\@data) or die $mygraph->error;

print "Content-type: image/png\n\n";
print $myimage->png;
