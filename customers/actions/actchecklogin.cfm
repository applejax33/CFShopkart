<!---If the customer is not found and there is a cookie defined, clear the cookie and show the login form (this is for if 
an account is deleted--->
<cfif ISDEFINED('form.EmailAddress')>
	<cfoutput>
		<CFCOOKIE name="CustEmail" expires="1" value="#Form.EmailAddress#">

		<!---encrypt the customer password entered to compare with what is in the database--->
        <cfset enc_password = #encrypt(form.custpassword, request.seedstring)#>
        
        <cfcookie name="CustPassword" expires="1" value="#enc_password#">

	</cfoutput>
</cfif>

<cfif ISDEFINED('form.Login_EmailAddress')>
	<cfoutput>
		<CFCOOKIE name="CustEmail" expires="1" value="#Form.Login_EmailAddress#">

		<!---encrypt the customer password entered to compare with what is in the database--->
        <cfset enc_password = #encrypt(form.Login_Password, request.seedstring)#>
        
        <cfcookie name="CustPassword" expires="1" value="#enc_password#">

	</cfoutput>
</cfif>

<cfif NOT ISDEFINED('cookie.CustEmail')>
	<cfif NOT isdefined('form.ischeckingout')>
	    <cflocation url = "index.cfm?action=customers_login&carttoken=#carttoken#">
	<cfelse>
   		<cflocation url = "index.cfm?action=checkout&carttoken=#carttoken#">
    </cfif>
</cfif>


<cfinclude template = "../queries/qrycustomers.cfm">

<cfif isdefined('cookie.CustEmail')>
	<cfif qryCustomers.recordcount IS 0>
        <cfinclude template = "../queries/qryCustomers.cfm">
        <CFCOOKIE name="CustEmail" expires="NOW" Value="None">
        <CFCOOKIE name="CustPassword" expires="NOW" Value="None">
        <CFCOOKIE name="CustomerID" expires="NOW" Value="None">

       	<cfif NOT isdefined('form.ischeckingout')>      
	        <cflocation url = "index.cfm?action=customers_login&errorcode=wronguser&carttoken=#carttoken#">
		<cfelse>
	   		<cflocation url = "index.cfm?action=checkout&errorcode=wronguser&carttoken=#carttoken#">
        </cfif>

    </cfif>
</cfif>

<!---set customerid cookie--->
<cfoutput query = "qryCustomers">
	<CFCOOKIE name="CustomerID" expires="1" value="#CustomerID#">
</cfoutput>

<cfif isdefined('form.ischeckingout')>
	<cflocation url = "index.cfm?action=checkout&carttoken=#carttoken#">
</cfif>