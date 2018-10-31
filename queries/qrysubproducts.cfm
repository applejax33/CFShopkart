<cfquery name = "qrySubs" datasource="#request.dsn#">
SELECT * FROM products WHERE subof = <cfqueryparam value="#qryproducts.itemid#" cfsqltype="cf_sql_varchar"> 
AND unitsinstock > <cfqueryparam value="0" cfsqltype="cf_sql_integer"> 
ORDER BY fordervalue ASC
</cfquery>



