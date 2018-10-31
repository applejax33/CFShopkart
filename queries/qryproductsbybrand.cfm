<cfquery name = "qryProductsByBrand" datasource="#request.dsn#">
SELECT * from products
WHERE brand = <cfqueryparam value="#brandselected#" cfsqltype="cf_sql_varchar">
ORDER BY fordervalue ASC
</cfquery>



