<cfif qryCustomers.recordcount IS 0>
    <CFCOOKIE name="CustEmail" expires="NOW" Value="None">
    <CFCOOKIE name="CustPassword" expires="NOW" Value="None">
    <CFCOOKIE name="PromoCode" expires="NOW" Value="None">
    <CFCOOKIE name="CustomerID" expires="NOW" Value="None">
    <cflocation url = "index.cfm?action=checkout&errorcode=wronguser&carttoken=#carttoken#">
</cfif>

<cfoutput query = "qryCustomers">
	<CFCOOKIE name="CustomerID" expires="1" value="#CustomerID#">
    <CFCOOKIE name="CustEmail" expires="1" value="#emailaddress#">
    <CFCOOKIE name="CustPassword" expires="1" value="#password#">
</cfoutput>

<cfif isdefined('form.login_emailaddress')>
	<cfoutput>
		<CFCOOKIE name="CustEmail" expires="1" value="#Form.Login_EmailAddress#">
		
		<!---encrypt the customer password entered to compare with what is in the database--->
        <cfset enc_password = #encrypt(form.Login_EmailAddress, request.seedstring)#>
       
        <CFCOOKIE name="CustPassword" expires="1" value="#enc_password#">
	</cfoutput>
</cfif>








