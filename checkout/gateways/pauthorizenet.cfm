<!---charge their card for the total of todays order--->
<cfset CCExpireDate = '#form.card_expmonth#/#form.card_expyear#'>

<cfif NOT isdefined('var_hash')>
	<cfset var_hash = ''>
</cfif>

	<!---For echeck transactions--->
    <cfif ISDEFINED('form.AccountType')>
    
        <cfif NOT form.AccountType IS 'NONE'>
        <cfoutput>
            <cf_AIM
                    Login="#var_user#"
                    TransactionKey="#var_token#"
                    hashValue="#var_hash#"
                    invoiceNum="#Form.OrderNumber#" 
                    invoiceAmt="#NumberFormat(form.OrderTotal, '__0.00')#"
                    Description="#TheCompanyName# Online Purchase" 
                    ChargeMethod="ECHECK"
                    ChargeType="AUTH_CAPTURE"
                    ABACode="#form.account_routing#"
                    BankACNum="#form.account_number#"
                    BankACType="#form.account_type#"
                    BankName="#form.account_bankname#"
                    BankACHolderName="#form.account_name#"
                    CustID="#form.OrderNumber#"
                    FName="#form.bill_firstname#"
                    LName="#form.bill_lastname#" 
                    StreetAddress="#form.bill_address#"
                    City="#form.bill_city#"
                    State="#form.bill_state#" 
                    Zip="#form.bill_zip#"
                    Country="#form.bill_country#"
                    ShipToFName="#form.ship_firstname#"
                    ShipToLName="#form.ship_lastname#"
                    ShipToCompany="#form.ship_company#"
                    ShipToStreetAddress = "#form.ship_address# #form.ship_address2#"
                    ShipToCity = "#form.ship_city#"
                    ShipToState = "#form.ship_state#"
                    ShipToZip = "#form.ship_zip#"						
                    TestRequest="#var_istest#"
                    Phone="#form.bill_phone#"
                    Company="#form.bill_company#"
                    Email="#form.emailaddress#"
                    >
            </cfoutput>				
        </cfif>
    
        <cfif form.AccountType IS 'NONE'>
        <cfoutput>
            <cf_AIM
                    Login="#var_user#"
                    TransactionKey="#var_token#"
                    hashValue="#var_hash#"
                    invoiceNum="#Form.OrderNumber#" 
                    invoiceAmt="#NumberFormat(form.OrderTotal, '__0.00')#"
                    Description="#TheCompanyName# Online Purchase" 
                    ChargeMethod="CC"
                    ChargeType="AUTH_CAPTURE"
                    CardNumber="#form.card_number#"				
                    CardExpiration="#CCExpireDate#"
                    CardCode="#form.card_cvs#" 
                    CustID="#form.OrderNumber#"
                    FName="#form.bill_firstname#"
                    LName="#form.bill_lastname#" 
                    StreetAddress="#form.bill_address#"
                    City="#form.bill_city#"
                    State="#form.bill_state#" 
                    Zip="#form.bill_zip#"
                    Country="#form.bill_country#" 
                    ShipToFName="#form.ship_firstname#"
                    ShipToLName="#form.ship_lastname#"
                    ShipToCompany="#form.ship_company#"
                    ShipToStreetAddress = "#form.ship_address# #form.ship_address2#"
                    ShipToCity = "#form.ship_city#"
                    ShipToState = "#form.ship_state#"
                    ShipToZip = "#form.ship_zip#"							
					TestRequest="#var_istest#"
                    Phone="#form.bill_phone#"
                    Company="#form.bill_company#"
                    Email="#form.emailaddress#"				
                    >
            </cfoutput>			
        </cfif>
    </cfif>
    
    <!---If echecks aren't accepted then process the credit card info--->
    <cfif NOT ISDEFINED('form.accounttype')>
        <cfoutput>
        <cf_AIM
                Login="#var_user#"
                TransactionKey="#var_token#"
                hashValue="#var_hash#"
                invoiceNum="#Form.OrderNumber#" 
                invoiceAmt="#NumberFormat(form.OrderTotal, '__0.00')#"
                Description="#TheCompanyName# Online Purchase" 
                ChargeMethod="CC"
                ChargeType="AUTH_CAPTURE"
                CardNumber="#form.card_number#"				
                CardExpiration="#CCExpireDate#"
                CardCode="#form.card_cvs#" 
                CustID="#form.OrderNumber#"
                FName="#form.bill_firstname#"
                LName="#form.bill_lastname#" 
                StreetAddress="#form.bill_address#"
                City="#form.bill_city#"
                State="#form.bill_state#" 
                Zip="#form.bill_zip#"
                Country="#form.bill_country#" 
                ShipToFName="#form.ship_firstname#"
                ShipToLName="#form.ship_lastname#"
                ShipToCompany="#form.ship_company#"
                ShipToStreetAddress = "#form.ship_address# #form.ship_address2#"
                ShipToCity = "#form.ship_city#"
                ShipToState = "#form.ship_state#"
                ShipToZip = "#form.ship_zip#"
				TestRequest="#var_istest#"
                Phone="#form.bill_phone#"
                Company="#form.bill_company#"
                Email="#form.emailaddress#"
                >
            </cfoutput>
    </cfif>
    
    <!---Store the last four if they want to store it.--->
    <cfif var_storedata IS 1>
    	<cfif var_canstoredata IS 1>
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
            CCConfirmationNumber = ''
            WHERE ordernumber = '#form.ordernumber#'
            </cfquery>
		</cfif>
    </cfif>
    
    <cfif NOT ISDEFINED('ResponseCode')>Communications Error.  Merchant, please make sure you have the correct
        settings in your control panel for your gateway!  <cfabort>
    </cfif>
    
        <cfif ResponseCode eq 1>
        <cfquery name = "UpdateOrderPaid" datasource="#request.dsn#">
                UPDATE orders
                SET paid = 'Yes'
                WHERE OrderNumber = '#form.OrderNumber#'
            </cfquery>
    
            <!---otherwise it failed so post a response and post the message--->
            <cfelse>
            <center>
            <font color="Red">Credit Card Failed</font></cfif><br>
    
             <!---Get the response from authorize.net and output it here--->
    <cfif ResponseCode neq 1>
        Unfortunately we were unable to get a verification on your credit card.<br>
        Reason: <cfif ISDEFINED('ResponseReasonText')><cfoutput><strong>#ResponseReasonText#</strong></cfoutput>
        <cfelse> The gateway did not provide a reason
        <br />
        <cfoutput>
        <table width="600" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="##0033FF">
          <tr>
            <td align="center" bgcolor="##FFCC00"><font color="##000066">If you feel there was an error in your submitted form please hit your browser back button and reenter your payment details.</font></td>
          </tr>
        </table>
        </cfoutput>
        
        </cfif>		
        <cfset processor_error = "Yes">
    </cfif>