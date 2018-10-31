<cfquery name="LoadComments" datasource="#request.dsn#">
select * FROM	blog_reply
WHERE approved = <cfqueryparam value="1" cfsqltype="cf_sql_integer">
<cfif isdefined('day_blog_id')>
	WHERE reply_blog_id = <cfqueryparam value="#day_blog_id#" cfsqltype="cf_sql_varchar">
</cfif>
</cfquery>








