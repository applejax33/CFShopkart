<!---Jon Wallen 07/24/2009: added actFigureSurcharges.  This file now creates a seperate variable to add in surcharges where appropriate--->	
<cfinclude template = "../queries/qrysurcharges.cfm">

<!---create variable to add to charges if necessary--->    
<cfset Cart.Surcharges = 0>

<cfoutput query = "qrySurcharges">

	<cfif NOT Region IS 'None'>    
    	<cfif Region IS #form.ship_state# and Country IS #form.ship_country#>
    		<cfset Cart.Surcharges = #SurCharge#>
    	</cfif>
    </cfif>
    
    <cfif Region IS 'None'>
    	<cfif Region IS 'None' AND Country IS '#form.ship_country#'>
    		<cfset Cart.Surcharges = #SurCharge#>
    	</cfif>
    </cfif>

</cfoutput>
