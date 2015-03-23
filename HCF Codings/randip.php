<?php
echo "Source IP and TTL";
echo "<br>";
for($i=0;$i<=500;$i++)
{
$first_number = rand(10,225);
$second_number = rand(0,225);
$third_number = rand(0,225);
$fourth_number = rand(1,254);
$random = rand(32,255);
echo "$first_number.$second_number.$third_number.$fourth_number : $random";
echo "<br>";
}
?>


