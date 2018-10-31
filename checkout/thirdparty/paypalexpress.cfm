<cfoutput>
<form method="Post" action="index.cfm">
<input type = "hidden" name="action" value="process" />

<!---figure out the currency code based on local--->
<cfif #request.Location# IS "Chinese (China)"><cfset mycurrency = "HKD"></cfif><!---CNY is not supported by PayPal--->
<cfif #request.Location# IS "Chinese (Hong Kong)"><cfset mycurrency = "HKD"></cfif>
<cfif #request.Location# IS "Chinese (Taiwan)"><cfset mycurrency = "HKD"></cfif><!---TWD is not supported by PayPal--->
<cfif #request.Location# IS "Dutch (Belgian)"><cfset mycurrency = "EUR"></cfif><!---BEF is not supported by PayPal--->
<cfif #request.Location# IS "Dutch (Standard)"><cfset mycurrency = "EUR"></cfif><!---NLG is not supported by PayPal--->
<cfif #request.Location# IS "English (Australian)"><cfset mycurrency = "AUD"></cfif>
<cfif #request.Location# IS "English (Canadian)"><cfset mycurrency = "CAD"></cfif>
<cfif #request.Location# IS "English (New Zealand)"><cfset mycurrency = "NZD"></cfif>
<cfif #request.Location# IS "English (UK)"><cfset mycurrency = "GBP"></cfif>
<cfif #request.Location# IS "English (US)"><cfset mycurrency = "USD"></cfif>
<cfif #request.Location# IS "French (Belgian)"><cfset mycurrency = "EUR"></cfif><!---BEF is not supported by PayPal--->
<cfif #request.Location# IS "French (Canadian)"><cfset mycurrency = "CAD"></cfif>
<cfif #request.Location# IS "French (Standard)"><cfset mycurrency = "EUR"></cfif><!---FRF is not supported by PayPal--->
<cfif #request.Location# IS "French (Swiss)"><cfset mycurrency = "CHF"></cfif>
<cfif #request.Location# IS "German (Austrian)"><cfset mycurrency = "EUR"></cfif><!---ATS is not supported by PayPal--->
<cfif #request.Location# IS "German (Standard)"><cfset mycurrency = "EUR"></cfif><!---DEM is not supported by PayPal--->
<cfif #request.Location# IS "German (Swiss)"><cfset mycurrency = "CHF"></cfif>
<cfif #request.Location# IS "Italian (Standard)"><cfset mycurrency = "EUR"></cfif><!---ITL is not supported by PayPal--->
<cfif #request.Location# IS "Italian (Swiss)"><cfset mycurrency = "CHF"></cfif>
<cfif #request.Location# IS "Japanese"><cfset mycurrency = "JPY"></cfif>
<cfif #request.Location# IS "Korean"><cfset mycurrency = "USD"></cfif><!---KRW is not supported by PayPal--->
<cfif #request.Location# IS "Norwegian (Bokmal)"><cfset mycurrency = "NOK"></cfif>
<cfif #request.Location# IS "Norwegian (Nynorsk)"><cfset mycurrency = "NOK"></cfif>
<cfif #request.Location# IS "Portuguese (Brazilian)"><cfset mycurrency = ""></cfif>
<cfif #request.Location# IS "Portuguese(Standard)"><cfset mycurrency = ""></cfif>
<cfif #request.Location# IS "Spanish(Mexican)"><cfset mycurrency = "MXN"></cfif>
<cfif #request.Location# IS "Spanish(Modern)"><cfset mycurrency = ""></cfif>
<cfif #request.Location# IS "Spanish(Standard)"><cfset mycurrency = ""></cfif>
<cfif #request.Location# IS "Swedish"><cfset mycurrency = "SEK"></cfif>

<!---if they use the Euro then set it to EUR--->
<cfif request.EnableEuro IS 'Yes'>
	<cfset mycurrency = "EUR">
</cfif>

<input type="hidden" name="memo" value="#memo#">
<input type="hidden" name="emailaddress" value="#EmailAddress#">
<input type="hidden" name="ordernumber" value="#ordernumber#">
<input type="hidden" name="totalshippingcosts" value="#totalshippingcosts#">
<input type="hidden" value="#Cart.FiguredTax#" Name="FiguredTax">
<input type="hidden" value="#Cart.TotalShippingCosts#" Name="TotalShippingCosts">
<input type="hidden" Value="#CustomerID#" Name="CustomerID">
<input type="hidden" name="order_total" value="#NumberFormat(GrandTotal, '__0.00')#">
<input type="hidden" name="ordertotal" value="#NumberFormat(GrandTotal, '__0.00')#">
<input type="hidden" name="currency_code" value="#mycurrency#">
<input type="hidden" name="payment_method" value="#payment_method#" />
<cfif ISDEFINED('request.ShipFromState')>
  <input type="hidden" value="#request.ShipFromState#" Name="ShipFromState">
  <input type="hidden" value="#request.ShipFromCountry#" Name="ShipFromCountry">
</cfif>
<cfif ISDEFINED('Cart.DefaultService')>
<!---Tracks what method the customer chose for shipping--->
  <input type = "hidden" Value = "#Cart.DefaultService#" Name="ShippingMethod">
</cfif>
<cfif ISDEFINED('ReturningCustomer')>
  	<Input type="Hidden" Value="#ReturningCustomer#" Name="ReturningCustomer">
</cfif>
<cfif ISDEFINED('ProductUpdates')>
	<INPUT TYPE = "hidden" NAME = "ProductUpdates" Value = "#ProductUpdates#">
</cfif> 
<input type = "hidden" value="#TotalItemsInCart#" Name="TotalItemsInCart">

<input type="image" name="submit" src="images/checkout/btn_xpressCheckout.gif" alt="Click Here to Complete Your Order through PayPal" title="Click Here to Complete Your Order through PayPal" /></center>
</form>

</cfoutput>