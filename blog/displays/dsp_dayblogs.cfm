<!---default the date to today--->
<cfparam name="y" default="#dateformat(now(), 'yyyy')#">
<cfparam name="m" default="#dateformat(now(), 'mm')#">
<cfparam name="d" default="#dateformat(now(), 'dd')#">

<!---Create a date out the passed date--->
<cfset daydate = CreateDate (y,m,d)>

<!---query all posts on this date using the odbdateformat function--->
<cfinclude template = "../queries/qry_allposts.cfm">
<cfinclude template = "../queries/qry_blogthisday.cfm">
<cfinclude template = "../queries/qry_blogsettings.cfm">

<cfset repcount = 0>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
		<td valign="top">
		<div class="pad1">
		<!--- Main content holding cell start --->

		<cfoutput>
		<div class="blog_date">#DayofWeekAsString(DayOfWeek(daydate))#, #Day(daydate)# #MonthAsString(Month(daydate))# #Year(daydate)#</div>
		</cfoutput>

		<cfloop query="qry_OnThisDay">
		<cfinclude template = "../queries/qry_blogcategory.cfm">
		<div class="blog_item">
		<cfset tbacks = 0>
		<cfset bid = #qry_AllPosts.blog_id#>
		<cfinclude template = "../queries/qry_postcomments.cfm">
		<cfset repcount = #qry_PostComments.recordcount#>
		<cfoutput>
				<hr align="left" width="25%" size="1" color="##cfcfcf" />
				<div class="headlines">#blog_headlines#</div>				
				<div class="clear"></div>
				<div class="description">#blog_contents#</div> 
				<div class="bigclear"></div>
				<div class="blog_link">Read <a href="index.cfm?template=#template#&isplugin=yes&action=blog.blog_showblog&bid=#blog_id#">more</a> | <cfif not len(trim(repcount))>0<cfelse>#repcount#</cfif> comments<cfif tbacks eq 1> | <a href="javascript:HaloScanTB('#blog_id#');" target="_self"><script type="text/javascript">postCountTB('#blog_id#'); </script></a></cfif></div>
				<div class="clear"></div>
				<div class="blog_post">Posted By #qry_blogsettings.blog_owner# at #TimeFormat(blog_time, "h:mm tt")# <br>in Category:<a href="index.cfm?template=#template#&isplugin=yes&action=blog.blog_showCategory&blog_cat=#qry_blogCategory.blog_cat_id#">#qry_blogCategory.blog_cat_name#</a></div>
				<div class="clear"></div>
				<div class="blog_link"></div>
			</cfoutput>
			<div class="clear"></div>
		</cfloop>
		</div>
		<div class="separator"></div>
		<cfif qry_OnThisDay.recordcount IS 0>
			<div class="description">There were no posts on that day.</div> 
		</cfif>
		<!--- Main content holding cell end --->
		</div> </td>
		<td width="208" valign="top" align="center">
				<cfinclude template="dsp_rightnavigation.cfm"><br />
		</td>
		</tr>
		</table>
</div></div>
	








