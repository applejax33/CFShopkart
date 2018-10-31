<cfquery name="qry_OnThisMonth" datasource="#request.dsn#">
SELECT * FROM blog_posts
WHERE blog_month = <cfqueryparam value="#m#" cfsqltype="cf_sql_integer">
AND blog_year = <cfqueryparam value="#y#" cfsqltype="cf_sql_integer">
ORDER BY blog_time DESC
</cfquery>







