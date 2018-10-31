<cfquery name = "qrydiscounts" Datasource = "#request.dsn#">
SELECT *
FROM discounts
WHERE ItemID = <cfqueryparam value="#ThisItemID#" cfsqltype="cf_sql_integer">
</cfquery>







