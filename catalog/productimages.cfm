<!---Load the images for this item into a table--->
<cfset WinWidth = 400>
<cfset WinHeight = 400>

<cfparam name = "iHeight" default="60">
<cfparam name = "iWidth" default="130">

<cfset request.baseURL = '#request.HomeURL#'>
<cfset request.imagesURL = '#request.HomeURL#photos/'>

<cfset imagetable = "">

<!---Order the images by height to determine the largest one then set height of the image window to that--->
<cfquery name = "qryTallestImage" dbtype="query">
SELECT * FROM qry_AProductImages ORDER BY MediumHeight DESC
</cfquery>

<cfquery name = "qryTallestNormalImage" dbtype="query">
SELECT * FROM qry_AProductImages ORDER BY iHeight DESC
</cfquery>

<cfoutput query = "qryTallestImage" maxrows="1">
	<cfset ImgHeight = #MediumHeight# + 10>
</cfoutput>

<cfoutput query = "qryTallestNormalImage" maxrows="1">
	<cfset WinHeight = #iHeight# + 10>
</cfoutput>

<!---Now do the same thing for width...get the widest one--->
<cfquery name = "qryWidestImage" dbtype="query">
SELECT * FROM qry_AProductImages ORDER BY MediumWidth DESC
</cfquery>

<cfquery name = "qryWidestNormalImage" dbtype="query">
SELECT * FROM qry_AProductImages ORDER BY iWidth DESC
</cfquery>

<cfoutput query = "qryWidestImage" maxrows="1">
	<cfset ImgWidth = #MediumWidth# + 10>
</cfoutput>

<cfoutput query = "qryWidestNormalImage" maxrows="1">
	<cfset WinWidth = #iWidth# + 10>
</cfoutput>

<cfoutput>
<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function PopupWin(mypage) {
var myname = 'ImageWindow';
var w = #WinWidth#;
var h = #WinHeight#;
var winl = (screen.width - #WinWidth#) / 2;
var wint = (screen.height - #WinHeight#) / 2;
winprops = 'height='+h+',width='+w+',top='+wint+',left='+winl+',scrollbars=1,resizable'
win = window.open(mypage, myname, winprops)
if (parseInt(navigator.appVersion) >= 4) { win.window.focus(); }
}
//  End -->
</script>
</cfoutput>

<cfif qry_AProductImages.recordcount IS 0>
	<cfset imagetable = imagetable & '<table width="300" border="0" cellspacing="0" cellpadding="4" align="middle"><tr><td align="center" valign="middle" height="200" class="Image_Window"><img src = "#request.secureURL#photos/medium/nopic.jpg"></td></tr></table>'>
</cfif>

<cfif qry_AProductImages.recordcount GT 0>

    <cfsavecontent variable="imagetable">
	<cfoutput query = "qry_AProductImages" maxrows="1">
    <table width="#ImgWidth#" border="0" cellspacing="0" cellpadding="4" align="center">
	<tr>
	<td align="center" valign="middle" height="#ImgHeight#" class="Image_Window">
	<input type = "hidden" value="#request.secureURL#photos/large/#iFileName#" name="LargeImage" id="LargeImage" />
	<a href = "javascript:PopupWin(document.getElementById('LargeImage').value);"><img src = "#request.secureURL#photos/medium/#iFileName#" name="ImageFilePic" id="ImageFilePic" border="0" style="cursor: pointer;"></a>
	</td></tr><tr><td><table>
	<tr>
	</cfoutput>
	<!---If there is more than one image for this item, display a row of the tiny thumbnails they can click on to get a better view--->
	<cfif qry_AProductImages.recordcount GT 1>
		<cfset piccount = 0>
		<cfoutput query = "qry_AProductImages">
		<cfset piccount = piccount + 1>
		<td class="Image_Window" height="#TinyHeight#">
        <img src="#request.secureURL#photos/tiny/#iFileName#" border="0" style="cursor:pointer;" onclick="document.getElementById('ImageFilePic').src='#request.secureURL#photos/medium/#iFileName#'; document.getElementById('LargeImage').value = '#request.secureURL#photos/large/#iFileName#'">
</td>
<cfif piccount IS 4>
	</tr><tr>
	<cfset piccount = 0>
</cfif>
		</cfoutput>
</cfif>
</tr></table></td></tr>
</table>
</cfsavecontent>
</cfif>