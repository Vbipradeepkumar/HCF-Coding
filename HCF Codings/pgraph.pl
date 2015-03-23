#!/usr/bin/perl
# Plot-graph - Plot with Grace
# Author: Didier Gonze
# Updated: 27/6/2004

####################################################################

$template="/home/sseit/template.eps";

&ReadArguments;

&SetParameters;

&ReadData;

&AxesAndFrame;

&PlotGraph;


################################################################
### Read arguments from the command line

sub ReadArguments {

$commandline="./pgraph.pl";
$ok=0;
$verbo=0;
$infile = "";
$outfile = "";
$xsc=0;
$ysc=0;
$solidline=1;
$dot=0;
$dotsize=8;
$xlog=0;$ylog=0;
$xtics=5;
$ytics=5;
$notshow=0;
$xdec=1;
$ydec=1;
$xcol=1;
$ycol[1]=2;
$nycol=1;
$coloration=0;
$daylength=24;
$photoperiod=0.5;
$hl="";
$vl="";
$fbox=0;
$sep="\\s+";  # separator = one (or several) tab or space 
$xgrid=0;
$ygrid=0;
$scale=1;
$histo=0;
$histobarwidth=10;
$histobarfill=1;
$histobarpos="min"; 

### command
foreach my $a (0..$#ARGV) {
	$commandline=$commandline." ".$ARGV[$a];
}
	
foreach my $a (0..$#ARGV) {

	### help
	if ($ARGV[0] eq "-h") {
		&PrintHelp;
	}

	### verbosity
	if ($ARGV[$a] eq "-v") {
		$verbo=1;
	}
	            
	### input file
	elsif ($ARGV[$a] eq "-i") {
		$ok=1;
		$infile = $ARGV[$a+1];
		if ($ARGV[$a+2] =~ /\d/ and $ARGV[$a+3] =~ /\d/) {
		   $xcol=$ARGV[$a+2];
		   $i=3;
		   $nycol=0;
		   while($ARGV[$a+$i] =~ /\d/ ){
			$nycol=$nycol+1;
			$ycol[$nycol]=$ARGV[$a+$i];
			$i=$i+1;
		   }
	       }
	}

	elsif ($ARGV[$a] eq "-tab") {
		$sep="\t";		# separator = exactly one tab
	}

	### output file 
	elsif ($ARGV[$a] eq "-o") {
		$outfile = $ARGV[$a+1];
	}
	
	elsif ($ARGV[$a] eq "-notshow") {
		$notshow = 1;
	}

	### scale
	elsif ($ARGV[$a] eq "-scale") {
		$scale = $ARGV[$a+1];
	}

	### xlog / ylog 
	elsif ($ARGV[$a] eq "-xlog") {$xlog=1;}
	elsif ($ARGV[$a] eq "-ylog") {$ylog=1;}

	### xsc / ysc 
	elsif ($ARGV[$a] eq "-xsc") {
		$xsc=1;
		$xscmin = $ARGV[$a+1];
		$xscmax = $ARGV[$a+2];
	}
	elsif ($ARGV[$a] eq "-ysc") {
		$ysc=1;
		$yscmin = $ARGV[$a+1];
		$yscmax = $ARGV[$a+2];
	}

	### xtics / ytics
	elsif ($ARGV[$a] eq "-xtics") {
		$xtics = $ARGV[$a+1];
	}
	elsif ($ARGV[$a] eq "-ytics") {
		$ytics = $ARGV[$a+1];
	}

	### xgrid / ygrid
	elsif ($ARGV[$a] eq "-xgrid") {
		$xgrid = 1;
	}
	elsif ($ARGV[$a] eq "-ygrid") {
		$ygrid = 1;
	}


	elsif ($ARGV[$a] eq "-xdec") {
		$xdec = $ARGV[$a+1];
	}
	elsif ($ARGV[$a] eq "-ydec") {
		$ydec = $ARGV[$a+1];
	}
	
	### symbol / line / histo
	elsif ($ARGV[$a] eq "-dot") {
	        $solidline=0;
		$dot=1;
		if ($ARGV[$a+1] =~ /\d/) {$dotsize = $ARGV[$a+1];}
	}

	elsif ($ARGV[$a] eq "-dotline") {
		$dot=1;
		if ($ARGV[$a+1] =~ /\d/) {$dotsize = $ARGV[$a+1];}
	}

	elsif ($ARGV[$a] eq "-color") {
		$coloration = 1;
	}

	elsif ($ARGV[$a] eq "-histo") {
		$histo = 1;
		if ($ARGV[$a+1] =~ /\d/) {$histobarwidth = $ARGV[$a+1];}
		if ($ARGV[$a+2] eq "nofill") {$histobarfill = 0;}
		if ($ARGV[$a+3] eq "min" or $ARGV[$a+3] eq "max" or $ARGV[$a+3] eq "mean") {$histobarpos = "$ARGV[$a+3]";}
	}
	
	### Vertical and horizontal lines

	elsif ($ARGV[$a] eq "-hl") {
		$hl = $ARGV[$a+1];
	}

	elsif ($ARGV[$a] eq "-vl") {
		$vl = $ARGV[$a+1];
	}

	elsif ($ARGV[$a] eq "-frame") {
		$fbox = 1;
	}

	### LD boxes:
	elsif ($ARGV[$a] eq "-ld") {
		$ld = 1;
		$dl = 0;
		if ($ARGV[$a+1] =~ /\d/) {$daylength = $ARGV[$a+1];}
		if ($ARGV[$a+2] =~ /\d/) {$photoperiod = $ARGV[$a+2];}
	}
	elsif  ($ARGV[$a] eq "-dl") { 
		$dl = 1;
		$ld = 0;
		if ($ARGV[$a+1] =~ /\d/) {$daylength = $ARGV[$a+1];}
		if ($ARGV[$a+2] =~ /\d/) {$photoperiod = $ARGV[$a+2];}
	}
}
		
if ($ok == 0) {
	die "STOP! You have to give the name of the input file (containing the data)\n";
}
		
if ($outfile eq "") {
	$outfile = "$infile.eps";
}

### titles and axes labels 
if ($commandline =~ m/-title\s([\s\w\d\.\:\_\/\\\(\)\,\=\+a-zA-Z0-9]+)/){$title = $1;};
if ($commandline =~ m/-subtitle\s([\s\w\d\.\:\_\/\\\(\)\,\=\+a-zA-Z0-9]+)/){$subtitle = $1;};
if ($commandline =~ m/-xlab\s([\s\w\d\.\:\_\/\\\(\)\,\=\+a-zA-Z0-9]+)/){$xlab = $1;};
if ($commandline =~ m/-ylab\s([\s\w\d\.\:\_\/\\\(\)\,\=\+a-zA-Z0-9]+)/){$ylab = $1;};
if ($commandline =~ m/-text\s([\s\w\d\.\:\_\/\(\)\,\=\+a-zA-Z0-9]+)/){$text = $1;};

# check if $infile exists:
open inf, $infile or die "STOP! File $infile not found\n";
if ($verbo==1) {print "Open input file: $infile\n";}
close inf;

}  # End of ReadArguments

##########################################################################################
### Print help

sub PrintHelp {
  open HELP, "| more";
  print <<EndHelp;
NAME
        pgraph.pl

DESCRIPTION
	Plot with Grace.

AUTHOR
	Didier Gonze (dgonze\@ucmb.ulb.ac.be)  

OPTIONS
	-i in_file_name # #
		Specify the input file containing the data 
		(format: tab-delimited). 

	-o out_file_name
		Specify the output file (format: eps).
		(default: in_file_name.eps). 
	-v 
		Verbosity: print detailed informations during the 
		process.
	       
	-h 
		Give help (print this message). This argument must be 
		the first.

	NB: FOR A COMPLETE LIST OF OPTIONS, SEE THE WEB-PAGE...

EXAMPLE
        pgraph -i datafile 1 2 -o dataplot.eps

EndHelp
close HELP;
exit "\n";

}  # End of PrintHelp

#################################################################################

sub SetParameters {

$today=`date`;
$today =~ s/MET DST //;
chomp $today;

}  # End of SetParameters

#################################################################################

sub ReadData {

my $i=0;
$data="";

### Determination of xmax, xmin, ymax, ymin:

	$xmin=9999999;
	$xmax=-9999999;
	$ymin=9999999;
	$ymax=-9999999;

	if($xsc==1){$xmin=$xscmin;$xmax=$xscmax;}
	else{
		open inf, $infile;
		foreach $line (<inf>){
	           if ($line ne "\n" and $line !~ /^#/){
		       chomp $line;
	    	       @line=split /$sep/,$line;
		       if ($line[$xcol-1]>$xmax){$xmax=$line[$xcol-1]} 
		       if ($line[$xcol-1]<$xmin){$xmin=$line[$xcol-1]}
		   }
		}
		close inf;
	}
	
	if($ysc==1){$ymin=$yscmin;$ymax=$yscmax;}
	else{
		open inf, $infile;
		foreach $line (<inf>){
		     for ($n=1;$n<=$nycol;$n++){
	                 if ($line ne "\n" and $line !~ /^#/){
			     chomp $line;
	    		     @line=split /$sep/,$line;
			     if ($line[$ycol[$n]-1]>$ymax){$ymax=$line[$ycol[$n]-1]} 
			     if ($line[$ycol[$n]-1]<$ymin){$ymin=$line[$ycol[$n]-1]}
			}
		     }
		close inf;
		}
	}

	if($xmax-$xmin==0){$xmin=$xmin-($xmin/10);$xmax=$xmax+($xmax/10); print "Warning: null x scale\n";}
	if($xmax==0 && $xmin==0){$xmax=0.1;$xmin=-0.1;}
	if($ymax-$ymin==0){$ymin=$ymin-($ymin/10);$ymax=$ymax+($ymax/10); print "Warning: null y scale\n";}
	if($ymax==0 && $ymin==0){$ymax=0.1;$ymin=-0.1;}


### Read and rescale data:

for ($n=1;$n<=$nycol;$n++){

	$i=0;
	$yc=$ycol[$n];
	$datano="%data no $n\n";
	if ($coloration==1)	{
		$color=&ColorCode($n);
		$setcolor="$color setrgbcolor";
		$data=$data."\n%data serie $n:\n$setcolor\n";
	}
	$data=$data."\n%data serie $n:\n";

	open inf, $infile;

	foreach $line (<inf>){

	if ($line ne "\n" and $line !~ /^#/){
	    $i=$i+1;
	    chomp $line;
	    @line=split /$sep/,$line;
	    
	    if (scalar @line < $yc || scalar @line < $xcol){
		$nc=scalar @line; die "STOP! Format problem in the inputfile ($infile contains only $nc columns)\n";
	    }
	    $x[$i] = $line[$xcol-1];
		
	    if ($xlog==1){
		if ($x[$i]==0){die "STOP! Cannot take log of 0 (in x data)\n";}
		$x[$i]=log($x[$i]);
		$x[$i]=sprintf("%.3f",$x[$i]);
	    }
	    $y[$i] = $line[$yc-1];
	    if ($ylog==1){
		if ($y[$i]==0){die "STOP! Cannot take log of 0 (in y data)\n";}
		$y[$i]=log($y[$i]);
		$y[$i]=sprintf("%.3f",$y[$i]);
	    }

	}

	close inf;

	}

	if($i==0){die "No valid data to plot!\n";}

	$imax=$i;

  if ($histo==0){           # normal plot (lines or dots)


	if ($solidline==1){     # lines plot
	    $firstpoint=1;
	    for($i=1;$i<=$imax;$i++){
		if ($x[$i] <= $xmax and $x[$i] >= $xmin and $y[$i] <= $ymax and $y[$i] >= $ymin and $firstpoint==0){
		   $px=&xscale($x[$i]);
		   $py=&yscale($y[$i]);
		   $data=$data."$px\t$py l\n";
		}
		elsif  ($x[$i] <= $xmax and $x[$i] >= $xmin and $y[$i] <= $ymax and $y[$i] >= $ymin and $firstpoint==1){
		   $px=&xscale($x[$i]);
		   $py=&yscale($y[$i]);
		   $data=$data."$px\t$py m\n";
		   $firstpoint=0;
		}
		else{
		   $firstpoint=1;
		}
	   }
	}
	
	if($dot==1){             # dots plot
           if ($solidline==1) {$data=$data."\ns\n";}
	   for($i=0;$i<=$imax;$i++){
	      if ($x[$i] <= $xmax and $x[$i] >= $xmin and $y[$i] <= $ymax and $y[$i] >= $ymin){
	         $px=&xscale($x[$i]);
	         $py=&yscale($y[$i]);
	         $data=$data."$dotsize $px\t$py fa\n";
	      }
	    }
	}

	
	if ($coloration==1)	{
		$data=$data."s\n0.000000 0.000000 0.000000 setrgbcolor\n";
	}
	
   }
   
   
   else{     # histogram plot

	if ($ymin<0){$yref=0; $hl=0}
	else {$yref=$ymin}
	
	$eofill="eofill";
	if ($histobarfill == 0){$eofill="";}

	for($i=1;$i<=$imax;$i++){
	
	 if($x[$i] >= $xmin and $x[$i] <= $xmax ){

           if($histobarpos eq "min"){
	     $xbarmin=&xscale($x[$i]);
	     $xbarmax=&xscale($x[$i])+$histobarwidth;
	   }
	   elsif($histobarpos eq "max"){
	     $xbarmin=&xscale($x[$i])-$histobarwidth;
	     $xbarmax=&xscale($x[$i]);
	   }
	   elsif($histobarpos eq "mean"){
	     $xbarmin=&xscale($x[$i])-($histobarwidth/2);
	     $xbarmax=&xscale($x[$i])+($histobarwidth/2);
	   }
	   
	   $ybarmin=&yscale($yref);
	   $ybarmax=&yscale($y[$i]);
	   
	   $data=$data."$xbarmin $ybarmin m\n$xbarmin $ybarmax l\n$xbarmax $ybarmax l\n$xbarmax $ybarmin l\n$xbarmin $ybarmin l\nclosepath\ngsave $eofill grestore\ns\n";	
	 }
       }

   }


}

### Vertical and horizontal lines:

if ($hl ne ""){
	$yl=&yscale($hl);
	$xlmin=&xscale($xmin);
	$xlmax=&xscale($xmax);
	$data=$data."$xlmin $yl m\n$xlmax $yl l\n";
}

if ($vl ne ""){
	$xl=&xscale($vl);
	$ylmin=&yscale($ymin);
	$ylmax=&yscale($ymax);
	$data=$data."$xl $ylmin m\n$xl $ylmax l\n";
}

### LD boxes:

if ($ld==1 || $dl==1){
	$xboxmin=&xscale($xmin);
	$xboxmax=&xscale($xmax);
	$yboxmin=&yscale($ymin);
	$yboxmax=&yscale($ymin)+35;
	$data=$data."$xboxmin $yboxmin m\n$xboxmin $yboxmax l\n$xboxmax $yboxmax l\n$xboxmax $yboxmin l\n$xboxmin $yboxmin l\ns\n";
#	$halfday=$daylength*0.5;
	$lightphase=$daylength*$photoperiod;
	$darkphase=$daylength-$lightphase;
	$zz=0;
	if ($ld==1){
		while ($xmin+$zz*$daylength+$lightphase < $xmax){
			$zz=$zz+1;
			$xboxmin=&xscale($xmin+($zz-1)*$daylength+$lightphase);
			if ($xmin+$zz*$daylength < $xmax){
				$xboxmax=&xscale($xmin+$zz*$daylength);
			}
			else{
				$xboxmax=&xscale($xmax);
			}
			$data=$data."$xboxmin $yboxmin m\n$xboxmin $yboxmax l\n$xboxmax $yboxmax l\n$xboxmax $yboxmin l\n$xboxmin $yboxmin l\nclosepath\ngsave eofill grestore\ns\n";	
		}
	}
	else{
		while ($xmin+$zz*$daylength < $xmax){
			$zz=$zz+1;
			$xboxmin=&xscale($xmin+($zz-1)*$daylength);
			if ($xmin+($zz-1)*$daylength+$darkphase < $xmax){
				$xboxmax=&xscale($xmin+($zz-1)*$daylength+$darkphase);
			}
			else{
				$xboxmax=&xscale($xmax);
			}
			$data=$data."$xboxmin $yboxmin m\n$xboxmin $yboxmax l\n$xboxmax $yboxmax l\n$xboxmax $yboxmin l\n$xboxmin $yboxmin l\nclosepath\ngsave eofill grestore\ns\n";	
		}
	}
}

close inf;

}   # End of ReadData

#################################################################################

sub AxesAndFrame {

### Axes labels:

$xticslabel="";
$xticsmajor="";
for($i=0;$i<=$xtics;$i++){
	$xticslab=$xmin+$i*($xmax-$xmin)/$xtics;
	$xdec=sprintf("%.0f",$xdec);
	$xticslab=sprintf("%.".$xdec."f",$xticslab);
	$xticspos=435+$i*(2115-435)/$xtics;
	$xticslabel=$xticslabel."$xticspos 323 m gsave $xticspos 323 translate 0 rotate 0 -20  m ($xticslab) CS ($xticslab) show grestore newpath\n";
	if ($xgrid==0){
		$xticsmajor=$xticsmajor."$xticspos 373 m\n$xticspos 393 l\n";
	}
	else {
		$xticsmajor=$xticsmajor."$xticspos 373 m\n$xticspos 1768 l\n";
	}
}
chomp $xticslabel;

$yticslabel="";
$yticsmajor="";
for($i=0;$i<=$ytics;$i++){
	$yticslab=$ymin+$i*($ymax-$ymin)/$ytics;
	$ydec=sprintf("%.0f",$ydec);
	$yticslab=sprintf("%.".$ydec."f",$yticslab);
	$yticspos=373+$i*(1768-373)/$ytics;
	$yticslabel=$yticslabel."397 $yticspos m gsave 397 $yticspos translate 0 rotate 0 -20  m ($yticslab) RJ ($yticslab) show grestore newpath\n";
	if ($ygrid==0){
		$yticsmajor=$yticsmajor."435 $yticspos m\n455 $yticspos l\n";
	}
	else{
		$yticsmajor=$yticsmajor."435 $yticspos m\n2115 $yticspos l\n";
	}
}
chomp $xticslabel;

### Frame box:

if($fbox==1){
	$framebox="85 120 m\n85 2050 l\n2300 2050 l\n2300 120 l\n85 120 l\n";
}
else{
	$framebox="%noframebox\n";
}


### Additional text:

@txt=split /,\s/, $text; 
for ($t=0; $t<$#txt+1; $t++){
	@tt=split /\s/, $txt[$t];
	$xtxt = $tt[0];
	$ytxt = $tt[1];
	if ($xtxt !~ /\d+/ or $ytxt !~ /\d+/){die "STOP! Incorrect text position.\n";}
	$ttt=2;
	$stxt="";
	while ($tt[$ttt] ne ""){
		$stxt=$stxt.$tt[$ttt]." ";
		$ttt++;
	}
	
	$addtext=$addtext."\nnewpath\n\/Helvetica-ISOLatin1 findfont 60 scalefont setfont\n1275 1818 m\ngsave\n$xtxt $ytxt translate\n0 rotate\n0 0  m\n($stxt) CS\n($stxt) show\ngrestore";
}

}  # End of AxesAndFrame

#################################################################################

sub xscale {

my ($z)=@_;

$x=($z-$xmin)*(2115-435)/($xmax-$xmin)+435;

return $x;

}


#################################################################################

sub yscale {

my ($z)=@_;

$y=($z-$ymin)*(1768-373)/($ymax-$ymin)+373;

return $y;


}


#################################################################################

sub ColorCode {

my ($no)=@_;

if ($no == 1) {$colorcode="0.000000 0.000000 0.000000"; }   	# black
elsif ($no == 2) {$colorcode="1.000000 0.000000 0.000000"; }   	# red
elsif ($no == 3) {$colorcode="0.000000 1.000000 0.000000"; }	# green
elsif ($no == 4) {$colorcode="0.000000 0.000000 1.000000"; }	# blue
elsif ($no == 5) {$colorcode="0.500000 0.5000000 0.000000"; } 	# darkgreen
elsif ($no == 6) {$colorcode="0.000000 0.500000 0.500000"; }	# darkblue
elsif ($no == 7) {$colorcode="0.500000 0.000000 0.500000"; } 	# violet
elsif ($no == 8) {$colorcode="0.333333 0.333333 0.333333"; }	# grey
elsif ($no == 9) {$colorcode="0.6000 0.2000 0.2000"; }			# purple
elsif ($no == 10){$colorcode="1.0000 1.0000 0.0000"; }			# yellow
elsif ($no == 11){$colorcode="1.0000 0.0000 1.0000"; } 			# rose
elsif ($no == 12){$colorcode="0.0000 1.0000 1.0000"; }			# magenta
else {$colorcode="0.000000 0.000000 0.000000"; }

return $colorcode;

}

#################################################################################

sub PlotGraph {

open template, $template or die "STOP! File $template not found\n";
if ($verbo==1) {print "Open template file: $template\n";}

open ouf, ">$outfile";
if ($verbo==1) {print "Creating output file: $outfile\n";}


foreach $line (<template>){
	$line =~ s/XXscale/$scale $scale scale/;
	$line =~ s/XXcreated/Created by Pgraph on $today/;
	$line =~ s/XXcommand/Command was: $commandline/;
	$line =~ s/XXdata/$data/;
	$line =~ s/XXframebox/$framebox/;
	$line =~ s/XXtitle/$title/;
	$line =~ s/XXsubtitle/$subtitle/;
	$line =~ s/XXxlab/$xlab/;
	$line =~ s/XXylab/$ylab/;
	$line =~ s/XXticsxlab/$xticslabel/;
	$line =~ s/XXticsylab/$yticslabel/;
	$line =~ s/XXticsxlines/$xticsmajor/;
	$line =~ s/XXticsylines/$yticsmajor/;
	$line =~ s/\%XXtext/$addtext/;
	
    print ouf $line;
}

close template;
close ouf;

print "File $outfile created\n";

if($notshow==0){
	`gs $outfile`;
}

if ($verbo==1) {print "It's finished\n";}

}


