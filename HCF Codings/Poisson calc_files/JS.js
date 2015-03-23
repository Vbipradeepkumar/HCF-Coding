// JScript File
/* 
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
DROPDOWN MENU FUNCTIONS
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
*/
var compatible = (document.getElementsByTagName && document.createElement);

if (compatible)
    {
    /* Create link for Default.aspx */
    document.write('<link rel="stylesheet" href="CSS/navstyles.css" />');
    
    /* Create links for web pages in first-level folders */
    document.write('<link rel="stylesheet" href="../CSS/navstyles.css" />');
	}
	
 /*
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
DROPDOWN MENU FUNCTIONS
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
*/
//Expand the dropdown menu
//NOTE:  The CSS table.navbar element affects the alignment of the dropdown
//  menu with its menu head.  It is important that the text-align style be
//  set to left -- that is, text-align: left.  Otherwise, the dropdown menu
//  may not be aligned with its heading.	
function expand(s)
{
  var td = s;
  var d = td.getElementsByTagName("div").item(0);
  
  //hideAllDivs()

  td.className = "menuHover";
  d.className = "menuHover";
  d.style.visibility='visible';
}

//Collapse the dropdown men.  Note: Sometimes, on Mozilla, this function does not 
//work correctly.  When called by onmouseout, the function sometimes doesn't fire.
function collapse(s)
{
  var td = s;
  var d = td.getElementsByTagName("div").item(0);

  td.className = "menuNormal";
  d.className = "menuNormal";
  
  hideAllDivs()
}

//Hide all Div blocks within dropdown menu.  This has the effect of hiding the
//dropdown menu.  This function is called by onmouseover to hide the dropdown 
//menu, in case the collapse function did not work.
function hideAllDivs()
{
  document.getElementById('mnuSampling').style.visibility='hidden';
  document.getElementById('mnuProbabilityDistributions').style.visibility='hidden';
  document.getElementById('mnuTools').style.visibility='hidden';
  document.getElementById('mnuTutorial').style.visibility='hidden'; 
  document.getElementById('mnuAPStatistics').style.visibility='hidden'; 
  document.getElementById('mnuBooks').style.visibility='hidden'; 
  document.getElementById('mnuCalc').style.visibility='hidden';  
  document.getElementById('mnuHelp').style.visibility='hidden'; 
}

/*
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
HEADER SEARCH CONTROL FUNCTIONS
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
*/
//Update the Go btnSearch command button tool tip, based on the 
//ddlSearch dropdown list	
function UpdateTooltip(s)
{
  /*
  var ddl = s;      //Identify dropdown list
  alert("0. Tooltip=");
  var btn = document.getElementByID("btnSearch");     //Identify command button
  alert("0.5 Tooltip=");
  
  alert("1. Tooltip=" + btn.tooltip.value);
  //Update tooltip
  if ddl.selectedIndex==0
  {
    //Show tool tip for Stat Trek
    btn.tooltip.value="Search Stat Trek web site";
  }
  else
  {
    //Show tool tip for web
    btn.tooltip.value="Search web"
  }
  alert("2. Tooltip=" + btn.tooltip.value);
  */
}

