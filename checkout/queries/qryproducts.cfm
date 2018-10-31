<cfquery name = "qryproducts" Datasource="#request.dsn#">
SELECT *
FROM products
<cfif ISDEFINED('url.itemid')>
	WHERE ItemID = <cfqueryparam value="#url.itemid#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ISDEFINED('TheProductID')>
	WHERE ProductID = <cfqueryparam value="#TheProductID#" cfsqltype="cf_sql_varchar">
</cfif>
<cfif ISDEFINED('SearchQuery')>
	WHERE ProductID LIKE <cfqueryparam value="%#SearchQuery#%" cfsqltype="cf_sql_varchar">
	OR ProductName LIKE <cfqueryparam value="%#SearchQuery#%" cfsqltype="cf_sql_varchar"> 
    OR Details LIKE <cfqueryparam value="%#SearchQuery#%" cfsqltype="cf_sql_varchar">
</cfif>
ORDER BY ProductName ASC
</cfquery>







