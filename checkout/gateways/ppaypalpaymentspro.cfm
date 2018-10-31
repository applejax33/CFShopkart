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
<cfset serverURL = "https://api-3t.sandbox.paypal.com/nvp">
<cfset APIuserName = "#var_user#">
<cfset APIPassword = "#var_pass#">
<cfset APISignature = "#var_custom#">
<cfset PayPalURL = "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=">
</cfif>
<cfif var_istest IS 'false'>
<cfset serverURL = "https://api-3t.paypal.com/nvp">
<cfset APIuserName = "#var_user#">
<cfset APIPassword = "#var_pass#">
<cfset APISignature = "#var_custom#">
<cfset PayPalURL = "https://www.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=">
</cfif>

<cfset version = "65.1">
<cfset useProxy = "false">
<cfset proxyName = "">
<cfset proxyPort = "">
<cfset cancelUrlPath = "#request.HomeURL#">
<cfset returnUrlPath = "#request.secureURL#?action=finalize&OrderNumber=#form.OrderNumber#">
<CFOBJECT COMPONENT="CallerService" name="caller">

<cfif form.card_type IS 'VI'>
	<cfset the_card_type = 'Visa'>
</cfif>
<cfif form.card_type IS 'MC'>
	<cfset the_card_type = 'MasterCard'>
</cfif>
<cfif form.card_type IS 'DI'>
	<cfset the_card_type = 'Discover'>
</cfif>
<cfif form.card_type IS 'AM'>
	<cfset the_card_type = 'American Express'>
</cfif>

<!---build structure to send to paypal--->
<CFSET expDate =  #form.card_expmonth# & #form.card_expyear# >
<CFSET requestData = StructNew()>
<CFSET requestData.METHOD = "DoDirectPayment">
<CFSET requestData.PAYMENTACTION = "Sale">
<CFSET requestData.USER = "#APIUserName#">
<CFSET requestData.PWD = "#APIPassword#">
<CFSET requestData.SIGNATURE = "#APISignature#">
<CFSET requestData.VERSION = "#version#">
<CFSET requestData.FIRSTNAME = "#form.bill_firstname#">
<CFSET requestData.LASTNAME = "#form.bill_lastname#">
<CFSET requestData.AMT = "#NumberFormat(form.OrderTotal, '__0.00')#">
<CFSET requestData.STREET = "#form.bill_address#">
<CFSET requestData.CURRENCYCODE = "#mycurrency#">
<CFSET requestData.ZIP = "#form.bill_zip#">
<CFSET requestData.CVV2 = "#form.card_cvs#">
<CFSET requestData.CREDITCARDTYPE = "#the_card_type#">
<CFSET requestData.EXPDATE = "#expDate#">
<CFSET requestData.STATE = "#form.bill_state#">
<CFSET requestData.COUNTRYCODE = "#request.country#">
<CFSET requestData.ACCT = "#form.card_number#">
<CFSET requestData.CITY = "#form.bill_city#">

<!---Post payment to paypal--->
<cfinvoke component="callerservice" method="doHttppost" returnvariable="response">
	<cfinvokeargument name="requestData" value="#requestData#">
	<cfinvokeargument name="serverURL" value="#serverURL#">
	<cfinvokeargument name="proxyName" value="#proxyName#">
	<cfinvokeargument name="proxyPort" value="#proxyPort#">
	<cfinvokeargument name="useProxy" value="#useProxy#">
</cfinvoke>

<cfset responseStruct = caller.getNVPResponse(#URLDecode(response)#)>
<cfset messages = ArrayNew(1)>
<cfset request.resStruct ="#responseStruct#">

<!---If success mark as paid and set transid on order--->
<cfif responseStruct.Ack is "Success">
	<cfquery name = "qryUpdateOrder" datasource="#request.dsn#">
    UPDATE orders
    SET Transid = '#responseStruct.TRANSACTIONID#',
    paid = 'Yes'
    WHERE ordernumber = '#form.ordernumber#'
    </cfquery>
</cfif>

<cfif responseStruct.Ack is "Failure">
	<cfif isdefined('responseStruct.errorType')>
	<CFOUTPUT>#responseStruct.errorType#</CFOUTPUT>  
    <br />
	<CFOUTPUT>
	#responseStruct.errorMessage#
	</CFOUTPUT>
    
    <cfelse>

    <cfloop collection=#responseStruct# item="key">
	<CFOUTPUT>#key#:</CFOUTPUT></td>
	<CFOUTPUT>#responseStruct[key]# <br /></CFOUTPUT>
	</cfloop>
    <p>
    <cfoutput>Test Environment: #var_istest#</cfoutput>
    </p>
	</cfif>

    <cfset processor_error = "Yes">   
</cfif>