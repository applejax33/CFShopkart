<!---Create the Order String based on the items in the shopping cart--->
<cflock scope="Session" type="EXCLUSIVE" timeout="10">
<cfset cart.CrtProductID = '#session.CrtProductID#'>
<cfset cart.CrtProductName = '#session.CrtProductName#'>
<cfset cart.CrtQuantity = '#session.CrtQuantity#'>
<cfset cart.CrtPrice = '#session.CrtPrice#'>
<cfset cart.CrtWeight = '#session.CrtWeight#'>
<cfset Cart.CrtThumbNails = '#session.CrtThumbNails#'>
<cfset Cart.CrtItemID = '#session.CrtItemID#'>
</cflock>
	
<!--- Set Sale Info --->
<cfset ShipToName = '#ship_firstname# #ship_lastname#'>
<cfset FullName="#bill_firstname# #bill_lastname#">
<cfset SFullName="#ship_firstname# #ship_lastname#">

<cfset thischarge = numberformat(GrandTotal, "9.99")>

<cfoutput>
<form method="post" action="https://www.2checkout.com/2co/buyer/purchase">
<input type = "hidden" value="#AuthLogin#" name="sid">
<input type = "hidden" value="#thischarge#" name="total">
<input type = "hidden" value="#OrderNumber#" name="cart_order_id">
<input type = "hidden" value="#OrderNumber#" name="merchant_order_id">
<!---Billing info--->
<input type = "hidden" value="#fullname#" name="card_holder_name" />
<input type = "hidden" value="#bill_address#" name="street_address">
<input type = "hidden" value="#bill_address2#" name="street_address2">
<input type = "hidden" value="#bill_city#" name="city">
<cfif len(otherstate) IS 0>
	<input type = "hidden" value="#bill_state#" name="state">
<cfelse>
	<input type = "hidden" value="#bill_otherstate#" name="state">
</cfif>
<input type = "hidden" value="#bill_zip#" name="zip">
<input type = "hidden" value="#bill_country#" name="country">
<input type = "hidden" value="#emailaddress#" name="email">
<input type = "hidden" value="#bill_phone#" name="phone">
<!---Shipping Info--->
<input type = "hidden" value="#sfullname#" name="ship_name">
<input type = "hidden" value="#ship_address#" name="ship_street_address">
<input type = "hidden" value="#ship_address2#" name="ship_street_address2">
<input type = "hidden" value="#ship_city#" name="ship_city">
<cfif len(shipstate) IS 0>
	<input type = "hidden" value="#ship_state#" name="ship_state">
<cfelse>
	<input type = "hidden" value="#ship_otherstate#" name="ship_state">
</cfif>
<input type = "hidden" value="#ship_zip#" name="ship_zip">
<input type = "hidden" value="#ship_country#" name="ship_country">

<!---Pass the ordered items--->
<cfloop from = "1" to = "#listlen(cart.crtproductid, '^')#" index="c">
<cfset Itemid = listgetat(cart.crtproductid, c, "^")>
<cfset ItemName = listgetat(cart.crtProductName, c, "^")>
<cfset ItemQty = listgetat(cart.crtQuantity, c, "^")>
<cfset ItemPrice = listgetat(cart.crtPrice, c, "^")>

<!---Item #cart#--->
<input type="hidden" name="id_type" value="#c#">
<input type="hidden" name="c_prod_#c#" value="#itemid#,3">
<input type="hidden" name="c_name_#c#" value="#ItemName#">
<input type="hidden" name="c_description_#c#" value="#ItemName#">
<input type="hidden" name="c_price_#c#" value="#ItemPrice#">
<input type="hidden" name="c_tangible_#c#" value="Y">
</cfloop>
<input type="image" src="#request.ProcessOrder#" name="ProcessOrder" value="ProcessOrder" alt="Complete Order" title="Complete Order"  class="ProcessOrderButton" />
</form>
</cfoutput>