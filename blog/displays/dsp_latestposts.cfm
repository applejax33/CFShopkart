<!---displays the most recent posts--->
<table width="196" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td align="left" class="title">Latest Posts</td>
  </tr>
  <tr>
    <td align="left">
		<cfloop query="qry_AllPosts" endrow="#qry_blogsettings.dmc_count#">
		<cfoutput>
			<b class="blog_date">#dateformat(blog_date, "mmmm dd, yyyy")#<br></b>
					&raquo; <cfif request.use_urlrewrite IS 'Yes'><a class="blog_post" href="#urlrw#">#blog_headlines#</a><cfelse><a class="blog_post" href = "index.cfm?template=#template#&isplugin=yes&action=blog.blog_showblog&bid=#blog_id#">#blog_headlines#</a></cfif><br>
		</cfoutput>
		</cfloop>
		</td>
  </tr>
</table>










