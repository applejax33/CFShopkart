<cfif NOT CheckDuplicateOrders.recordcount IS 0>
	<cfinclude template = "../actions/actOrderNotify.cfm">
</cfif>

<cfoutput>
<cfset FullName="#form.bill_firstname# #form.bill_firstname#">
<cfset SFullName="#form.ship_firstname# #form.ship_lastname#">
</cfoutput>

<cfset thischarge = numberformat(GrandTotal, "9.99")>

<cfif istest IS 'Yes'>
	<cfset linkpointurl = 'https://www.staging.linkpointcentral.com/lpc/servlet/lppay'>
<cfelse>
	<cfset linkpointurl = 'https://www.linkpointcentral.com/lpc/servlet/lppay'>
</cfif>

<cfoutput>
<form method="post" action="#linkpointurl#">
<input type = "hidden" value="#qProc.p_custom#" name="storename">
<input type = "hidden" value="#thischarge#" name="chargetotal">
<input type = "hidden" value="payonly" name="mode">
<input type = "hidden" value="txntype" name="Sale">
<input type="hidden" name="txnorg" value="eci">
<input type = "hidden" value="#fullname#" name="bname">
<input type = "hidden" value="#form.bill_phone#" name="phone">
<input type = "hidden" value="#form.emailaddress#" name="email">
<input type = "hidden" value="#form.bill_address#" name="baddr1">
<input type = "hidden" value="#form.bill_address2#" name="baddr2">
<input type = "hidden" value="#form.bill_city#" name="bcity">
<input type = "hidden" value="#form.bill_state#" name="bstate">
<input type = "hidden" value="#form.bill_zip#" name="bzip">
<input type = "hidden" value="#form.bill_country#" name="bcountry">
<input type = "hidden" value="#sfullname#" name="sname">
<input type = "hidden" value="#form.ship_address#" name="saddr1">
<input type = "hidden" value="#form.ship_address2#" name="saddr2">
<input type = "hidden" value="#form.ship_city#" name="scity">
<input type = "hidden" value="#form._ship_state#" name="sstate">
<input type = "hidden" value="#form.ship_zip#" name="szip">
<input type = "hidden" value="#form.ship_country#" name="scountry">
<input type = "hidden" value="#form.CustomerID#" name="customerid">
<input type = "hidden" value="#form.OrderNumber#" name="oid">
<input type = "hidden" value="#form.OrderNumber#" name="OrderNumber" />
<input type = "hidden" value="finalize" name="action" />
<input type="image" src="#request.ProcessOrder#" name="ProcessOrder" value="ProcessOrder" alt="Complete Order" title="Complete Order"  class="ProcessOrderButton" />
</form>
<p>
<img src = "images/checkout/logo_your_pay.gif" title="Provided by YourPay" alt="Provided by YourPay" border="0" class="YourPayImage" />
</cfoutput>







