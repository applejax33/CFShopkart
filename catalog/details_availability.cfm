<!---Displays item availability if ther eare no subs and inventory is turned on.--->
<cfset isstocked = 'Yes'>

<!---If there are no sub items then show the availability--->
<cfif qrySubs.recordcount IS 0>

<!---If inventory is turned on and the user wants to show how many are available then show
item availability here--->
<div class="availability_section">
<cfif request.EnableInventory IS 'Yes'>
	<cfif request.ShowItemAvailability IS 'Yes'>
		<span class="availability_label">
		Availability:</span>
		<cfif UnitsInStock LT 1 AND CanBackOrder IS 'No'><span class="OutOfStockMessage">Out of stock!</span><cfset isstocked = 'No'></cfif>	
		<cfif UnitsInStock LT 1 AND NOT CanBackOrder IS 'No'><b><span class="BackOrderMessage">Back Order Only</span> <cfif len(availability) GT 0><span class="availability_msg">- #availability#</span></cfif></b>
		<cfset isstocked = 'Yes'></cfif>	
		<cfif NOT UnitsInStock LT 1><span class="InStockMessage">In Stock</span> <cfif len(availability) GT 0><cfoutput><span class="availability_msg">- #availability#</cfoutput></cfif></span></font>
		</cfif>
		<cfset isstocked = 'Yes'>
	  </cfif>
</cfif>

<!---custom availability--->
<cfif NOT request.EnableInventory IS 'Yes'>
	<cfif NOT request.ShowItemAvailability IS 'No'>
		<cfoutput><span class="availability_label">Availability:</span> <span class="availability_msg">#availability#</span></cfoutput>
	</cfif>
</cfif>
</div>
</cfif><!---cfif for the subs--->




