<cfswitch expression="#request.navmenutype#">
	<cfcase value = 'default'>
		<cfinclude template = "catalog/DefaultNavbar.cfm">
	</cfcase>
	<cfcase value = 'HTML'>
    	<cfif NOT fileexists('#request.catalogpath#docs#request.bslash#navigation.cfm')>
        	<cffile action="copy" source="#request.catalogpath#catalog#request.bslash#DefaultNavbar.cfm" destination="#request.catalogpath#docs\navigation.cfm">
        </cfif> 
		<cfinclude template = "docs/navigation.cfm">
	</cfcase>
	<cfcase value = 'simple'>
		<cfinclude template = "catalog/navbar_basic.cfm">
	</cfcase>
	<cfcase value = 'flash'>
		<script type="text/javascript" src="scripts/ActiveContentDropDownWide.js"></script>
	    <script type="text/javascript" src="scripts/FlashFix.js"></script>
    
		<cfinclude template = "catalog/loadflashnav.cfm">
	</cfcase>
	<cfcase value = 'PullDown'>
		<cfinclude template = "catalog/navbar_pulldown.cfm">
	</cfcase>   
</cfswitch>


