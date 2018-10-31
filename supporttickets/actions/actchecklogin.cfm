<!---If the customer is not found and there is a cookie defined, clear the cookie and show the login form (this is for if 
an account is deleted--->
<cfif ISDEFINED('form.EmailAddress')>
	<cfoutput>
		<CFCOOKIE name="CustEmail" expires="1" value="#Form.EmailAddress#">
		<CFCOOKIE name="CustPassword" expires="1" value="#Form.CustPassword#">
	</cfoutput>
</cfif>

<cfif NOT ISDEFINED('cookie.CustEmail')>
	<cflocation url = "index.cfm?action=tickets.login&carttoken=#carttoken#">
</cfif>

<cfinclude template = "../queries/qrycustomers.cfm">

<cfif isdefined('cookie.CustEmail')>
	<cfif qryCustomers.recordcount IS 0>
        <cfinclude template = "../queries/qryCustomers.cfm">
        <CFCOOKIE name="CustEmail" expires="NOW" Value="None">
        <CFCOOKIE name="CustPassword" expires="NOW" Value="None">
        <CFCOOKIE name="CustomerID" expires="NOW" Value="None">
        <cflocation url = "index.cfm?action=tickets.login&errorcode=wronguser&carttoken=#carttoken#">
    </cfif>
</cfif>

<!---set customerid cookie--->
<cfoutput query = "qryCustomers">
	<CFCOOKIE name="CustomerID" expires="1" value="#CustomerID#">
</cfoutput>







