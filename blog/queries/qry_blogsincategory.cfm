<cfquery name = "qry_BlogsInCategory" datasource="#request.dsn#">
SELECT * FROM blog_posts WHERE blog_cat = <cfqueryparam value="#blog_cat#" cfsqltype="cf_sql_varchar">
</cfquery>








