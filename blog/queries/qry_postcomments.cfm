<cfquery name = "qry_PostComments" datasource="#request.dsn#">
SELECT * FROM blog_reply 
WHERE reply_blog_id = <cfqueryparam value="#bid#" cfsqltype="cf_sql_varchar"> 
AND approved = <cfqueryparam value="1" cfsqltype="cf_sql_varchar">
</cfquery>







