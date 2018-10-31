<cfparam name="ErrorMessage" default="">
<cfparam name="valid" default="0">
<cfparam name="authorized" default="1">
<cfparam name="AVS" default="1">

<cfset CCExpireDateShort = '#form.card_expmonth#/#Right(form.card_expyear, 2)#'>

<cfif qProc.test_mode IS 'Yes'>
<cfset PURL = 'test-payflow.verisign.com'>
<cfelse>
<cfset PURL = 'payflow.verisign.com'>
</cfif>
<!---Format the expiredate for payflow--->
<cfset ExpireyDate = replace(CCExpireDateShort, "/", "", "ALL")>

<cfoutput>
<CFX_PAYFLOWPRO 
QUERY			= "RESULT"
HostAddress		="#PURL#" 
HOSTPORT       	= "443"
TIMEOUT        	= "30"
PROXYADDRESS   	= ""
PROXYPORT      	= ""
PROXYLOGON     	= ""
PROXYPASSWORD  	= ""
TRXTYPE        	= "S"
TENDER         	= "C"
PARTNER 	= "#qProc.p_pass#"
VENDOR 		= ""
USER    	= "#aProc.p_user#"  
PWD      	= "#AuthTrans#"
ORIGID		= "#form.OrderNumber#"
ACCT           	= "#form.card_number#"
EXPDATE        	= "#ExpireyDate#"
AMT            	= "#NumberFormat(form.OrderTotal, '__0.00')#"
COMMENT1       	= "Order Number: #form.OrderNumber#"
COMMENT2       	= "Customer: #form.bill_firstname# #form.bill_lastname# Phone: #form.bill_phone#"
CERTPATH       	= "C:#request.bslash#CFusionMX7#request.bslash#certs"
>	
</cfoutput>

<!---Store the card info if they want it stored--->
<cfif request.StoreCreditCardInfo IS 'Yes'>
<cfquery name = "qryUpdateCCInfo" datasource="#request.dsn#">
UPDATE orders
SET CreditCardType = '#form.card_type#', 
CreditCardNumber = '#form.card_number#', 
CreditCardExpire = '#CCExpireDate#', 
CCConfirmationNumber = '#form.card_cvs#'
WHERE ordernumber = '#form.ordernumber#'
</cfquery>
</cfif>

<!---Store the last four if they don't want to store it.--->
<cfif request.StoreCreditCardInfo IS 'No'>

<cfset maskedcard = "">
<cfset lastfour = right(form.card_number, 4)>
<cfset loopto = len(form.card_number - 4)>

<cfloop from = "1" to = "#loopto#" index="i">
<cfset maskedcard = maskedcard & '*'>
</cfloop>

<cfset maskedcard = maskedcard & lastfour>

<cfquery name = "qryUpdateCCInfo" datasource="#request.dsn#">
UPDATE orders
SET CreditCardType = '#form.card_type#', 
CreditCardNumber = '#maskedcard#', 
CreditCardExpire = '#CCExpireDate#', 
CCConfirmationNumber = '#form.card_cvs#'
WHERE ordernumber = '#form.ordernumber#'
</cfquery>
</cfif>

<!---If the message is approved, continue processing the order---->
<CFIF result.result IS "0">
<!---It's approved so set the authnumber--->
<cfset AuthNumber = result.authcode>
<cfset thepnref = result.PNREF>
</cfif>

<!---If the result is less than 0, a connection error has occurred.  Instruct them to complete an off-line transaction or wait 10 minutes and try the transaction again.--->
<CFIF result.result LT 0>
We are Sorry, but we cannot process your credit card at this time as the gateway is offline.  Please wait 10 Minutes or contact us to place your order.
<p>
<cfoutput>
USING: #PURL#
<p><b>RESULTSTR:</b> #RESULT.RESULTSTR#<BR>
<p><b>VERSION:</b> #RESULT.VERSION#<BR><BR>
</cfoutput>
<CFABORT>
</CFIF>

<cfset waserror = 'No'>

<cfif result.result GT 0>
An error occurred during the transaction
<p>
<cfoutput>
<b>RESULTSTR:</b> #RESULT.RESULTSTR#<BR>
<b>VERSION:</b> #RESULT.VERSION#<BR><BR>
</cfoutput>
<cfset waserror = 'yes'>
</cfif>

<!---If the result is 24, an invalid expiration date was used.  Display a warning.--->
<CFIF result.result IS "24">
<center><font color="##FF0000"><b>This card is expired! Please enter a new card.<br />
Expiration date passed was <cfoutput>#ExpireyDate#</cfoutput></b></font></center>
<CFABORT>
</CFIF>

<!---If the result is 23, an invalid credit card number was used.  Display a warning.--->
<CFIF result.result IS "23">
<center><font color="##FF0000">You did not enter a valid credit card number! Please enter another card number.</font></center>
<CFABORT>
</CFIF>

<cfif waserror IS 'yes'>
There was an error!
<cfabort>
</cfif>

<!---If no errors then update the order and mark it as paid--->
<cfset thetranstype = 'Sale'>

<cfif AuthTransType IS 'A'>
<cfset thetranstype = 'Authorized'>
</cfif>
<cfif AuthTransType IS 'S'>
<cfset thetranstype = 'Sale'>
</cfif>

<cfquery name = "qryUpdateOrder" datasource="#request.dsn#">
UPDATE orders
SET paid = 'Yes',
transactiontype = '#thetranstype#',
pnref = '#thepnref#'
WHERE OrderNumber = '#form.OrderNumber#'
</cfquery>