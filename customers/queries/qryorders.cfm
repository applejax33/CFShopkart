<CFQUERY Name ="qryOrders" DATASOURCE = "#request.dsn#">
SELECT *
FROM orders
<cfif isdefined('url.OrderID')>
	WHERE OrderID = <cfqueryparam value="#url.OrderID#" cfsqltype="cf_sql_integer"> 
    AND paid = <cfqueryparam value="Yes" cfsqltype="cf_sql_varchar">
<cfelse>
	WHERE paid = <cfqueryparam value="Yes" cfsqltype="cf_sql_varchar">
    AND  customerid = <cfqueryparam value="#cookie.customerid#" cfsqltype="cf_sql_varchar"> 
</cfif>
ORDER BY dateoforder DESC
</CFQUERY>







