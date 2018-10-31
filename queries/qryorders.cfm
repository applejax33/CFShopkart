<CFQUERY Name ="qryOrder" DATASOURCE = "#request.dsn#">
SELECT *
FROM orders
<cfif isdefined('form.ordercheck')>
	WHERE OrderNumber = <cfqueryparam value="#form.ordercheck#" cfsqltype="cf_sql_varchar">
</cfif>
</CFQUERY>



