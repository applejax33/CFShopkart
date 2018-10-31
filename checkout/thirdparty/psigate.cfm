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
	
	<!--- Set Sale Info --->
<cfoutput>
<cfset ShipToName = '#form.ship_firstname# #form.ship_lastname#'>
<cfset ExpMonth = #datepart('m', CCExpireDate)#>
<cfset ExpYear = #datepart('yyyy', CCExpireDate)#>
<cfset FullName="#form.bill_firstname# #form.bill_firstname#">
<cfset SFullName="#form.ship_firstname# #form.ship_lastname#">
</cfoutput>

<cfset thischarge = numberformat(GrandTotal, "9.99")>

<cfoutput>
<form method="post" action="https://order.psigate.com/psigate.asp">
<input type = "hidden" value="#qProc.p_custom#" name="MerchantID">
<input type = "hidden" value="#thischarge#" name="FullTotal">
<input type = "hidden" value="Sale" name="ChargeType">
<input type = "hidden" value="#fullname#" name="Bname">
<input type = "hidden" value="#form.BusinessName#" name="Bcompanyname">
<input type = "hidden" value="#form.bill_phone#" name="Phone">
<input type = "hidden" value="#form.emailaddress#" name="Email">
<input type = "hidden" value="#form.bill_address#" name="Baddr1">
<input type = "hidden" value="#form.bill_address2#" name="Baddr2">
<input type = "hidden" value="#form.bill_city#" name="Bcity">
<input type = "hidden" value="#form.bill_state#" name="Bstate">
<input type = "hidden" value="#form.otherstate#" name="Bstate2">
<input type = "hidden" value="#form.bill_zip#" name="Bzip">
<input type = "hidden" value="#form.bill_country#" name="Bcountry">
<input type = "hidden" value="#sfullname#" name="Sname">
<input type = "hidden" value="#form.ship_address#" name="Saddr1">
<input type = "hidden" value="#form.ship_address2#" name="Saddr2">
<input type = "hidden" value="#form.ship_city#" name="Scity">
<input type = "hidden" value="#form._ship_state#" name="Sstate">
<input type = "hidden" value="#form.ship_otherstate#" name="Sstate2">
<input type = "hidden" value="#form.ship_zip#" name="Szip">
<input type = "hidden" value="#form.ship_country#" name="scountry">
<input type = "hidden" value="#expmonth#" name="ExpMonth">
<input type = "hidden" value="#expyear#" name="ExpYear">
<input type = "hidden" value="#form.CreditCardNumber#" name="CardNumber">
<input type = "hidden" value="#form.OrderNumber#" name="Oid">
<input type = "hidden" value="#form.CustomerID#" name="Userid">
<input type = "hidden" value="#request.SecureURL#/index.cfm?action=finalize&OrderNumber=#form.OrderNumber#&CustomerID=#form.CustomerID#" name="ThanksURL">
<input type = "hidden" value="#form.OrderNumber#" name="ordernumber">
<input type="image" src="#request.ProcessOrder#" name="ProcessOrder" value="ProcessOrder" alt="Complete Order" title="Complete Order"  class="ProcessOrderButton" />
</form>
</cfoutput>
<img src = "images/checkout/psigate.gif" title="Provided by PSIGate" alt="Provided by PSIGate" border="0" class="PSIGateImage" />







