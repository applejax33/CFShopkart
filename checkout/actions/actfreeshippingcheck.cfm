<!---Checks to see if this person is in a free shipping zone.  If they are then do not figure in shipping; set it to zero--->
<!---Store owner can ship the item how they see fit for free shipping--->

<cfquery name = "qryFreeZones" datasource="#request.dsn#">
SELECT * FROM shippingfreezones
</cfquery>

<cfloop query = "qryFreeZones">
	<!---If a match is found for the country and state, check to see if it's specific to a zip code/qryFreeZones.city--->
	<cfif form.ship_country IS qryFreeZones.Country>
		<cfif form.ship_state IS qryFreeZones.region>
			<cfif len(qryFreeZones.zipcode) IS 0 AND len(qryFreeZones.city) IS 0>
				<!---All places in this region/country get free shipping--->
				<cfset freeshipping = "Yes">
			</cfif>
			
			<!---If a qryFreeZones.zipcode is specified but no qryFreeZones.city then check to see if this person is ordering from that zip code--->
			<cfif len(qryFreeZones.zipcode) GT 0 and len(qryFreeZones.city) IS 0>
				<!---found a match so set freeshipping to yes--->
				<cfif qryFreeZones.zipcode IS form.ship_zip>
					<cfset freeshipping = "Yes">
				</cfif>
			</cfif>
			
			<!---If a qryFreeZones.city is specified but no qryFreeZones.zipcode then check to see if this person is ordering from that qryFreeZones.city--->
			<cfif len(qryFreeZones.zipcode) IS 0 and len(qryFreeZones.city) GT 0>
				<!---found a match so set freeshipping to yes--->
				<cfif qryFreeZones.city IS form.ShipCity>
					<cfset freeshipping = "Yes">
				</cfif>
			</cfif>
			
			<!---If both a qryFreeZones.city and qryFreeZones.zipcode need to match then check to see if this person is ordering from both--->
			<cfif len(qryFreeZones.zipcode) GT 0 and len(qryFreeZones.city) GT 0>
				<!---found a match so set freeshipping to yes--->
				<cfif qryFreeZones.city IS form.ShipCity AND qryFreeZones.zipcode IS form.ship_zip>
					<cfset freeshipping = "Yes">
				</cfif>
			</cfif>
		</cfif>
	</cfif>
</cfloop>
