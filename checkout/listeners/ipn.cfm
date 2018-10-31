<!---Paypal IPN script for CFShopkart.  This file gets the info from paypal on payment and then marks the order as paid or unpaid.
It will also check for subscription variables and mark the subscriber inactive or active depending on status sent back from paypal--->

<cftry>

	<cfset todaysdate = now()>
    
    <cfset logerror = "No">
    
    <!-- read post from PayPal system and add 'cmd' -->
    <cfset xmsg = GetHttpRequestData()>
    <CFSET str="cmd=_notify-validate&" & xmsg.content>
    <CFIF IsDefined("FORM.payment_date")>
    <CFSET str = str & "&payment_date=#URLEncodedFormat(Form.payment_date)#">
    </CFIF>
    <CFIF IsDefined("FORM.subscr_date")>
    <CFSET str = str & "&subscr_date=#URLEncodedFormat(Form.subscr_date)#">
    </CFIF>

	<cfquery name = "qProc" datasource="#request.dsn#">
    SELECT * FROM cfsk_processors
    WHERE p_name = 'paypal'
    </cfquery>
    
    <!-- post back to PayPal system to validate -->
	<cfif qProc.test_mode IS 'false'>
   		<CFHTTP URL="https://www.paypal.com/cgi-bin/webscr?#str#" METHOD="GET" RESOLVEURL="false"></CFHTTP>    
    <cfelse>
    	<CFHTTP URL="https://www.sandbox.paypal.com/cgi-bin/webscr?#str#" METHOD="GET" RESOLVEURL="false"></CFHTTP>        
    </cfif>
	
    <!---Get their email address from the db--->
    <cfinclude template = "#request.absolutepath#config/config.cfm">
    
   
    <cfset var_custom = Decrypt(qProc.p_custom, request.seedstring, "CFMX_COMPAT","HEX") />

<!--- check notification validation --->
<CFIF #CFHTTP.FileContent# is "VERIFIED">
    <!--- check that payment_status=Completed --->
    <cfif FORM.payment_status eq "Completed">
		<!--- check that receiver_email is your email address --->
        <cfif #FORM.RECEIVER_EMAIL# eq "#var_custom#">
             <!---If so, then update the order as paid--->
             <cfquery name = "UpdateOrder" datasource="#request.dsn#">
                update orders
                Set paid = 'Yes', 
                transid = '#form.txn_id#',
                paymentstatus = '#form.payment_status#'
                where orderNumber = '#form.custom#'
             </cfquery>
             
             <!---update gift code to active if there is one--->
             <cfquery name = "UpdateOrder" datasource="#request.dsn#">
                update giftcards
                set activated = 'Yes', 
                where orderNumber = '#form.custom#'
             </cfquery>            
                          
        <cfelse>
        	<!---log for error--->
            <cfset logerror = "Yes">
		</cfif>
          
	<!---if it's not completed then mark it as unpaid and update status--->
	<cfelse>
	 <!---If not, then update the order to show payment status and that it's NOT been paid for--->
     <cfquery name = "UpdateOrder" datasource="#Request.dsn#">
        update orders
        Set paid = 'No', 
        transid = '#form.txn_id#',
        paymentstatus = '#form.payment_status#' <cfif isdefined('form.pending_reason')>,
        payment_pending_reason = '#form.pending_reason#'</cfif>
        Where ordernumber = '#form.custom#'
     </cfquery>    
	</cfif>    
</cfif>
		
<CFIF NOT #CFHTTP.FileContent# is "VERIFIED">
	<cfset logerror = "Yes">
</CFIF>

    <cfcatch type="any">
        <cfinclude template = "#request.absolutepath#errorprocess.cfm">
    </cfcatch>

    
</cftry>
