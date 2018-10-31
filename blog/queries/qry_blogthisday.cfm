<cfquery name="qry_OnThisDay" datasource="#request.dsn#">
SELECT * FROM blog_posts
WHERE blog_date = <cfqueryparam value="#CreateODBCDateTime(daydate)#" cfsqltype="cf_sql_date">
ORDER BY blog_time DESC
</cfquery>







