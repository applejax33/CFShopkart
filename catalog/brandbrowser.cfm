<cfinclude template="../queries/qrybrands.cfm">

<form name = "brandbrowser" <cfoutput>action="index.cfm?action=browsebybrand&carttoken=#carttoken#"</cfoutput> method="post" class="browse_brands_form">
<center>
<select name="brandselected" class="browse_brands_dropdown">
	<option value="None">Select Brand</option>
	<cfoutput query = "qryBrands">
    	<cfif NOT len(trim(brand)) IS 0><option value="#brand#">#brand#</option></cfif>
    </cfoutput>
</select>
<p>
<input type = "submit" name = "brandsbutton" value="Show Items" class="browse_brands_button">
</center>
</form>




