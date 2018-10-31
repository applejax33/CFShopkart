<cfquery name = "qryBlogPosts" datasource="#request.dsn#">
SELECT * FROM blog_posts
ORDER BY id DESC
</cfquery>

<cfoutput query = "qryBlogPosts" maxrows="1">

<!---remove all HTML from entry--->
<cfset thepost = ReReplaceNoCase(#blog_contents#,"<[^>]*>","","ALL")>
<b>#blog_headlines#<br></b>
<p>
#left(thepost, 100)#...<a href="index.cfm?isplugin=yes&action=blog.blog_showblog&bid=#blog_id#">more</a>
</cfoutput>




