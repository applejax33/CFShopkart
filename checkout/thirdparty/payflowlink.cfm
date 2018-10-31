<!---This shows the SkipJack button at the bottom of the revieworder page.  Once clicked on the 
	  Customer will be sent to the LinkPoint Gateway--->

<cfparam name = "SkipJackServer" default="https://www.skipjackic.com/scripts/EvolvCC.dll?Authorize">
<!---for testing purposes, comment out the above line and replace it with this one: 
	<cfparam name = "SkipJackServer" default="https://developer.skipjackic.com/scripts/EvolvCC.dll?Authorize"> 
--->

<!---Only send the email once.  When the order is inserted, if a duplicate was detected then the 
	email will not be sent again--->
<cfif NOT CheckDuplicateOrders.recordcount IS 0>
	<cfinclude template = "../actions/actOrderNotify.cfm">
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
	
	<cfset PayflowlinkDesc = "">

	<cfoutput>
	<cfloop from="1" To="#ListLen(Cart.CrtProductID, '^')#" index="MyCount">
		<cfset ThisProductID = ListGetAt(Cart.CrtProductID, MyCount, "^")>
		<cfset ThisProductName = ListGetAt(Cart.CrtProductName, MyCount, "^")>
		<cfset ThisPrice = ListGetAt(Cart.CrtPrice, MyCount, "^")>
		<cfset ThisQuantity = ListGetAt(Cart.CrtQuantity, MyCount, "^")>
		<cfset PayflowlinkDesc = #PayflowlinkDesc# & "#ThisProductID#~#ThisProductName#~#ThisPrice#~#ThisPrice#~#ThisQuantity#~N~||">
	</cfloop>
	<cfset PayflowlinkDesc = #PayflowlinkDesc# & "TAXES~Taxes~#Cart.FiguredTax#~1~N~||">
	<cfset PayflowlinkDesc = #PayflowlinkDesc# & "SHIPPING~Shipping Costs~#request.ShippingCharges#~1~N~||">

	<!--- Set Sale Info --->
	<cfset ShipToName = '#form.ship_firstname# #form.ship_lastname#'>
	
<cfset ExpMonth = #datepart('m', CCExpireDate)#>
<cfset ExpYear = #datepart('yyyy', CCExpireDate)#>
<cfset FullName="#form.bill_firstname# #form.bill_firstname#">
<cfset SFullName="#form.ship_firstname# #form.ship_lastname#">
</cfoutput>

<cfset thischarge = numberformat(GrandTotal, "9.99")>

<cfoutput>
<form method="post" action="https://payflowlink.paypal.com/">
<input type = "hidden" value="#qProc.p_user#" name="LOGIN">
<input type = "hidden" value="#qProc.p_custom#" name="PARTNER">
<input type = "hidden" value="#thischarge#" name="AMOUNT">
<input type = "hidden" value="S" name="TYPE">
<input type = "hidden" value="CC" name="METHOD">
<input type = "hidden" value="False" name="ORDERFORM">
<input type = "hidden" value="False" name="SHOWCONFIRM">
<input type = "hidden" value="#PayflowlinkDesc#" name="DESCRIPTION">
<input type = "hidden" value="#fullname#" name="NAME">
<input type = "hidden" value="#form.bill_address# #form.bill_address2#" name="ADDRESS">
<input type = "hidden" value="#form.CreditCardNumber#" name="CARDNUM">
<input type = "hidden" value="#form.bill_city#" name="CITY">
<input type = "hidden" value="#expmonth##expyear#" name="EXPDATE">
<input type = "hidden" value="#form.bill_zip#" name="ZIP">
<input type = "hidden" value="#form.ship_zip#" name="ZIPTOSHIP">
<input type = "hidden" value="#form.ship_address# #form.ship_address2#" name="ADDRESSTOSHIP">
<input type = "hidden" value="#form.ship_city#" name="CITYTOSHIP">
<input type = "hidden" value="#form.bill_country#" name="COUNTRY">
<input type = "hidden" value="#form.ship_country#" name="COUNTRYTOSHIP">
<input type = "hidden" value="#form.memo#" name="COMMENT">
<input type = "hidden" value="#form.CardCode#" name="CSC">
<input type = "hidden" value="#form.CustomerID#" name="CUSTID">
<input type = "hidden" value="#form.emailaddress#" name="EMAIL">
<input type = "hidden" value="#form.emailaddress#" name="EMAILTOSHIP">
<input type = "hidden" value="#form.OrderNumber#" name="INVOICE">
<input type = "hidden" value="#sfullname#" name="NAMETOSHIP">
<input type = "hidden" value="#form.bill_phone#" name="PHONE">
<input type="hidden" value="#Cart.TotalShippingCosts#" name="SHIPAMOUNT">
<cfif NOT form.bill_state IS 'Other'>  
  <INPUT TYPE = "hidden" value = "#form.bill_state#" name = "STATE" >
</cfif>
<cfif form._ship_state IS 'Other'>
  <INPUT TYPE = "hidden" value = "#form.otherstate#" name = "STATE">
</cfif>
<cfif NOT form._ship_state IS 'Other'>  
  <INPUT TYPE = "hidden" value = "#form._ship_state#" name = "STATETOSHIP">
</cfif>
<cfif form._ship_state IS 'Other'>
  <INPUT TYPE = "hidden" value = "#form.ship_otherstate#" name = "STATETOSHIP">
</cfif>
<INPUT TYPE = "hidden" value = "#Cart.FiguredTax#" name = "TAX">
<input type="image" src="#request.ProcessOrder#" name="ProcessOrder" value="ProcessOrder" alt="Complete Order" title="Complete Order"  class="ProcessOrderButton" />
</form>
</cfoutput>
<p>
<img src = "images/checkout/payflowlink.jpg" title="Provided by PayFlow Link" alt="Provided by PayFlow Link" border="0" class="PayFlowLinkImage" />







