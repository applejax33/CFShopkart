<cfquery name = "qryCustEmail" datasource = "#request.dsn#">
SELECT *
FROM customerhistory
Where CustomerID = <cfqueryparam value="#CustomerID#" cfsqltype="cf_sql_varchar">
</cfquery>







