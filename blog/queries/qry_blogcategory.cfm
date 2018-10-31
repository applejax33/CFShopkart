<cfquery name = "qry_blogCategory" datasource="#request.dsn#">
SELECT * FROM blog_category
WHERE blog_cat_id = <cfqueryparam value="#blog_cat#" cfsqltype="cf_sql_varchar">
</cfquery>







