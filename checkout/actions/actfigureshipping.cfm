<cfinclude template = "../queries/qryfedexsettings.cfm">
<cfinclude template = "../queries/qryupssettings.cfm">
<cfparam name = "doFallBackMethod" default="0">
<!---This code below calculates the shipping costs--->
<cfset Cart.TotalShippingCosts = 0>

<!---Check to see if they are in a free shipping zone--->
<cfset freeshipping = "No">
<cfinclude template = "actFreeShippingCheck.cfm">

<cfinclude template = "../queries/qrycompanyinfo.cfm">

<cfif freeshipping IS "Yes">
	<cfoutput query="qryCompanyInfo">
        <cfset ShipType='#ShippingType#'>
    </cfoutput>
</cfif>

<cfif freeshipping IS "No">
	<cfinclude template = "../queries/qrytablethree.cfm">
	<cfinclude template = "../queries/qrytablefour.cfm">
    <cfinclude template = "actfiguresurcharges.cfm">
	
	<cfset region='all'>
	<cfset country='United States'>
	
	<cfif doFallBackMethod IS 0>
        <cfoutput query="qryCompanyInfo">
            <cfset ShipType='#ShippingType#'>
        </cfoutput>
    </cfif>
    
    <cfif doFallBackMethod IS 1>
        <cfif qryCompanyInfo.ShippingType IS '10'>
		<cfoutput query = "qryUPSSettings">
            <cfset ShipType = '#qryFedexSettings.FallBackMethod#'>
        </cfoutput>        
        </cfif>
        <cfif qryCompanyInfo.ShippingType IS '11'>
		<cfoutput query = "qryFEDEXSettings">
            <cfset ShipType = '#qryFedexSettings.FallBackMethod#'>
        </cfoutput>
        </cfif>
    </cfif>
	
	<cfif #ShipType# IS 2>
	<!---This is for Shipping Based on Price - custom shipping table--->
	
	<cfset Shippingoptions = ''>
	<cfset ShippingCosts = ''>
	<cfset DefaultPrice = ''>
	<cfset DefaultService = ''>
	
	<!---Get the total of the items in the cart. --->
	<cfset TheCartPrice = '#ShippingTotal#'>
	
	<cfif NOT TheCartPrice IS '0'>
	
	<!---get the shipping types--->
	<cfquery name = "GetTypes" datasource="#request.dsn#">
	SELECT * FROM shippingtypes
	</cfquery>
	
	<!---Loop over the types and build the list--->
	<cfloop query = "GetTypes">
	
					<cfquery name = "GetCosts" datasource = "#request.dsn#">
					SELECT *
					FROM shippingtable1
					WHERE MinPrice <= #TheCartPrice# AND MaxPrice >= #TheCartPrice#
					AND ShippingType = '#GetTypes.ShippingType#'
					</cfquery>
					
					<cfset TheTotalForThisOption = 0>
					
					<cfoutput query = "GetCosts">
						<cfset TheTotalForThisOption = #Amount#>
					</cfoutput>
	
					<cfset Shippingoptions = ListAppend(Shippingoptions, GetTypes.ShippingType)>
					<cfset ShippingCosts = ListAppend(ShippingCosts, TheTotalForThisOption)>
					<cfset Cart.TotalShippingCosts = #ListGetAt(Shippingcosts, 1)#>
	</cfloop>
	
	<!---Now get a default value--->
	<cfset ServiceNames = '#Shippingoptions#'>
	<cfset ServicePrices = '#ShippingCosts#'>
	
	<cfloop index="mycount" from="1" To="#ListLen(Servicenames)#">
		<cfset ThisServiceName = ListGetAt(ServiceNames, mycount)>
		<cfset ThisPrice = ListGetAt(ServicePrices, mycount)>
	
		<!---Check to see if they are eligable for this shipping option.  If so, display it--->
			<cfquery name = "GetTypes" datasource="#request.dsn#">
			SELECT * FROM shippingtypes
			WHERE ShippingType = '#ThisServiceName#'
			</cfquery>
			
			<cfset TypeFor = 'All'>
			<cfoutput query = "GetTypes">
				<cfset TypeFor = '#AvailableTo#'>
			</cfoutput>
	
			<cfoutput>
			<cfif TypeFor IS 'All'>
				 <cfif LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #ThisPrice#>
					<cfset DefaultService = '#ThisServiceName#'>
				 </cfif>
				 <cfif NOT LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #DefaultPrice# & "," & #ThisPrice#>
					<cfset DefaultService = #DefaultService# & ',#ThisServiceName#'>
				 </cfif>
			</cfif>
			
			<cfif TypeFor IS 'CA' and form.ship_country IS 'CA'>
				 <cfif LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #ThisPrice#>
					<cfset DefaultService = '#ThisServiceName#'>
				 </cfif>
				 <cfif NOT LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #DefaultPrice# & "," & #ThisPrice#>
					<cfset DefaultService = #DefaultService# & ',#ThisServiceName#'>
				 </cfif>
			</cfif>
			
			<cfif TypeFor IS 'US' and form.ship_country IS 'US'>
				 <cfif LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #ThisPrice#>
					<cfset DefaultService = '#ThisServiceName#'>
				 </cfif>
				 <cfif NOT LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #DefaultPrice# & "," & #ThisPrice#>
					<cfset DefaultService = #DefaultService# & ',#ThisServiceName#'>				
				 </cfif>
			</cfif>
			
			<cfif TypeFor IS 'USCA' and form.ship_country IS 'US' OR TypeFor IS 'USCA' AND form.ship_country IS 'CA'>
				 <cfif LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #ThisPrice#>
					<cfset DefaultService = '#ThisServiceName#'>
				 </cfif>
				 <cfif NOT LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #DefaultPrice# & "," & #ThisPrice#>
					<cfset DefaultService = #DefaultService# & ',#ThisServiceName#'>
				 </cfif>
			</cfif>
			
			<cfif TypeFor IS 'INT' and NOT form.ship_country IS request.Country>
				 <cfif LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #ThisPrice#>
					<cfset DefaultService = '#ThisServiceName#'>
				 </cfif>
				 <cfif NOT LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #DefaultPrice# & "," & #ThisPrice#>
					<cfset DefaultService = #DefaultService# & ',#ThisServiceName#'>
				 </cfif>
			</cfif>	
			</cfoutput>		
	</cfloop>
	
	<cfif NOT ListLen('#DefaultPrice#') IS 0>
		<cfset Cart.TotalShippingCosts = ListGetAt(DefaultPrice, 1)>
		<cfset Cart.DefaultService = ListGetAt(DefaultService, 1)>
	</cfif>
	
	</cfif>
	</cfif>
	
	
	
	<cfif #ShipType# IS 3>
	
	<!---This is for Shipping Based on Percentage - custom shipping table--->
	
	<!---Set up our list variables.  This will be the content of the drop down box
		displayed when reviewing the order--->
	
	<cfset Shippingoptions = ''>
	<cfset ShippingCosts = ''>
	<cfset DefaultPrice = ''>
	<cfset DefaultService = ''>
	
	<cfset TheCartPrice = '#ShippingTotal#'>
	<cfif NOT TheCartPrice IS '0'>
	
	<!---get the shipping types--->
	<cfquery name = "GetTypes" datasource="#request.dsn#">
	SELECT * FROM shippingtypes
	</cfquery>
	
	<!---Loop over the types and build the list--->
	<cfloop query = "GetTypes">
	
					<cfquery name = "GetCosts" datasource = "#request.dsn#">
					SELECT *
					FROM shippingtable2
					WHERE MinPrice <= #TheCartPrice# AND MaxPrice >= #TheCartPrice#
					AND ShippingType = '#GetTypes.ShippingType#'
					</cfquery>
					
					<cfset TheTotalForThisOption = 0>
					
					<cfoutput query = "GetCosts">
						<cfset TheTotalForThisOption = #Amount# * #TheCartPrice#>
					</cfoutput>
	
					<cfset Shippingoptions = ListAppend(Shippingoptions, GetTypes.ShippingType)>
					<cfset ShippingCosts = ListAppend(ShippingCosts, TheTotalForThisOption)>
					<cfset Cart.TotalShippingCosts = #ListGetAt(Shippingcosts, 1)#>
	</cfloop>
	
	<!---Now get a default value--->
	<cfset ServiceNames = '#Shippingoptions#'>
	<cfset ServicePrices = '#ShippingCosts#'>
	
	<cfloop index="mycount" from="1" To="#ListLen(Servicenames)#">
		<cfset ThisServiceName = ListGetAt(ServiceNames, mycount)>
		<cfset ThisPrice = ListGetAt(ServicePrices, mycount)>
	
		<!---Check to see if they are eligable for this shipping option.  If so, display it--->
			<cfquery name = "GetTypes" datasource="#request.dsn#">
			SELECT * FROM shippingtypes
			WHERE ShippingType = '#ThisServiceName#'
			</cfquery>
			
			<cfset TypeFor = 'All'>
			<cfoutput query = "GetTypes">
				<cfset TypeFor = '#AvailableTo#'>
			</cfoutput>
	
			<cfoutput>
			<cfif TypeFor IS 'All'>
				 <cfif LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #ThisPrice#>
					<cfset DefaultService = '#ThisServiceName#'>
				 </cfif>
				 <cfif NOT LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #DefaultPrice# & "," & #ThisPrice#>
					<cfset DefaultService = #DefaultService# & ',#ThisServiceName#'>
				 </cfif>
			</cfif>
			
			<cfif TypeFor IS 'CA' and form.ship_country IS 'CA'>
				 <cfif LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #ThisPrice#>
					<cfset DefaultService = '#ThisServiceName#'>
				 </cfif>
				 <cfif NOT LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #DefaultPrice# & "," & #ThisPrice#>
					<cfset DefaultService = #DefaultService# & ',#ThisServiceName#'>
				 </cfif>
			</cfif>
			
			<cfif TypeFor IS 'US' and form.ship_country IS 'US'>
				 <cfif LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #ThisPrice#>
					<cfset DefaultService = '#ThisServiceName#'>
				 </cfif>
				 <cfif NOT LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #DefaultPrice# & "," & #ThisPrice#>
					<cfset DefaultService = #DefaultService# & ',#ThisServiceName#'>				
				 </cfif>
			</cfif>
			
			<cfif TypeFor IS 'USCA' and form.ship_country IS 'US' OR TypeFor IS 'USCA' AND form.ship_country IS 'CA'>
				 <cfif LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #ThisPrice#>
					<cfset DefaultService = '#ThisServiceName#'>
				 </cfif>
				 <cfif NOT LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #DefaultPrice# & "," & #ThisPrice#>
					<cfset DefaultService = #DefaultService# & ',#ThisServiceName#'>
				 </cfif>
			</cfif>
			
			<cfif TypeFor IS 'INT' and NOT form.ship_country IS request.Country>
				 <cfif LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #ThisPrice#>
					<cfset DefaultService = '#ThisServiceName#'>
				 </cfif>
				 <cfif NOT LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #DefaultPrice# & "," & #ThisPrice#>
					<cfset DefaultService = #DefaultService# & ',#ThisServiceName#'>
				 </cfif>
			</cfif>	
			</cfoutput>		
	</cfloop>
	
	<cfif NOT ListLen('#DefaultPrice#') IS 0>
		<cfset Cart.TotalShippingCosts = ListGetAt(DefaultPrice, 1)>
		<cfset Cart.DefaultService = ListGetAt(DefaultService, 1)>
	</cfif>
	
	</cfif>
	</cfif>
	
	
	
	<cfif #ShipType# IS 4>
	<cfset DefaultService = 'N/A'>
	<cfset Cart.DefaultService = 'N/A'>
	<!---This is for flat rate shipping for in state/province and out of state/province--->
	<cfoutput query = "qryCompanyInfo">

		<!---multiply by the total items in the cart.  Rate is applied to each item--->	
		<cfif #form.ship_state# IS '#qrycompanyinfo.state#'>
            <cfset Cart.TotalShippingCosts = #totalitemsincart# * #InStateShipRate#>
        </cfif>
        
        <cfif NOT #form.ship_state# IS '#qrycompanyinfo.state#'>
            <cfset Cart.TotalShippingCosts = #totalitemsincart# * #OutStateShipRate#>
        </cfif>
	
	</cfoutput>
	</cfif>
	
	
	<cfif #Shiptype# IS 5>
	<!---This is for Shipping Based on Weight - custom shipping table--->
	
	<!---Set up our list variables.  This will be the content of the drop down box
		displayed when reviewing the order--->
	
	<cfset Shippingoptions = ''>
	<cfset ShippingCosts = ''>
	<cfset DefaultService = ''>
	
	<!---find out what the weight of the cart is.  If it's 0 set it to 1 (minimum weight)--->
	<cfset TheCartWeight = '#Cart.TotalCartWeight#'>
	<cfif NOT TheCartWeight IS '0'>
	
	<!---get the shipping types--->
	<cfquery name = "GetTypes" datasource="#request.dsn#">
	SELECT * FROM shippingtypes
	</cfquery>
	
	<!---do a loop--->
	<cfloop query = "GetTypes">
	
					<cfquery name = "GetCosts" datasource = "#request.dsn#">
					SELECT *
					FROM shippingtable3
					WHERE MinWeight <= #TheCartWeight# AND MaxWeight >= #TheCartWeight#
					AND ShippingType = '#GetTypes.ShippingType#'
					</cfquery>
					
					<cfset TheTotalForThisOption = 0>
					
					<cfoutput query = "GetCosts">
						<cfset TheTotalForThisOption = #Amount#>
					</cfoutput>
	
					<cfset Shippingoptions = ListAppend(Shippingoptions, GetTypes.ShippingType)>
					<cfset ShippingCosts = ListAppend(ShippingCosts, TheTotalForThisOption)>
					<cfset Cart.TotalShippingCosts = #ListGetAt(Shippingcosts, 1)#>
					<cfset Cart.DefaultService = '#ListGetAT(Shippingoptions, 1)#'>
	
	</cfloop>
	</cfif>
	</cfif>
	
	
	<!---figure UPS Shipping--->
	<cfif #ShipType# IS 10>
	<cfinclude template = "actFigureUPS.cfm">
	</cfif>
	<!---End UPS Caclulations--->
	
	
	<!---figure FEDEX Shipping--->
	<cfif #ShipType# IS 11>
	<cfinclude template = "actfigurefedex.cfm">
	</cfif>
	<!---End FEDEX Caclulations--->
	
	<cfif #Shiptype# IS 6>
	<!---This is for Shipping Based on Quantity--->
	
	<cfset Shippingoptions = ''>
	<cfset ShippingCosts = ''>
	<cfset DefaultPrice = ''>
	<cfset DefaultService = ''>
	
	<!---find out what the weight of the cart is.  If it's 0 set it to 1 (minimum weight)--->
	<cfset TheTotalItemsInCart = '#ShippingItems#'>
	<cfif NOT TheTotalItemsInCart IS '0'>
	
	<!---get the shipping types--->
	<cfquery name = "GetTypes" datasource="#request.dsn#">
	SELECT * FROM shippingtypes
	</cfquery>
	
	<!---Loop over the types and build the list--->
	<cfloop query = "GetTypes">
	
					<cfquery name = "GetCosts" datasource = "#request.dsn#">
					SELECT *
					FROM shippingtable4
					WHERE MinQty <= #TheTotalItemsInCart# AND MaxQty >= #TheTotalItemsInCart#
					AND ShippingType = '#GetTypes.ShippingType#'
					</cfquery>
					
					<cfset TheTotalForThisOption = 0>
					
					<cfoutput query = "GetCosts">
						<cfset TheTotalForThisOption = #Amount#>
					</cfoutput>
	
					<cfset Shippingoptions = ListAppend(Shippingoptions, GetTypes.ShippingType)>
					<cfset ShippingCosts = ListAppend(ShippingCosts, TheTotalForThisOption)>
					<cfset Cart.TotalShippingCosts = #ListGetAt(Shippingcosts, 1)#>
	</cfloop>
	
	<!---Now get a default value--->
	<cfset ServiceNames = '#Shippingoptions#'>
	<cfset ServicePrices = '#ShippingCosts#'>
	
	<cfloop index="mycount" from="1" To="#ListLen(Servicenames)#">
		<cfset ThisServiceName = ListGetAt(ServiceNames, mycount)>
		<cfset ThisPrice = ListGetAt(ServicePrices, mycount)>
	
		<!---Check to see if they are eligable for this shipping option.  If so, display it--->
			<cfquery name = "GetTypes" datasource="#request.dsn#">
			SELECT * FROM shippingtypes
			WHERE ShippingType = '#ThisServiceName#'
			</cfquery>
			
			<cfset TypeFor = 'All'>
			<cfoutput query = "GetTypes">
				<cfset TypeFor = '#AvailableTo#'>
			</cfoutput>
	
			<cfoutput>
			
			<cfif TypeFor IS 'All'>
				 <cfif LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #ThisPrice#>
					<cfset DefaultService = '#ThisServiceName#'>
				 </cfif>
				 <cfif NOT LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #DefaultPrice# & "," & #ThisPrice#>
					<cfset DefaultService = #DefaultService# & ',#ThisServiceName#'>
				 </cfif>
			</cfif>
			
			<cfif TypeFor IS 'CA' and form.ship_country IS 'CA'>
				 <cfif LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #ThisPrice#>
					<cfset DefaultService = '#ThisServiceName#'>
				 </cfif>
				 <cfif NOT LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #DefaultPrice# & "," & #ThisPrice#>
					<cfset DefaultService = #DefaultService# & ',#ThisServiceName#'>
				 </cfif>
			</cfif>
			
			<cfif TypeFor IS 'US' and form.ship_country IS 'US'>
				It's equal!
				 <cfif LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #ThisPrice#>
					<cfset DefaultService = '#ThisServiceName#'>
				 </cfif>
				 <cfif NOT LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #DefaultPrice# & "," & #ThisPrice#>
					<cfset DefaultService = #DefaultService# & ',#ThisServiceName#'>				
				 </cfif>
			</cfif>
			
			<cfif TypeFor IS 'USCA' and form.ship_country IS 'US' OR TypeFor IS 'USCA' AND form.ship_country IS 'CA'>
				 <cfif LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #ThisPrice#>
					<cfset DefaultService = '#ThisServiceName#'>
				 </cfif>
				 <cfif NOT LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #DefaultPrice# & "," & #ThisPrice#>
					<cfset DefaultService = #DefaultService# & ',#ThisServiceName#'>
				 </cfif>
			</cfif>
			
			<cfif TypeFor IS 'INT' and NOT form.ship_country IS request.Country>
				 <cfif LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #ThisPrice#>
					<cfset DefaultService = '#ThisServiceName#'>
				 </cfif>
				 <cfif NOT LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #DefaultPrice# & "," & #ThisPrice#>
					<cfset DefaultService = #DefaultService# & ',#ThisServiceName#'>
				 </cfif>
			</cfif>	
			</cfoutput>		
	</cfloop>
	
	<cfif NOT ListLen('#DefaultPrice#') IS 0>
		<cfset Cart.TotalShippingCosts = ListGetAt(DefaultPrice, 1)>
		<cfset Cart.DefaultService = ListGetAt(DefaultService, 1)>
	</cfif>
	
	</cfif>
	</cfif>
	
	<cfif #Shiptype# IS 7>
	<!---Shipping Charges are disabled, so set it to zero--->
	<cfset Cart.TotalShippingCosts = 0>
	<cfset Cart.DefaultService = 'N/A'>
	</cfif>
	
	<!---Now check to see if there are any Shipping Surcharges to add to the calculated shipping
	<cfif ShipState IS 'N/A'>--->
	<cfoutput query = "qrySurcharges">
	
	<cfif NOT Region IS 'All'>
	<cfif Region IS #form.ship_state# and Country IS #form.ship_country#>
	<cfset Cart.TotalShippingCosts = Cart.TotalShippingCosts + #SurCharge#>
	</cfif>
	</cfif>
	
	<cfif NOT Region IS 'All'>
	<cfif Region IS 'All' AND Country IS '#form.ship_country#'>
	<cfset Cart.TotalShippingCosts = Cart.TotalShippingCosts + #SurCharge#>
	</cfif>
	</cfif>
	
	</cfoutput>
	<!---/cfif>
	</cfif--->
	
	<!---*******************SHIPPING TYPE 9******************---->
	
	<cfif #ShipType# IS 9>
	
	<!---This is for Shipping Based on a mixed table - custom shipping table--->
	
	<!---Set up our list variables.  This will be the content of the drop down box
		displayed when reviewing the order--->
	
	<cfset Shippingoptions = ''>
	<cfset ShippingCosts = ''>
	<cfset DefaultPrice = ''>
	<cfset DefaultService = ''>
	
	<cfset TheCartPrice = '#ShippingTotal#'>
	<cfif NOT TheCartPrice IS '0'>
	
	<!---get the shipping types--->
	<cfquery name = "GetTypes" datasource="#request.dsn#">
	SELECT * FROM shippingtypes
	</cfquery>
	
	<!---Loop over the types and build the list--->
	<cfloop query = "GetTypes">
	
					<cfquery name = "GetCosts" datasource = "#request.dsn#">
					SELECT *
					FROM shippingtable5
					WHERE MinPrice <= #TheCartPrice# AND MaxPrice >= #TheCartPrice#
					AND ShippingType = '#GetTypes.ShippingType#'
					</cfquery>
					
					<cfset TheTotalForThisOption = 0>
					
					<cfoutput query = "GetCosts">
					 <!---Determine if this one should be charged a percentage or be charged an amount--->
						<cfif AmountType IS 'Percent'>
							<cfset PercentAmount = #Amount# / 100>
							<cfset TheTotalForThisOption = #PercentAmount# * #TheCartPrice#>
						</cfif>
						<cfif AmountType IS 'Price'>
							<cfset TheTotalForThisOption = #Amount#>
						</cfif>
					</cfoutput>
	
					<cfset Shippingoptions = ListAppend(Shippingoptions, GetTypes.ShippingType)>
					<cfset ShippingCosts = ListAppend(ShippingCosts, TheTotalForThisOption)>
					<cfset Cart.TotalShippingCosts = #ListGetAt(Shippingcosts, 1)#>
	</cfloop>
	
	<!---Now get a default value--->
	<cfset ServiceNames = '#Shippingoptions#'>
	<cfset ServicePrices = '#ShippingCosts#'>
	
	<cfloop index="mycount" from="1" To="#ListLen(Servicenames)#">
		<cfset ThisServiceName = ListGetAt(ServiceNames, mycount)>
		<cfset ThisPrice = ListGetAt(ServicePrices, mycount)>
	
		<!---Check to see if they are eligable for this shipping option.  If so, display it--->
			<cfquery name = "GetTypes" datasource="#request.dsn#">
			SELECT * FROM shippingtypes
			WHERE ShippingType = '#ThisServiceName#'
			</cfquery>
			
			<cfset TypeFor = 'All'>
			<cfoutput query = "GetTypes">
				<cfset TypeFor = '#AvailableTo#'>
			</cfoutput>
	
			<cfoutput>
			<cfif TypeFor IS 'All'>
				 <cfif LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #ThisPrice#>
					<cfset DefaultService = '#ThisServiceName#'>
				 </cfif>
				 <cfif NOT LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #DefaultPrice# & "," & #ThisPrice#>
					<cfset DefaultService = #DefaultService# & ',#ThisServiceName#'>
				 </cfif>
			</cfif>
			
			<cfif TypeFor IS 'CA' and form.ship_country IS 'CA'>
				 <cfif LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #ThisPrice#>
					<cfset DefaultService = '#ThisServiceName#'>
				 </cfif>
				 <cfif NOT LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #DefaultPrice# & "," & #ThisPrice#>
					<cfset DefaultService = #DefaultService# & ',#ThisServiceName#'>
				 </cfif>
			</cfif>
			
			<cfif TypeFor IS 'US' and form.ship_country IS 'US'>
				 <cfif LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #ThisPrice#>
					<cfset DefaultService = '#ThisServiceName#'>
				 </cfif>
				 <cfif NOT LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #DefaultPrice# & "," & #ThisPrice#>
					<cfset DefaultService = #DefaultService# & ',#ThisServiceName#'>				
				 </cfif>
			</cfif>
			
			<cfif TypeFor IS 'USCA' and form.ship_country IS 'US' OR TypeFor IS 'USCA' AND form.ship_country IS 'CA'>
				 <cfif LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #ThisPrice#>
					<cfset DefaultService = '#ThisServiceName#'>
				 </cfif>
				 <cfif NOT LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #DefaultPrice# & "," & #ThisPrice#>
					<cfset DefaultService = #DefaultService# & ',#ThisServiceName#'>
				 </cfif>
			</cfif>
			
			<cfif TypeFor IS 'INT' and NOT form.ship_country IS request.Country>
				 <cfif LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #ThisPrice#>
					<cfset DefaultService = '#ThisServiceName#'>
				 </cfif>
				 <cfif NOT LISTLEN('DefaultPrice') IS 0>
					<cfset DefaultPrice = #DefaultPrice# & "," & #ThisPrice#>
					<cfset DefaultService = #DefaultService# & ',#ThisServiceName#'>
				 </cfif>
			</cfif>	
			</cfoutput>		
	</cfloop>
	
	<cfif NOT ListLen('#DefaultPrice#') IS 0>
		<cfset Cart.TotalShippingCosts = ListGetAt(DefaultPrice, 1)>
		<cfset Cart.DefaultService = ListGetAt(DefaultService, 1)>
	</cfif>
	
	</cfif>
	</cfif>
</cfif>

<!---for custom shipping tables, this adds in surcharges if there is only one option for shipping--->
<cfif NOT isdefined("Shippingoptions")>
	<cfif NOT isdefined('qAvailServices')>
		<cfset Cart.TotalShippingCosts = Cart.TotalShippingCosts + Cart.Surcharges>
	</cfif>
</cfif>

<cfif isdefined('ShippingOptions')>
	<cfif #ListLen(Shippingoptions, ",")# LT 2>
		<cfset Cart.TotalShippingCosts = Cart.TotalShippingCosts + Cart.Surcharges>    
    </cfif>
</cfif>

<!---for ups, if there is not services list then add in surcharges--->
<cfif isdefined('response')>
	<cfif NOT structKeyExists(response, 'ServicesList')>
		<cfset Cart.TotalShippingCosts = Cart.TotalShippingCosts + Cart.Surcharges> 
	</cfif>
</cfif>

<!---for fedex...if they only offer ground shipping add in surcharges--->
<cfif isdefined('qAvailServices')>
	<cfif qryFEDEXSettings.ServiceNames IS 'FEDEXGROUND'>
    	<cfset Cart.TotalShippingCosts = Cart.TotalShippingCosts + Cart.Surcharges> 
    </cfif>
</cfif>

<cfset shipmethodused = shiptype>

