<cfif ISDEFINED('form.approval_code')>
	<cfquery name="UpdatePaidStatus" datasource="#request.dsn#">
		UPDATE orders
		SET paid = 'Yes'
		WHERE OrderNumber = '#OrderNumber#'
	</cfquery>
	<cfset PaymentSent = 'yes'>
</cfif>	 
