<!---PayPal PDT:  will pass back a token url.tx variable.  You must enter your token here provided by paypal.---> 
<cfif isdefined('url.tx')>
	<cfset authToken="#var_token#"> <!---put your identity token from paypal here--->
    <cfset txToken = url.tx>
    <cfset query="cmd=_notify-synch&tx=" & txToken & "&at=" & authToken>

	<cfif var_istest IS 'true'>
        <CFHTTP url="https://www.sandbox.paypal.com/cgi-bin/webscr?#query#" method="GET" resolveurl="false">
        </CFHTTP>    
    <cfelse>
        <CFHTTP url="https://www.paypal.com/cgi-bin/webscr?#query#" method="GET" resolveurl="false">
        </CFHTTP>
    </cfif>

    <cfset theordernumber = 0>
    
    <cfif left(cfhttp.FileContent,7) is "SUCCESS">
         <cfquery name="UpdatePaidStatus" datasource="#request.dsn#">
            UPDATE orders
            SET paid = 'Yes'
            WHERE OrderNumber = '#url.ordernumber#'
         </cfquery>
         <cfset PaymentSent = 'yes'>   
    </cfif>
</cfif>