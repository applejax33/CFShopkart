<!---THIS IS NO LONGE USED.  A PAYPAL BUTTON IS USED NOT A REDIRECT ANYMORE.--->
<cfset TotalLessShipping = #form.OrderTotal# - #Form.TotalShippingCosts#>
<cfset mycurrency = "USD">

<cfoutput query = "qryCompanyInfo">
<!---figure out the currency code based on local--->
<cfif #Location# IS "Chinese (China)"><cfset mycurrency = "HKD"></cfif><!---CNY is not supported by PayPal--->
<cfif #Location# IS "Chinese (Hong Kong)"><cfset mycurrency = "HKD"></cfif>
<cfif #Location# IS "Chinese (Taiwan)"><cfset mycurrency = "HKD"></cfif><!---TWD is not supported by PayPal--->
<cfif #Location# IS "Dutch (Belgian)"><cfset mycurrency = "EUR"></cfif><!---BEF is not supported by PayPal--->
<cfif #Location# IS "Dutch (Standard)"><cfset mycurrency = "EUR"></cfif><!---NLG is not supported by PayPal--->
<cfif #Location# IS "English (Australian)"><cfset mycurrency = "AUD"></cfif>
<cfif #Location# IS "English (Canadian)"><cfset mycurrency = "CAD"></cfif>
<cfif #Location# IS "English (New Zealand)"><cfset mycurrency = "NZD"></cfif>
<cfif #Location# IS "English (UK)"><cfset mycurrency = "GBP"></cfif>
<cfif #Location# IS "English (US)"><cfset mycurrency = "USD"></cfif>
<cfif #Location# IS "French (Belgian)"><cfset mycurrency = "EUR"></cfif><!---BEF is not supported by PayPal--->
<cfif #Location# IS "French (Canadian)"><cfset mycurrency = "CAD"></cfif>
<cfif #Location# IS "French (Standard)"><cfset mycurrency = "EUR"></cfif><!---FRF is not supported by PayPal--->
<cfif #Location# IS "French (Swiss)"><cfset mycurrency = "CHF"></cfif>
<cfif #Location# IS "German (Austrian)"><cfset mycurrency = "EUR"></cfif><!---ATS is not supported by PayPal--->
<cfif #Location# IS "German (Standard)"><cfset mycurrency = "EUR"></cfif><!---DEM is not supported by PayPal--->
<cfif #Location# IS "German (Swiss)"><cfset mycurrency = "CHF"></cfif>
<cfif #Location# IS "Italian (Standard)"><cfset mycurrency = "EUR"></cfif><!---ITL is not supported by PayPal--->
<cfif #Location# IS "Italian (Swiss)"><cfset mycurrency = "CHF"></cfif>
<cfif #Location# IS "Japanese"><cfset mycurrency = "JPY"></cfif>
<cfif #Location# IS "Korean"><cfset mycurrency = "USD"></cfif><!---KRW is not supported by PayPal--->
<cfif #Location# IS "Norwegian (Bokmal)"><cfset mycurrency = "NOK"></cfif>
<cfif #Location# IS "Norwegian (Nynorsk)"><cfset mycurrency = "NOK"></cfif>
<cfif #Location# IS "Portuguese (Brazilian)"><cfset mycurrency = ""></cfif>
<cfif #Location# IS "Portuguese(Standard)"><cfset mycurrency = ""></cfif>
<cfif #Location# IS "Spanish(Mexican)"><cfset mycurrency = "MXN"></cfif>
<cfif #Location# IS "Spanish(Modern)"><cfset mycurrency = ""></cfif>
<cfif #Location# IS "Spanish(Standard)"><cfset mycurrency = ""></cfif>
<cfif #Location# IS "Swedish"><cfset mycurrency = "SEK"></cfif>
<!---if they use the Euro then set it to EUR--->
<cfif EnableEuro IS 'Yes'>
	<cfset mycurrency = "EUR">
</cfif>  
</cfoutput>

<cfoutput>    
<script language="javascript">
<!-- 
location.replace("https://www.paypal.com/cgi-bin/webscr?cmd=_ext-enter&redirect_cmd=_xclick&business=#qProc.p_custom#&item_name=Customer: #form.OrderNumber# - #qryCompanyInfo.CompanyName# Order&amount=#NumberFormat(TotalLessShipping, '__0.00')#&shipping=#Form.TotalShippingCosts#&memo=#form.memo#&cancel_return=#request.HomeURL#&first_name=#form.bill_firstname#&last_name=#form.bill_lastname#&address1=#form.bill_address#&address2=#form.bill_address2#&city=#form.bill_city#&state=#form.bill_state#&zip=#form.bill_zip#&lc=#form.bill_country#&email=#form.EmailAddress#&night_phone_a=#form.bill_phone#&no_shipping=1&cn=#form.memo#&invoice=#form.OrderNumber#&Custom=#form.CustomerID#&notify_url=#request.SecureURL#/ipn.cfm&return=#request.SecureURL#/PayPalFinal.cfm&lc=#qryCompanyInfo.country#&currency_code=#mycurrency#");
-->
</script>
</cfoutput>
