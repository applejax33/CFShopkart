<cfif isdefined('TheItemID')>
<cfquery name = "qrydiscounts" Datasource = "#request.dsn#">
SELECT *
FROM discounts
WHERE ItemID = <cfqueryparam value="#TheItemID#" cfsqltype="cf_sql_varchar">
AND level = <cfqueryparam value="#request.pricinglevel#" cfsqltype="cf_sql_integer">
ORDER BY MinQ ASC
</cfquery>
</cfif>

<cfif isdefined('qryproducts.ItemID')>
<cfquery name = "qrydiscounts" Datasource = "#request.dsn#">
SELECT *
FROM discounts
WHERE ItemID = <cfqueryparam value="#qryproducts.ItemID#" cfsqltype="cf_sql_varchar">
AND level = <cfqueryparam value="#request.pricinglevel#" cfsqltype="cf_sql_integer">
ORDER BY MinQ ASC
</cfquery>
</cfif>

