use Benchmark;
$timestamp1=new Benchmark;
#print "this script took $start_run seconds";
%hash=();
%hash1=();
@initialTTL=(30,32,64,128,255);
$counter=0;
$LOGFILE = "/home/sseit/Desktop/june02/capture.txt";
open(LOGFILE) or die("Could not open log file.");
foreach $line (<LOGFILE>) {
    chomp ($line);
    ($src, $ttl1) = split(' ',$line);
    $hash{$src}=$ttl1;
   # print $hash{$srcip};
}
foreach $src (sort keys %hash) {
   $finalttl=$hash{$src};
   #print $finalttl;
   for($i=0;$i<=$#initialTTL && $counter==0 ;$i++) {
        if($finalttl==" ") {
	  exit(); 
        } else {
        }
      	if($initialTTL[$i]>$finalttl) {
            $counter++;
	    $initTTL=$initialTTL[$i];
	    $hs=$initTTL-$finalttl;
	    $hash1{$src}=$hs;
            } else {
        }
    }
    $counter=0;
}
#print %hash1;
close(LOGFILE);
$LOGFILE1 = "/home/sseit/Desktop/june02/trace1.txt";
open(LOGFILE1) or die("Could not open log file.");
open (MYFILE, '>>result.txt');
foreach $line (<LOGFILE1>) {
    chomp ($line);
    ($no, $time, $srcip, $dstip, $protocol,
         $ttl, $srport, $dstport) = split(' ',$line);
        for($i=0;$i<=$#initialTTL;$i++) {
        if($ttl==" ") {
          $timestamp2=new Benchmark;
          $run_time=timediff($timestamp2, $timestamp1);
          print "this script took", timestr($run_time);
          exit();
        } else {
        }
	if($initialTTL[$i]>$ttl) {
            #print $ttl;
	    $initTTL1=$initialTTL[$i];
            $hc=$initTTL1-$ttl;            #print $hc;
             $counter1++;
            #print $hc;
 	    #%hash1+=($srcip,$hc);	
            if(exists($hash1{$srcip})) {
                 $hs1=$hash1{$srcip};
                 #print $hs1;  
            } else {
                 $hash1{$srcip}=$hc;
	         $hs1=$hash1{$srcip};
                 #print $hs1;  
            }
            if($hc eq $hs1) {
      		#print "packet accepted\n";
       		print MYFILE "Packet Accepted\n";
            } else {
                #print "packet spoofed\n";
                print MYFILE "Packet Spoofed\n";
                print time - $^T;
            }
      	} else {
        }

    #print "$srcip\n";
   
    }
}
#print %hash1;
$end_run=time();
$run_time=$end_run - $start_run;
print "this script took $run_time seconds";
close (MYFILE); 
close(LOGFILE1);
