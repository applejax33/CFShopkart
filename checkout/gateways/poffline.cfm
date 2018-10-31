<!---Mark as paid if there is no processor used so it shows up in the main window--->
<cfset CCEexpiredate = "#form.card_expmonth#/#form.card_expyear#">
<cfquery name = "UpdateOrderPaid" datasource="#request.dsn#">
    UPDATE orders
    SET paid = 'Yes'
    WHERE OrderNumber = '#form.OrderNumber#'
</cfquery>

<!---Store the credit card info but only if the order is greater than $0.00 for offline processing--->
<cfif form.OrderTotal GT 0>
    <cfinclude template = '../actions/actEncryptInfo.cfm'>
    
    <cfquery name = "qryUpdateCCInfo" datasource="#request.dsn#">
	UPDATE orders
	SET CreditCardType = '#form.card_type#', 
	CreditCardNumber = '#encCreditCardNumber#', 
	CreditCardExpire = '#CCExpireDate#', 
	CCConfirmationNumber = '#encCardCode#'
	WHERE ordernumber = '#form.ordernumber#'
	</cfquery>
</cfif>







