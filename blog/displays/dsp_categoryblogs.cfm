<!---Displays all blogs in a specific category--->

<cfparam name = "blog_cat" default="0">


<!---query all posts on this date using the odbdateformat function--->
<cfinclude template = "../queries/qry_blogsincategory.cfm">
<cfinclude template = "../queries/qry_categories.cfm">
<cfinclude template = "../queries/qry_blogsettings.cfm">
<cfinclude template = "../queries/qry_allposts.cfm">

<cfset repcount = 0>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
		<td valign="top">
		<div class="pad1">
		<!--- Main content holding cell start --->

		<cfoutput>
		<div class="blog_date">All Post In #qry_Category.blog_cat_name#</div>
		</cfoutput>

		<cfloop query="qry_BlogsInCategory">
		<cfset bid = #qry_AllPosts.blog_id#>
		<cfinclude template = "../queries/qry_postcomments.cfm">
		<cfset repcount = #qry_PostComments.recordcount#>
		<div class="blog_item">
		<cfset tbacks = 0>
		<cfoutput>
				<hr align="left" width="25%" size="1" color="##000000" />
				<div class="blog_date">#dateformat(blog_date, "dddd, mmmm dd yyyy")#</div>
				<div class="headlines"><a href="index.cfm?template=#template#&isplugin=yes&action=blog.blog_showblog&amp;bid=#blog_id#">#blog_headlines#</a></div>
				<div class="clear">&nbsp;</div>				
				<div class="blog_link"><a href="index.cfm?template=#template#&isplugin=yes&action=blog.blog_showblog&amp;bid=#blog_id#">Read post</a> | 
				  <cfif not len(trim(repcount))>0<cfelse>#repcount#</cfif> comments<cfif tbacks eq 1> | <a href="javascript:HaloScanTB('#blog_id#');" target="_self"><script type="text/javascript">postCountTB('#blog_id#'); </script></a></cfif></div>
				<div class="clear"></div>
				<div class="blog_post">Posted By #qry_blogsettings.blog_owner# at #TimeFormat(blog_time, "h:mm tt")#<br>
				</div>
				<div class="clear"></div>
				<div class="blog_link"></div>
			</cfoutput>
			<div class="clear"></div>
		</cfloop>
		</div>
		<div class="separator"></div>
		<cfif qry_BlogsInCategory.recordcount IS 0>
			<div class="description">There are no posts in this category.</div> 
		</cfif>

		<!--- Main content holding cell end --->
		</div> </td>
		<td width="208" valign="top" align="center">
				<cfinclude template="dsp_rightnavigation.cfm"><br />
		</td>
		</tr>
		</table>
</div></div>
	








