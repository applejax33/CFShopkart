<cfinclude template = "../queries/qry_blogsettings.cfm">
<cfinclude template = "../queries/qry_allposts.cfm">

<cfset repcount = 0>

<h2>Latest Blog Posts</h2>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
		<td valign="top">
		<div class="pad1">
		<!--- Main content holding cell start --->
		<cfloop query="qry_AllPosts" endrow="#qry_blogsettings.index_count#">
		<cfinclude template = "../queries/qry_blogcategory.cfm">
		<cfset bid = #qry_AllPosts.blog_id#>
		<cfinclude template = "../queries/qry_postcomments.cfm">
		<cfset repcount = #qry_PostComments.recordcount#>
		<cfoutput>
		<div class="blog_date">#DayofWeekAsString(DayOfWeek(blog_date))#, #Day(blog_date)# #MonthAsString(Month(blog_date))# #Year(blog_date)#</div>
		</cfoutput>
		<div class="blog_item">
		<cfset tbacks = 0>
		<cfoutput>
				<hr align="left" width="25%" size="1" color="##cfcfcf" />
				<div class="headlines"><cfif request.use_urlrewrite IS 'Yes'><a href = "#urlrw#">#blog_headlines#</a><cfelse><a href="index.cfm?template=#template#&isplugin=yes&action=blog.blog_showblog&amp;bid=#blog_id#">#blog_headlines#</a></cfif></div>				
				<div class="clear"></div>
				<!---<div class="description">
				<cfset theblog_contents = rereplacenocase(blog_contents, '<?img.*?>', '(IMAGE)', 'All')>
				<cfif len(blog_contents) GT 255>
					<cfset theblog_contents = rereplacenocase(blog_contents, '<?img.*?>', '(IMAGE)', 'All')>
  			  <cfset theblog_contents = '#left(theblog_contents, 255)#...'>
					 #theblog_contents#
					<cfelse>
						#theblog_contents#
					</cfif>
					</div> --->
				<div class="bigclear"></div>
				<div class="blog_link">Read <cfif request.use_urlrewrite IS 'Yes'><a href = "#urlrw#">more</a> <cfelse><a href="index.cfm?template=#template#&isplugin=yes&action=blog.blog_showblog&amp;bid=#blog_id#">more</a></cfif> | 
				  <cfif not len(trim(repcount))>0<cfelse>#repcount#</cfif> comments<cfif tbacks eq 1> | <a href="javascript:HaloScanTB('#blog_id#');" target="_self"><script type="text/javascript">postCountTB('#blog_id#'); </script></a></cfif></div>
				<div class="clear"></div>
				<div class="blog_post">Posted By #qry_blogsettings.blog_owner# at #TimeFormat(blog_time, "h:mm tt")#<br> in Category:<a href="index.cfm?template=#template#&isplugin=yes&action=blog.blog_showCategory&blog_cat=#qry_blogCategory.blog_cat_id#">#qry_blogCategory.blog_cat_name#</a></div>
				<div class="clear"></div>
				<div class="blog_link"></div>
			</cfoutput>
			<div class="clear"></div>
			<div class="separator"></div>
		</cfloop>
		</div>
		<!--- Main content holding cell end --->
		</div> </td>
		<td width="208" valign="top" align="center">
			<cfinclude template = "dsp_rightnavigation.cfm">
		</td>
		</tr>
		</table>
</div></div>







