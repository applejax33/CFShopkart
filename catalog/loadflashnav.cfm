<!---load sytles and menu items--->
<cfset colortopcount = 0>
<cfinclude template = "../queries/qrynavstyle.cfm">
<cfinclude template = "../queries/qrynavtop.cfm">
<!---Build style for each menu item--->
<!-- f-source menu navigation settings (search engine friendly) -->
<!-- Change these links and press F12 to test -->
<!-- saved from url=(0014)about:internet -->
<!-- The script to prevent blocking in IE and for other menu maintenance -->
<div id='menu' style='position:absolute; visibility:hidden;'>
<cfif NOT isdefined('pcount')>
	<cfset pcount = 1>
</cfif>

<cfloop query = "qryNavTop">
<cfset colortopcount = colortopcount + 1>
<cfset thiscolor = #qryNavTop.bgColor#>

<cfinclude template = "../queries/qrysubmenus.cfm">              

<cfif request.use_urlrewrite IS 'Yes'>
	<cfset myhref = "#request.absolutepath##qryNavTop.urlrw#">
<cfelse>
	<cfset myhref = "#qryNavTop.linkurl#">
</cfif>
         
<cfoutput>
  <div style="color: #thiscolor#;"><a href="#myhref#" target="#qryNavTop.LinkTarget#">&lt;b &gt;#qryNavTop.linktitle#&lt;/b &gt;</a></div></cfoutput>
  <cfif qrysubmenus.recordcount GT 0>
  <div class='submenu'>
	<cfloop query = "qrysubmenus">
		<cfinclude template = "../queries/qrysubmenus2.cfm">                  
		<cfif request.use_urlrewrite IS 'Yes'>
			<cfset myhref = "#request.absolutepath##qrysubmenus.urlrw#"> 
		<cfelse>
			<cfset myhref = "#qrysubmenus.linkurl#">
        </cfif>
    	<cfoutput>
        <div style="color: #thiscolor#;">
	        <a href="#myhref#" target="#qrysubmenus.LinkTarget#">#qrysubmenus.linktitle#</a></div>
		</cfoutput>
	    <cfset pcount = pcount + 1>
        <cfif qrysubmenus2.recordcount GT 0>
 			<div class='submenu'>
			<cfoutput query = "qrysubmenus2">                    
            <cfif request.use_urlrewrite IS 'Yes'>
            	<cfset myhref = "#request.absolutepath##qrysubmenus2.urlrw#">
			<cfelse>
    			<cfset myhref = "#qrysubmenus2.linkurl#">
            </cfif>
			<div style="color: #thiscolor#;"><a href="#myhref#" target="#qrysubmenus2.LinkTarget#">#qrysubmenus2.linktitle#</a></div>
			</cfoutput>
			</div>
		 </cfif>    
	 
</cfloop>
</div>
</cfif>
<cfset pcount = 1>
</cfloop>
<div><a href="##"></a></div>
</div>

<cfif qryNavStyle.FlashMenuStyle IS 'livemenu.swf'>
<cfoutput>
<script src="#request.absolutepath#scripts/activecontentdropdownwide.js" type="text/javascript"></script>
</cfoutput>
<!---load flash--->
<div id="f-source-menu" style="position:relative;top:0px;width:100%;padding:0px;">
 <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0" width="100%" height="48" >
    <param name="flash_component" value="livemenufull.swc" />
    <param name="movie" value="flashmenus/livemenu.swf" />
    <param name="quality" value="high" />
    <cfoutput query="qryNavStyle"><param name="FlashVars" value="flashlet={_subButtonTextColor:#sFontColor#,_subMenuColor:#sbackgroundcolor#,_subAnimation:true,_mainButtonHeight:34,showSearchField:false,searchFieldWidth:120,_TransparencyShadow:100,searchTextColor:##000000,mainSoundURL:'None',_subFont:'#mfontfamily#',_subButtonHeight:30,_menuColor:#mbackgroundcolor#,_mainAnimation:true,clickSoundURL:'None',_TransparencyMain:100,_mainButtonTextColor:#mfontcolor#,_mainFontSize:#mfontsize#,subSoundURL:'None',bg_Pic_URL:'none',_subMenuBorderColor:#mbordercolor#,_mainFont:'#mfontfamily#',_mainButWidthExt:25,_TransparencySub:100,xml_Path:'None',_subFontSize:#sfontsize#,searchFieldColor:##FFFFFF,searchButtonColor:##41861F}" />
    <param name="wmode" value="transparent" /></cfoutput>  
  </object>
  <noscript>
  <object>
    <a href="http://www.cfshopkart.com">Provided by CF Shopkart</a>.</a>
  </object>
  </noscript>
  <script type="text/javascript">var connected; if (connected){ Run_f_source_menu() }else{ alert("The page is not connected with script file ActiveContentDropDownWide.js") };function JSF(url){alert("javascript: "+url);}</script>
</div>
<!-- End of f-source menu code -->
</cfif>

<cfif qryNavStyle.FlashMenuStyle IS 'multicolor.swf'>
<cfoutput>
<script src="#request.absolutepath#scripts/activecontentdropdownwide.js" type="text/javascript"></script>
</cfoutput>
<!---Load flash file---> 
<cfset flashmoviewidth = replace(qryNavStyle.MenuWidth, "px", "", "ALL")>
<cfset flashmoviewidth = replace(qryNavStyle.MenuWidth, "%", "", "ALL")> 
<cfset flashmoviewidth = flashmoviewidth>
<cfset flashmenuwidth = '#flashmoviewidth#px'>
<center>
<div id="f-source-menu" style="position:relative;">
  <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="https://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0" width="100%" height="34" align="middle">
	<param name="flash_component" value="flashmenus/MulticolorMenuFull.swc">
	<param name="movie" value="flashmenus/multicolor.swf">
	<param name="wmode" value="transparent">
	<param name="quality" value="high">
<cfoutput query="qryNavStyle"><param name="FlashVars" value="flashlet={_subButtonTextColor:#sFontColor#,_shadowSize:4,_removeSubDelay:500,_mainButtonHeight:34,showSearchField:false,searchFieldWidth:0,_subHighlightColor:#shoverbackgroundcolor#,_mainHighlightColor:#mhoverbackgroundcolor#,_TransparencyShadow:20,searchTextColor:#mfontcolor#,mainSoundURL:'None',_subFont:'Arial',_subButtonHeight:25,clickSoundURL:'None',_TransparencyMain:#mnuTransparency#,_removeDividers:false,_mainButtonTextColor:#mfontcolor#,stretch_width_to:'#flashmenuwidth#',_mainFontSize:#mfontsize#,subSoundURL:'None',bg_Pic_URL:'None',_minSubWidth:#minSubWidth#,_mainFont:'#mfontfamily#',_mainButWidthExt:#CellWidth#,_TransparencySub:#submnuTransparency#,xml_Path:'None',_subFontSize:#sFontSize#,searchFieldColor:##FFFFFF}"></cfoutput>       
  </object>
  <noscript>
  <object>
	<a href="http://www.cfshopkart.com">Provided by CF Shopkart.</a>
  </object>
  </noscript>
  <script type="text/javascript">var connected; if (connected){ Run_f_source_menu() }else{ alert("The page is not connected with script file ActiveContentDropDown.js") };function JSF(url){alert("javascript: "+url);}</script>
</div>
</center>
<!-- End of f-source menu code -->
</cfif>