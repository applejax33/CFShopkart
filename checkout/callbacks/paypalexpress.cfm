<!---PayPal Express Checkout...token and payerid are passed back so check to see if the order was paid for--->
<!---post to payal and see if the transaction is legit and order was paid for--->
<cfif ISDEFINED('url.token') AND ISDEFINED('url.PayerID')>
    <CFOBJECT COMPONENT="callerservice" name="caller">

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

	<CFSET requestData = StructNew()>
	<CFSET requestData.METHOD = "GetExpressCheckoutDetails">
	<CFSET requestData.USER = "#APIuserName#">
	<CFSET requestData.PWD = "#APIPassword#">
	<CFSET requestData.SIGNATURE = "#APISignature#">
	<CFSET requestData.TOKEN = "#URL.token#">
    <CFSET requestData.VERSION = "#version#">

    <cfinvoke component="CallerService" method="doHttppost" returnvariable="response">
        <cfinvokeargument name="requestData" value=#requestData#>
        <cfinvokeargument name="serverURL" value=#serverURL#>
        <cfinvokeargument name="proxyName" value=#proxyName#>
        <cfinvokeargument name="proxyPort" value=#proxyPort#>
        <cfinvokeargument name="useProxy" value=#useProxy#>
    </cfinvoke>	
    
    <cfset responseStruct = caller.getNVPResponse(#URLDecode(response)#)>

	<cfif responseStruct.Ack is "Success">
         <cfquery name="UpdatePaidStatus" datasource="#request.dsn#">
            UPDATE orders
            SET paid = 'Yes'
            WHERE OrderNumber = '#url.ordernumber#'
         </cfquery>
        <cfset PaymentSent = 'yes'>
	<cfelse>
        <cfloop collection=#responseStruct# item="key">
        <CFOUTPUT>#key#:</CFOUTPUT></td>
        <CFOUTPUT>#responseStruct[key]# <br /></CFOUTPUT>
        </cfloop>
        <p>
        <cfoutput>Test Environment: #var_istest#</cfoutput>
     </cfif>
</cfif>
