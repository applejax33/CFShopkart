<cfquery name = "qry_Categories" datasource="#request.dsn#">
SELECT * FROM blog_category
ORDER BY blog_cat_name ASC
</cfquery>

<cfquery name = "qry_Category" datasource="#request.dsn#">
SELECT * FROM blog_category
<cfif isdefined('blog_cat')>
WHERE blog_cat_id = <cfqueryparam value="#blog_cat#" cfsqltype="cf_sql_varchar">
</cfif>
ORDER BY blog_cat_name ASC
</cfquery>







