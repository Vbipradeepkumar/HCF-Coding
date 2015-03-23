<html>
<body bgcolor='honeydew'>
<h1 align="center"> IP Generation </h1>

<?php
$counter=0;
$j=1;
$file="/home/sseit/Desktop/randip.txt";
$handle2=fopen($file,'w');
$file1="/home/sseit/Desktop/samplerandip.txt";
$handle1=fopen($file1,'w');
echo "Source  IP and TTL";
echo"<br>";
for($i=0;$i<=50;$i++)
{
	if($i>=0 && $i<=50)		//generating class C address
	{
		$first=rand(192,223);
		$second=rand(0,225);
		$third=rand(10,225);
		$fourth=rand(1,254);
		$ttl=rand(98,128);
         	fwrite($handle1,"$first,$second,$third,$fourth:$ttl \n");
		while($i%5==0 && $counter<=10)
		{
		if($fourth>255)
		{
		$fifth=$fourth-$j;
		fwrite($handle2,"$first,$second,$third,$fifth:$ttl \n");
		echo "$first.$second.$third.$fifth:$ttl";
		echo "<br>";
		}
		else
		{
		$fifth=$fourth+$j;
		fwrite($handle2,"$first,$second,$third,$fifth:$ttl \n");
		echo "$first.$second.$third.$fifth:$ttl";
		echo "<br>";
		}
		$j=$j+3;
		$counter++;
		}
		fwrite($handle2,"$first,$second,$third,$fourth:$ttl \n");
		echo "<br>";
		echo "$first.$second.$third.$fourth:$ttl";
		echo"<br>";
		$counter=0;
		$j=1;
	} 
	/*else if($i>100 && $i<=150)	//generating class B address
	{
		$first=rand(128,191);
		$second=rand(0,225);
		$third=rand(10,225);
		$fourth=rand(1,254);
		$ttl=rand(34,64);
		fwrite($handle1,"$first,$second,$third,$fourth:$ttl \n");
		while($i%10==0 && $counter<=5)
		{
		$fifth=$fourth+$j;
		//echo "$j";
		fwrite($handle2,"$first,$second,$third,$fifth:$ttl \n");
		echo "<br>";
		echo "$first.$second.$third.$fifth:$ttl";
		echo "<br>";
		$j++;
		$counter++;
		}
		fwrite($handle2,"$first,$second,$third,$fourth:$ttl \n");
		echo "<br>";
		echo "$first.$second.$third.$fourth:$ttl";
		echo"<br>";
		$counter=0;
		$j=1;
	} 
	else {			//generating class A address

		$first=rand(1,127);
		$second=rand(0,225);
		$third=rand(10,225);
		$fourth=rand(1,254);
		$ttl=rand(225,255);
		fwrite($handle1,"$first,$second,$third,$fourth:$ttl \n");
		while($i%10==0 && $counter<=5)
		{
		$fifth=$fourth+$j;
		//echo "$j";
		fwrite($handle2,"$first,$second,$third,$fifth:$ttl \n");
		echo "<br>";
		echo "$first.$second.$third.$fifth:$ttl";
		echo "<br>";
		$j++;
		$counter++;
		}
		fwrite($handle2,"$first,$second,$third,$fourth:$ttl \n");
		echo "<br>";
		echo "$first.$second.$third.$fourth:$ttl";
		echo"<br>";
	}*/
}
?>
