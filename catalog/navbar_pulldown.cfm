<cfinclude template = "../queries/qrynavstyle.cfm">
<cfinclude template = "../queries/qrynavtop.cfm">

<cfif qryNavTop.recordcount GT 0>
<cfinclude template = "generatemnucss.cfm">
<cfinclude template = "generatesubmnucss.cfm">

<div class="navbar_wrapper" align="right" style="width: 100%">
<div class="navbar_menu">
<cfmenu
	name="navmenu"
	type="horizontal"
	selectedFontColor="#qryNavStyle.mfonthovercolor#"
	fontColor="#qryNavStyle.mfontcolor#">

	<!---Loop over common navigation top level--->
	<cfloop query = "qryNavTop">
		<cfinclude template = "../queries/qrysubmenus.cfm">
		
        <cfif request.use_urlrewrite IS 'Yes'>
    		<cfset myhref = "#request.absolutepath##qryNavTop.urlrw#">    
        <cfelse>
			<cfset myhref = "#qryNavTop.linkurl#">
		</cfif>

		<cfmenuitem name="item#qryNavTop.id#" 
		display="#linktitle#" 
		href="#myhref#" 
		target="#qryNavTop.LinkTarget#">
		
		<cfloop query = "qrysubmenus">
   			<cfinclude template = "../queries/qrysubmenus2.cfm">
			<cfif request.use_urlrewrite IS 'Yes'>
				<cfset myhref = "#request.absolutepath##qrysubmenus.urlrw#">
            <cfelse>
    			<cfset myhref = "#qrysubmenus.linkurl#">
			</cfif>

			<cfmenuitem name="item#qrysubmenus.id#" 
			display="#qrysubmenus.linktitle#" 
			href="#myhref#" 
			target="#qrysubmenus.LinkTarget#"
			style="text-align:left; #mychildstyles#">
			<cfloop query = "qrysubmenus2">
				<cfif request.use_urlrewrite IS 'Yes'>
					<cfset myhref = "#request.absolutepath##qrysubmenus2.urlrw#">
				<cfelse>	
					<cfset myhref = "#qrysubmenus2.linkurl#">
    			</cfif>
    	
                <cfmenuitem name="item#qrysubmenus2.id#" 
                display="#qrysubmenus2.linktitle#" 
                href="#myhref#" 
                target="#qrysubmenus2.LinkTarget#"
                style="text-align:left; #mychildstyles#">
                </cfmenuitem>		
			</cfloop>
            
			</cfmenuitem>		
		</cfloop>
		</cfmenuitem>			
    </cfloop>
</cfmenu>
</div>
</div>
</cfif>