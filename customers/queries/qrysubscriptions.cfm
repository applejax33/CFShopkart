<cfquery name = "qrySubscriptions" datasource="#request.dsn#">
SELECT * FROM customers_subscriptions
<cfif isdefined('cookie.CustomerID')>
	WHERE CustomerID = <cfqueryparam value="#cookie.CustomerID#" cfsqltype="cf_sql_varchar">
</cfif>
</cfquery>







