<cfparam name = "customerid" default="0" type="integer">

<CFQUERY Name ="qryCustomers" DATASOURCE="#request.dsn#">
 	SELECT *
	FROM customerhistory
	WHERE EmailAddress = <cfqueryparam value="#cookie.CustEmail#" cfsqltype="cf_sql_varchar">
    AND CustPassword = <cfqueryparam value="#cookie.CustPassword#" cfsqltype="cf_sql_varchar">
</CFQUERY>

<!---If the customer is not found and there is a cookie defined, clear the cookie and show the login form (this is for if 
an account is deleted--->
<cfif isdefined('cookie.customerid') AND qryCustomers.recordcount IS 0>
<CFCOOKIE name="CustEmail" expires="NOW" Value="0">
<CFCOOKIE name="CustPassword" expires="NOW" Value="0">
<CFCOOKIE name="CustomerID" expires="NOW" Value="0">
<cflocation url = "#request.SecureURL#index.cfm?action=myAccount">
</cfif>







