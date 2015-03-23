#!/usr/bin/perl -w
# Change above line to point to your perl binary

use CGI ':standard';
use GD::Graph::bars;
use strict;

# Both the arrays should same number of entries.
my @data = (["Packet Accepted", "Packet Spoofed"],
            [27,73]);

my $mygraph = GD::Graph::bars->new(500, 300);
$mygraph->set(
    x_label     => 'Packet Status',
    y_label     => 'Number of Packets',
    title       => 'Graph',
) or warn $mygraph->error;

my $myimage = $mygraph->plot(\@data) or die $mygraph->error;

print "Content-type: image/png\n\n";
print $myimage->png;

