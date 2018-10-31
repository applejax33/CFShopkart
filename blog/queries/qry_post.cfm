<cfquery name = "qry_Post" datasource="#request.dsn#">
SELECT * FROM blog_posts
WHERE blog_id = <cfqueryparam value="#bid#" cfsqltype="cf_sql_varchar">
</cfquery>








