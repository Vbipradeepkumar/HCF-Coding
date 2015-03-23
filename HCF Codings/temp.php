<?php
class Template {
public $temp;
function load($filepath)
	{
	$this->temp=file_get_contents($filepath);
}
function replace($var,$value)
	{
	$this->temp=str_replace("$$var",$value,$this->temp);
	}
function publish()
{
eval ("?>".$this->temp."<?");
}
}
?>
