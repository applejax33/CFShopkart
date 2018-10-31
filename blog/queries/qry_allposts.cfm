<cfquery name="qry_AllPosts" datasource="#request.dsn#">
SELECT * FROM blog_posts
ORDER BY blog_date DESC
</cfquery>








