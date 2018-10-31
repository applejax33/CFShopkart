<cfparam name = "bid" default="0">

<cfinclude template = "../queries/qry_blogsettings.cfm">
<cfinclude template = "../queries/qry_post.cfm">

<cfset repcount = 0>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
		<td valign="top">
		<div class="pad1">
		<!--- Main content holding cell start --->
		<cfloop query="qry_Post" endrow="#qry_blogsettings.index_count#">
		<cfinclude template = "../queries/qry_blogcategory.cfm">
		<cfoutput>
		<div class="blog_date">#DayofWeekAsString(DayOfWeek(blog_date))#, #Day(blog_date)# #MonthAsString(Month(blog_date))# #Year(blog_date)#</div>
		</cfoutput>
		<div class="blog_item">
		<cfset tbacks = 0>
		<cfoutput>
				<hr align="left" width="25%" size="1" color="##cfcfcf" />
				<div class="headlines">#blog_headlines#</div>				
				<div class="clear"></div>
				<div class="description">#blog_contents#</div> 
				<div class="bigclear"></div>
				<div class="blog_link"></div>
				<div class="clear"></div>
				<div class="blog_post">Posted By #qry_blogsettings.blog_owner# at #TimeFormat(blog_time, "h:mm tt")# <br>in Category:<a href="index.cfm?isplugin=yes&action=blog.blog_showCategory&blog_cat=#qry_blogCategory.blog_cat_id#">#qry_blogCategory.blog_cat_name#</a></div>
				<div class="clear"></div>
				<div class="blog_link"></div>
				</cfoutput>				
				<!---show the comments--->
				<cfinclude template = "../queries/qry_postcomments.cfm">
			<div class="clear"></div>
			<!---Show replies--->
			<div id="reply"><div class="pad2">
			<p>
			<div class="reply_title"><b>Replies</b><cfoutput> [<a href="index.cfm?template=#template#&isplugin=yes&action=blog.blog_reply&amp;bid=#blog_id#">Post Reply</a>]</cfoutput> </div>
				
			<cfif qry_PostComments.recordcount EQ 0>
				<div class="reply_post">No replies yet.</div>
			</cfif>		
				<cfloop query = "qry_PostComments">
				<cfoutput>
				<div class="reply_post" style="width:350; overflow:auto;">#dateformat(reply_date,"d mmm yyyy")#<br clear="all" />
				<cfif display_email EQ 0><b>#reply_name#</b><cfelse><a href="mailto:#reply_email#">#reply_name#</a></cfif>
			<br clear="all" />#reply_contents#<br /><br /></div>
			<div class="separator"></div>				
			  </cfoutput>
				</cfloop>
			</div>
		</div>
		</cfloop>
		<!--- Main content holding cell end --->
		</div> </td>
		<td width="200" valign="top" align="center">
			<cfinclude template = "dsp_rightnavigation.cfm">
		</td>
		</tr>
		</table>
</div></div>







