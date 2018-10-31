<cfset form.payment_method = qryOrders.paymentmethod>

<cfinclude template = "actpaymentmethodvars.cfm">

<cfset paymentsent = 'No'>

<!---In your callback script, if peyment is confirmed set the above variable to yes--->
<cfif qProc.recordcount GT 0>
	<cfif len(trim(qProc.script_callbacks)) GT 0>
		<cfinclude template = "../callbacks/#qProc.script_callbacks#">
	</cfif>
</cfif>