<cfquery name = "qryFeatures" datasource="#request.dsn#">
SELECT * 
FROM products 
WHERE IsFeatured = <cfqueryparam value="Yes" cfsqltype="cf_sql_varchar">
</cfquery>







