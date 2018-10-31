<cfquery name = "FindCategory" datasource="#request.dsn#">
SELECT * FROM categories WHERE CategoryID = <cfqueryparam value="#TheCategoryID#" cfsqltype="cf_sql_integer">
</cfquery>



