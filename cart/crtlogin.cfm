<!---Logs a customer in so that they don't have to enter all their info again if they are
      a returning customer--->
	  
<cfquery name = "FindCustomer" datasource=#request.dsn#>
SELECT *
From customerhistory
WHERE EmailAddress = <cfqueryparam value="#form.CustomerEmail#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfif FindCustomer.RecordCount IS 0>
<center><b>Sorry, that email address is not on file.</b></center>
</cfif>

<cfif NOT FindCustomer.RecordCount IS 0>
<cfset session.CUsername="#form.CustomerEmail#">
<p><center><b>Welcome back!  Thank you for shopping with us!</b></center></p>
</cfif>






