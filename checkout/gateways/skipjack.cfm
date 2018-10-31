<!---This shows the SkipJack button at the bottom of the revieworder page.  Once clicked on the 
	  Customer will be sent to the LinkPoint Gateway--->

	<cfparam name = "SkipJackServer" default="https://developer.skipjackic.com/scripts/EvolvCC.dll?Authorize"> 
<!---for testing purposes, comment out the above line and replace it with this one: 
	<cfparam name = "SkipJackServer" default="https://www.skipjackic.com/scripts/EvolvCC.dll?Authorize">
--->

<!---Only send the email once.  When the order is inserted, if a duplicate was detected then the 
	email will not be sent again--->
<cfif NOT CheckDuplicateOrders.recordcount IS 0>
	<cfinclude template = "../actions/actordernotify.cfm">
</cfif>

	<!---Create the Order String based on the items in the shopping cart--->
	<cflock scope="Session" type="EXCLUSIVE" timeout="10">
	<cfoutput>
	<cfset cart.CrtProductID = '#session.CrtProductID#'>
	<cfset cart.CrtProductName = '#session.CrtProductName#'>
	<cfset cart.CrtQuantity = '#session.CrtQuantity#'>
	<cfset cart.CrtPrice = '#session.CrtPrice#'>
	<cfset cart.CrtWeight = '#session.CrtWeight#'>
	<cfset Cart.CrtThumbNails = '#session.CrtThumbNails#'>
	<cfset Cart.CrtItemID = '#session.CrtItemID#'>
	</cfoutput>
	</cflock>
	
	<cfset SkipJackString = "">

	<cfoutput>
	<cfloop from="1" To="#ListLen(Cart.CrtProductID, '^')#" index="MyCount">
		<cfset ThisProductID = ListGetAt(Cart.CrtProductID, MyCount, "^")>
		<cfset ThisProductName = ListGetAt(Cart.CrtProductName, MyCount, "^")>
		<cfset ThisPrice = ListGetAt(Cart.CrtPrice, MyCount, "^")>
		<cfset ThisQuantity = ListGetAt(Cart.CrtQuantity, MyCount, "^")>
		<cfset SkipJackString = #SkipJackString# & "#ThisProductID#~#ThisProductName#~#ThisPrice#~#ThisPrice#~#ThisQuantity#~N~||">
	</cfloop>
	<cfset SkipJackString = #SkipJackString# & "TAXES~Taxes~#TempVar.FiguredTax#~1~N~||">
	<cfset SkipJackString = #SkipJackString# & "SHIPPING~Shipping Costs~#request.ShippingCharges#~1~N~||">

	<!--- Set Sale Info --->
	<cfset ShipToName = '#form.ship_firstname# #form.ship_lastname#'>
	</cfoutput>

<cfoutput>	
<cfset ExpMonth = #datepart('m', CCExpireDate)#>
<cfset ExpYear = #datepart('yyyy', CCExpireDate)#>
<cfset FullName="#form.bill_firstname# #form.bill_firstname#">
<cfset SFullName="#form.ship_firstname# #form.ship_lastname#">
</cfoutput>

<cfset thischarge = numberformat(GrandTotal, "9.99")>

<cfoutput>
<form method="post" action="#SkipJackServer#">
<input type = "hidden" value="#p_custom#" name="Serialnumber">
<!---<input type = "hidden" value="#thisordernumber#" name="userid">--->
<input type = "hidden" value="#fullname#" name="sjname">
<input type = "hidden" value="#form.bill_phone#" name="Phone">
<input type = "hidden" value="#form.emailaddress#" name="Email">
<input type = "hidden" value="#form.bill_address#" name="Streetaddress">
<input type = "hidden" value="#form.bill_address2#" name="Streetaddress2">
<input type = "hidden" value="#form.bill_city#" name="City">
<cfif NOT form.bill_state IS 'Other'>  
  <INPUT TYPE = "hidden" value = "#form.bill_state#" name = "State" >
</cfif>
<cfif form._ship_state IS 'Other'>
  <INPUT TYPE = "hidden" value = "#form.otherstate#" name = "State">
</cfif>
<input type = "hidden" value="#form.bill_zip#" name="Zipcode">
<input type = "hidden" value="#form.OrderNumber#" name="ordernumber">
<input type = "hidden" value="#form.card_type#" name="cctype">
<input type = "hidden" value="#expmonth#" name="Month">
<input type = "hidden" value="#expyear#" name="Year">
<input type = "hidden" value="#form.card_number#" name="Accountnumber">
<input type = "hidden" value="#form.card_cvs#" name="cvv2">
<input type = "hidden" value="#thischarge#" name="Transactionamount">
<input type = "hidden" value="#SkipJackString#" name="Orderstring">
<input type = "hidden" value="#form.bill_phone#" name="Shiptophone">
<input type = "hidden" value="#form.bill_country#" name="Country">
<input type = "hidden" value="#sfullname#" name="Shiptoname">
<input type = "hidden" value="#form.ship_address#" name="Shiptostreetaddress">
<input type = "hidden" value="#form.ship_address2#" name="Shiptostreetaddress2">
<input type = "hidden" value="#form.ship_city#" name="Shiptocity">
<cfif NOT form._ship_state IS 'Other'>  
  <INPUT TYPE = "hidden" value = "#form._ship_state#" name = "Shiptostate">
</cfif>
<cfif form._ship_state IS 'Other'>
  <INPUT TYPE = "hidden" value = "#form.ship_otherstate#" name = "Shiptostate">
</cfif>
<input type = "hidden" value="#form.ship_zip#" name="Shiptozipcode">
<input type = "hidden" value="#form.ship_country#" name="Shiptocountry">
<input type = "hidden" value="#form.memo#" name="Comment">
<input type = "hidden" value="#form.CustomerID#" name="customerid">
<input type="image" src="#request.ProcessOrder#" name="ProcessOrder" value="ProcessOrder" alt="Complete Order" title="Complete Order"  class="ProcessOrderButton" />
</form>
</cfoutput>
<p>
<img src = "images/checkout/skipjack.gif" title="Provided by SkipJack" alt="Provided by SkipJack" border="0" class="SkipJackImage" />







