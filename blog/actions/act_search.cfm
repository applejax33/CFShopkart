<cfparam name = "searchform" default="">

<cfinclude template = "../queries/qry_blogsettings.cfm">
<cfinclude template = "../queries/qry_allposts.cfm">

<cfset repcount = 0>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
		<td valign="top">
		<cfoutput><div class="blog_date">Search: #searchform#</div></cfoutput><br>
		<div class="pad1">
		<cfif searchform IS ''>
			You must enter something in the search box!
		<cfelse>
		<!--- Main content holding cell start --->
		<cfloop query="qry_AllPosts">
		<cfif blog_headlines CONTAINS #searchform# OR blog_contents CONTAINS #searchform#>
		
			<cfset theheadline = replacenocase(blog_headlines, SearchForm, "<font color='##FFFFF' style='background:##000000;'>#SearchForm#</font>", "ALL")>
			<cfset thecontents = replacenocase(blog_contents, SearchForm, "<font color='##FFFFF' style='background:##000000;'>#SearchForm#</font>", "ALL")>
		
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
				<div class="headlines">#theheadline#</div>				
				<div class="clear"><img src="graphics/clear.gif" /></div>
				<div class="description">#thecontents#</div> 
				<div class="bigclear"><img src="graphics/clear.gif" /></div>
				<div class="blog_link">Read <a href="index.cfm?action=blog_showblog&amp;bid=#blog_id#">more</a> | 
				  <cfif not len(trim(repcount))>0<cfelse>#repcount#</cfif> comments<cfif tbacks eq 1> | <a href="javascript:HaloScanTB('#blog_id#');" target="_self"><script type="text/javascript">postCountTB('#blog_id#'); </script></a></cfif></div>
				<div class="clear"><img src="graphics/clear.gif" /></div>
				<div class="blog_post">Posted By #qry_blogsettings.blog_owner# at #TimeFormat(blog_time, "h:mm tt")# in Category:<a href="index.cfm?action=blog_showCategory&blog_cat=category=#qry_blogCategory.blog_cat_id#">#qry_blogCategory.blog_cat_name#</a></div>
				<div class="clear"><img src="graphics/clear.gif" /></div>
				<div class="blog_link"></div>
			</cfoutput>
			<div class="clear"><img src="graphics/clear.gif" /></div>
			</cfif>
		</cfloop>
		</cfif>
		</div>
		<!--- Main content holding cell end --->
		</div> </td>
		<td width="208" valign="top" align="center">
			<cfinclude template = "../displays/dsp_rightnavigation.cfm">
		</td>
		</tr>
		</table>
</div></div>








