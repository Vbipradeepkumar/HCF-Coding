<?php
//Setting the chart variables
$line1=0;
$line2=0;
$values=array();
$handle = @fopen("txt/randomspoofing.txt", "r"); // Open file form read.
$handle1 = @fopen("txt/bwlimitinginput.txt", "r");
$handle2 = @fopen("txt/Randspoof.txt", "r");

while (!feof($handle)) // Loop til end of file.
{
$buffer = fgets($handle, 4096); // Read a line
if(trim($buffer)=='') {
$values[]=$line1;
}
else 
{
$line1++;
}
}

//fclose($handle);
while (!feof($handle1)) // Loop til end of file.
{
$buffer1 = fgets($handle1, 4096); // Read a line
if(trim($buffer1)=='') {
$values[]=$line2;
}
else 
{
$line2++;
}
}

while (!feof($handle2)) // Loop til end of file.
{
$buffer2 = fgets($handle2, 4096); // Read a line
if(trim($buffer2)=='') {
$values[]=$line3;
}
else 
{
$line3++;
}
}
//fclose($handle1);
// This array of values is just here for the example.
	//$graph->title->Set("bar chart in PHP using GD");
    $values = array($line1,$line2,$line3);
	// $x_fld = array('agg','agg1'); 
	$columns  = count($values);

         
// Calculate the maximum value we are going to plot

   
$graphTitle = "Hop Count Inspection";
$xLabel 	= "Status";
$yLabel 	= "No. of Entries"; 
 
$data['Total No. of Packets - 190'] = $line1;
$data['Packets Accepted - 84'] = $line2;
$data['Packets Spoofed - 106'] = $line3;

 
//getting the maximum and minimum values for Y
//for($i=0;$i<$columns;$i++)$maxv = max($values[$i],$maxv);
$newData = $data;
asort($newData); 
 
//minimum
$places = strlen(current($newData));
$mod    = pow(10, $places-1);
$min    = $mod - current($newData); 
 
//maximum
$places = strlen(end($newData));
$mod    = pow(10, $places-1);
$max 	= $mod + end($newData); 
 
$yAxis 	= array("min"=>$min, "max"=>$max);

//getting the maximum and minimum values for Y
$newData = $data;
asort($newData);

//minimum
$places = strlen(current($newData));	//string length of first element in array. 		  so strlen(1) = 1;
$mod    = pow(10, $places-1); 			//raising that number minus 1 to the power of 10. so pow(10, 0) = 1;
$min    = $mod - current($newData); 	//subtracting that from the minimum. 			  so 1 - 1 = 0; <-your y-axis minimum 
 
//maximum
$places = strlen(end($newData));	    //strlen(25) = 2;
$mod    = pow(10, $places-1);		    //pow(10, 1) = 10;
$max 	= $mod + end($newData); 	 	//10 + 25 = 35; <-- your new y-axis maximum
 
//storing those min and max values into an array
$yAxis 	= array("min"=>$min, "max"=>$max);



//------------------------------------------------
// Preparing the Canvas
//------------------------------------------------
//setting the image dimensions
$canvasWidth  = 800;
$canvasHeight = 500;
$perimeter    = 50; 
 
//creating the canvas
$canvas = imagecreatetruecolor($canvasWidth, $canvasHeight); 
 
//allocating the colors
$white     = imagecolorallocate($canvas, 255, 255, 255);
$black     = imagecolorallocate($canvas, 0,0,0);
$yellow    = imagecolorallocate($canvas, 248, 255, 190);
$blue      = imagecolorallocate($canvas, 3,12,94);
$grey      = imagecolorallocate($canvas, 102, 102, 102);
$lightGrey = imagecolorallocate($canvas, 216, 216, 216); 
 
//getting the size of the fonts
$fontwidth  = imagefontwidth(2);
$fontheight = imagefontheight(2); 
 
//filling the canvas with light grey
imagefill($canvas, 0,0, $lightGrey);


//------------------------------------------------
// Preparing the grid
//------------------------------------------------
//getting the size of the grid
$gridWidth  = $canvasWidth  - ($perimeter*2);
$gridHeight = $canvasHeight - ($perimeter*2); 
 
//getting the grid plane coordinates
$c1 = array("x"=>$perimeter, "y"=>$perimeter);
$c2 = array("x"=>$gridWidth+$perimeter, "y"=>$perimeter);
$c3 = array("x"=>$gridWidth+$perimeter, "y"=>$gridHeight+$perimeter);
$c4 = array("x"=>$perimeter, "y"=>$gridHeight+$perimeter);

//------------------------------------------------
//creating the grid plane
//------------------------------------------------
imagefilledrectangle($canvas, $c1['x'], $c1['y'], $c3['x'], $c3['y'], $white);  
 
//finding the size of the grid squares
$sqW = $gridWidth/count($data);
$sqH = $gridHeight/$yAxis['max']; 

//------------------------------------------------
//drawing the vertical lines and axis values
//------------------------------------------------
$verticalPadding = $sqW/2;
foreach($data as $assoc=>$value)
{
	//drawing the line
	imageline($canvas, $verticalPadding+$c4['x']+$increment, $c4['y'], $verticalPadding+$c1['x']+$increment, $c1['y'], $black);
 
	//axis values
	$wordWidth = strlen($assoc)*$fontwidth;
	$xPos = $c4['x']+$increment+$verticalPadding-($wordWidth/2);
	ImageString($canvas, 2, $xPos, $c4['y'], $assoc, $black);
 
	$increment += $sqW;
}

//------------------------------------------------
//drawing the horizontel lines and axis labels
//------------------------------------------------
//resetting the increment back to 0
$increment = 0; 
 
for($i=$yAxis['min']; $i<$yAxis['max']; $i++)
{
 
	//main lines
 
		//often the y-values can be in the thousands, if this is the case then we don't want to draw every single
		//line so we need to make sure that a line is only drawn every 50 or 100 units. 
 
	if($i%$mod==0){
		//drawing the line
		imageline($canvas, $c4['x'], $c4['y']+$increment, $c3['x'], $c3['y']+$increment, $black);
 
		//axis values
		$xPos = $c1['x']-($fontwidth*strlen($i))-5;
		ImageString($canvas, 2, $xPos, $c4['y']+$increment-($fontheight/2), $i, $black);
 
	}
	//tics
	//these are the smaller lines between the longer, main lines.
	elseif(($mod/5)>1 && $i%($mod/5)==0)
	{
		imageline($canvas, $c4['x'], $c4['y']+$increment, $c4['x']+10, $c4['y']+$increment, $grey);
	}
	//because these lines begin at the bottom we want to subtract
	$increment-=$sqH;
}

//getting the size of the grid
$gridWidth  = $canvasWidth  - ($perimeter*2);
$gridHeight = $canvasHeight - ($perimeter*2);

//getting the grid plane coordinates
$c1 = array("x"=>$perimeter, "y"=>$perimeter);
$c2 = array("x"=>$gridWidth+$perimeter, "y"=>$perimeter);
$c3 = array("x"=>$gridWidth+$perimeter, "y"=>$gridHeight+$perimeter);
$c4 = array("x"=>$perimeter, "y"=>$gridHeight+$perimeter);

//imagefilledrectangle($canvas, $c1['x'], $c1['y'], $c3['x'], $c3['y'], $white);

//finding the size of the grid squares
$sqW = $gridWidth/count($data);
$sqH = $gridHeight/$yAxis['max'];





//------------------------------------------------
// Making the vertical bars
//------------------------------------------------
$increment = 0; 		//resetting the increment value
$barWidth = $sqW*.2; 	//setting a width size for the bars, play with this number
foreach($data as $assoc=>$value)
{
	$yPos = $c4['y']-($value*$sqH);
	$xPos = $c4['x']+$increment+$verticalPadding-($barWidth/2);
	imagefilledrectangle($canvas, $xPos, $c4['y'], $xPos+$barWidth, $yPos, $grey);
	$increment += $sqW;
}
	
	
//Graph Title
ImageString($canvas, 35, ($canvasWidth/2)-(strlen($graphTitle)*$fontwidth)/2, $c1['y']-($perimeter/2), $graphTitle, $green); 
 
//X-Axis
ImageString($canvas, 20, ($canvasWidth/2)-(strlen($xLabel)*$fontwidth)/2, $c4['y']+($perimeter/2), $xLabel, $green); 
 
//Y-Axis
ImageStringUp($canvas, 20, $c1['x']-$fontheight*3, $canvasHeight/2+(strlen($yLabel)*$fontwidth)/2, $yLabel, $green);


header("content-type: image/jpg");
imagejpeg($canvas);
imagedestroy($canvas);

?>

