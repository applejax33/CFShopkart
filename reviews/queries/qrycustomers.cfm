<CFQUERY Name ="qryCustomers" DATASOURCE="#request.dsn#">
 	SELECT *
	FROM customerhistory
	<cfif ISDEFINED('url.CustomerID')>WHERE CustomerID= #url.CustomerID#</cfif>
	<cfif ISDEFINED('form.EmailAddress')>
	WHERE EmailAddress = '#form.EmailAddress#' AND CustPassword = '#form.CustPassword#'
	</cfif>
	<cfif ISDEFINED('cookie.CustomerID') AND NOT ISDEFINED('form.EmailAddress') AND NOT ISDEFINED('url.customerid')>WHERE CustomerID = #cookie.CustomerID#</cfif>
</CFQUERY>

<!---If the customer is not found and there is a cookie defined, clear the cookie and show the login form (this is for if 
an account is deleted--->
<cfif isdefined('cookie.customerid') AND qryCustomers.recordcount IS 0>
<CFCOOKIE name="CustEmail" expires="NOW" Value="None">
<CFCOOKIE name="CustPassword" expires="NOW" Value="None">
<CFCOOKIE name="CustomerID" expires="NOW" Value="None">
<cflocation url = "#request.SecureURL#index.cfm?action=myAccount">
</cfif>







