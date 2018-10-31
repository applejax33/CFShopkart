<!---Top HTML--->
<cfprocessingdirective suppresswhitespace="yes">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />

<cfif request.stats_enabled IS 1>
	<cfinclude template = "stats/stats_log.cfm">
</cfif>

<cfif NOT isdefined('url.ItemID')>
<cfoutput><TITLE>#request.WebsiteTitle#.</TITLE></cfoutput>
</cfif>

<!---If an item is being loaded, load the meta data for that item--->
<cfif isdefined('url.itemid')>
	<cfif len(trim(url.itemid)) GT 0>
    	<cfif isnumeric(url.itemid)>
            <cfquery name = "qryItem" datasource="#request.dsn#">
            SELECT ProductName, BriefDescription
            FROM products
            WHERE itemid = <cfqueryparam value="#url.itemid#" cfsqltype="cf_sql_integer">
            </cfquery>
            
            <cfoutput query = "qryItem">
            <cfset brieftext = REReplace(BriefDescription, "<[^>]*>", "", "All")>
            <cfset pagetitle = "#ProductName# #brieftext#">
            <cfif len(pagetitle) GT 64>
                <cfset pagetitle = left(pagetitle, 63)>
            </cfif>
            <TITLE>#pagetitle#</TITLE>
            </cfoutput>
        </cfif>
	</cfif>
</cfif>

<cfoutput>
<META http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<META name="description" content="#request.MetaDescription#">
<META name="Keywords" Content="#request.MetaKeywords#">
</cfoutput>


<script type="text/javascript">
function screenDimensionsGet() {
var NS = (navigator.appName=="Netscape")?true:false; 
iWidth = (NS)?window.innerWidth:document.body.clientWidth; 
iHeight = (NS)?window.innerHeight:document.body.clientHeight; 
}

function pageY(elem) {
return elem.offsetParent ? (elem.offsetTop + pageY(elem.offsetParent)) : elem.offsetTop;
}
var buffer = 20; //scroll bar buffer

function resizeIframe() {
var height = document.documentElement.clientHeight;
height -= pageY(document.getElementById('ifm'))+ buffer ;
height = (height < 0) ? 0 : height;
document.getElementById('ifm').style.height = height + 'px';	
}

function printme(divid)
{
	var a = window.open('','','width=640,height=480,scrollbars=1');
	var elname = 'print_'+divid;
	a.document.open("text/html");
	a.document.write(document.getElementById(elname).innerHTML);
	a.document.close();
	a.print();
}

</script>

<script language="Javascript">
function PopupPic(sPicURL) { 
     window.open( "image-window.html?"+sPicURL, "",  
     "resizable=1,HEIGHT=200,WIDTH=200"); 
   } 
</script> 

<cfoutput>
	#request.CustomAffiliateCodeStartup#
</cfoutput>

<cfinclude template = "config/styles.cfm">

<cfif request.Width_Container LT 1>
<script LANGUAGE="JavaScript" type="text/javascript">
    if(screen.width < 801) {
      document.write('<style>.container {width: 100%;}</style>');
	  }

    if(screen.width > 800) {
      document.write('<style>.container {width: 85%;}</style>');
	  }
</script>
</cfif>

<cfoutput>
<cfif request.Width_Container GT 0>
	<style>
	.container {width: #request.Width_Container#;}
	</style>
</cfif>
</cfoutput>

<cfif request.themetouse NEQ '' AND request.themetouse NEQ 'A_Custom_Theme'>
   	<cfinclude template = 'themes/#request.themetouse#/#request.themetouse#.cfm'>       
</cfif>

<!---change the widgetcolumn display property to NONE if checkout actions are called--->
<cfif #action# IS "Checkout" OR #action# IS "Review" OR #action# IS "UpdateShipping" OR #action# IS "login" 
OR #action# IS "finalize" OR #action# IS "reviewredo" OR #action# IS "process">

<style>
	.widget_column {display: none;}
</style>

</cfif>

<!---load the global style sheet that has extra styles that loadstyles does not have--->
<link href="global.css" type="text/css" rel="stylesheet" />

<cfinclude template="customheadercode.cfm">

</HEAD>

<BODY leftmargin="0" topmargin="0" onResize="javascript: screenDimensionsGet();">
<cfinclude template = "custombodycode.cfm">

</cfprocessingdirective>

