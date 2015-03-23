<?php
$line1=0;
$line2=0;
$values=array();
$handle = @fopen("/home/sseit/Desktop/txt/randip.txt", "r"); // Open file form read.
$handle1 = @fopen("/home/sseit/Desktop/txt/randresult.txt", "r");
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
//fclose($handle1);
// This array of values is just here for the example.
	//$graph->title->Set("bar chart in PHP using GD");
    $values = array($line1,$line2);
	 $x_fld = array('agg','agg1'); 

// Get the total number of columns we are going to plot

    $columns  = count($values);

// Get the height and width of the final image

    $width = 300;
    $height = 200;

// Set the amount of space between each column

    $padding = 5;

// Get the width of 1 column

    $column_width = $width / $columns ;

// Generate the image variables

    $im        = imagecreate($width,$height);
    $green = imagecolorallocate($im,0,255,0); 
    $gray_lite = imagecolorallocate ($im,0xee,0xee,0xee);
    $green = imagecolorallocate($im,0,255,0);
    $white     = imagecolorallocate ($im,0xff,0xff,0xff);
    
// Fill in the background of the image

    imagefilledrectangle($im,0,0,$width,$height,$white);
    
    $maxv = 0;

// Calculate the maximum value we are going to plot

    for($i=0;$i<$columns;$i++)$maxv = max($values[$i],$maxv);

// Now plot each column
        
    for($i=0;$i<$columns;$i++)
    {
        $column_height = ($height / 100) * (( $values[$i] / $maxv) *100);

        $x1 = $i*$column_width;
        $y1 = $height-$column_height;
        $x2 = (($i+1)*$column_width)-$padding;
        $y2 = $height;

        imagefilledrectangle($im,$x1,$y1,$x2,$y2,$green);

// This part is just for 3D effect

        imageline($im,$x1,$y1,$x1,$y2,$gray_lite);
        imageline($im,$x1,$y2,$x2,$y2,$gray_lite);
        imageline($im,$x2,$y1,$x2,$y2,$gray_dark);
	//imagestring($im,1,1,1,$x_fld[$i],$green);
	//imagestring( $im,2,$x-1,$y+10,$values[$i],$black);

    }

// Send the PNG header information. Replace for JPEG or GIF or whatever

    header ("Content-type: image/jpg");
ImageString ($im, 5, 5, 18, "PHP.About.com", $black); 
	
 imagepng($im);
	
?>
