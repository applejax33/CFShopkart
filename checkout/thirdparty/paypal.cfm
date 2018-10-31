<!---This is for paypal checkout...NOT for IPN.  IPN is used if PayPal is the gateway used and that is 
 taken care of in actprocess.cfm--->
<cfoutput>

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

<cfif var_istest IS 'true'>
	<cfset pp_url = "https://www.sandbox.paypal.com/cgi-bin/webscr">
<cfelse>
	<cfset pp_url = "https://www.paypal.com/cgi-bin/webscr">
</cfif>

<div align="center">
<form action="#pp_url#" method="post">
<input type = "hidden" value="#form.bill_firstname#" name="first_name">
<input type = "hidden" value="#form.bill_lastname#" name="last_name">
<input type = "hidden" value="#form.emailaddress#" name="email">
<input type = "hidden" value="#form.bill_address#" name="address1">
<input type = "hidden" value="#form.bill_address2#" name="address2">
<input type = "hidden" value="#form.bill_city#" name="city">
<input type = "hidden" value="#form.bill_state#" name="state">
<input type = "hidden" value="#form.bill_zip#" name="zip">
<input type = "hidden" value="#form.bill_country#" name="country">
<input type = "hidden" value="#form.ordernumber#" name="custom">
<input type="hidden" name="cmd" value="_xclick">
<input type="hidden" name="lc" value="#Country#" />
<input type="hidden" name="business" value="#var_custom#">
<input type="hidden" name="item_name" value="Customer:  #form.OrderNumber# - #request.CompanyName# Shopping Cart Total">
<input type="hidden" name="amount" value="#NumberFormat(GrandTotal, '__0.00')#">
<input type="hidden" name="Shipping" value="#Cart.TotalShippingCosts#">
<input type="hidden" name="currency_code" value="#mycurrency#">
<input type="hidden" name="memo" value="#form.memo#">
<input type="hidden" name="rm" value="1" />
<input type="hidden" name="return" value="#request.SecureURL#index.cfm?action=Finalize&OrderNumber=#form.OrderNumber#">
<input type="hidden" name="cancel_return" value = "#request.HomeURL#">
<input type="hidden" name="notify_url" value="#request.secureURL#checkout/listeners/ipn.cfm" />

<input type="image" src="images/checkout/paypal_checkout_button.png" name="ProcessOrder" value="ProcessOrder" alt="Continue to PayPal" title="Continue to PayPal"  class="ProcessOrderButton" />
</form>
</div>
</cfoutput> 



