<cfquery name = "qrySales" datasource="#request.dsn#">
SELECT * FROM sales
<cfif ISDEFINED('url.SaleID')>WHERE SaleID = <cfqueryparam value="#url.SaleID#" cfsqltype="cf_sql_varchar">
<cfelse>
WHERE level = <cfqueryparam value="#request.pricinglevel#" cfsqltype="cf_sql_integer">
</cfif>
ORDER BY StartDate ASC
</cfquery>




