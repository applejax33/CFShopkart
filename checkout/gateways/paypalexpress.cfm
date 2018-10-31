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

<cfset version = "56.0">
<cfset useProxy = "false">
<cfset proxyName = "">
<cfset proxyPort = "">
<cfset cancelUrlPath = "#request.HomeURL#">
<cfset returnUrlPath = "#request.secureURL#?action=finalize&OrderNumber=#form.OrderNumber#">
<CFOBJECT COMPONENT="CallerService" name="caller">
	
<CFSET requestData = StructNew()>
<CFSET requestData.METHOD = "SetExpressCheckout">
<CFSET requestData.PAYMENTACTION = "sale">
<CFSET requestData.USER = "#APIUserName#">
<CFSET requestData.PWD = "#APIPassword#">
<CFSET requestData.SIGNATURE = "#APISignature#">
<CFSET requestData.VERSION = "#version#">
<CFSET requestData.AMT = "#form.order_total#">
<CFSET requestData.CURRENCYCODE = "#form.currency_code#">
<CFSET requestData.CancelURL = "#cancelUrlPath#">
<CFSET requestData.ReturnURL = "#returnUrlPath#">

<cfinvoke component="callerservice" method="doHttppost" returnvariable="response">
    <cfinvokeargument name="requestData" value=#requestData#>
    <cfinvokeargument name="serverURL" value=#serverURL#>
    <cfinvokeargument name="proxyName" value=#proxyName#>
    <cfinvokeargument name="proxyPort" value=#proxyPort#>
    <cfinvokeargument name="useProxy" value=#useProxy#>
</cfinvoke>

<cfset responseStruct = caller.getNVPResponse(#URLDecode(response)#)>
	 
<cfif responseStruct.Ack is not "Success">
	<cfset processor_error = "Yes">
		<cfif responseStruct.Ack is "Failure"> 
        <cfif isdefined('responseStruct.errorType')>
        <CFOUTPUT>#responseStruct.errorType#
        <br />
        #responseStruct.errorMessage#
        </CFOUTPUT>
        
        <cfelse>
    
        <cfloop collection=#responseStruct# item="key">
        <CFOUTPUT>#key#:</CFOUTPUT></td>
        <CFOUTPUT>#responseStruct[key]# <br /></CFOUTPUT>
        </cfloop>
        <p>
        <cfoutput>Test Environment: #var_istest#</cfoutput>
        </cfif>
	</cfif>
<cfelse>
	<CFSET TOKEN = #responseStruct.TOKEN#>
	<!---cfhttp.FileContent returns token and other response value from the server. 
    We need to pass token as parameter to destination URL which redirect to return URL --->
    
    <CFSET redirecturl = #PayPalURL# & #TOKEN#>
    
    <CFLOCATION URL="#redirecturl#" ADDTOKEN="no">  
</cfif>