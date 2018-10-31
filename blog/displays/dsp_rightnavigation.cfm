<cfif NOT isdefined('qry_AllPosts')>
	<cfinclude template = "../queries/qry_allposts.cfm">
</cfif>

<cfinclude template="dsp_calendar.cfm"><br />
<cfinclude template="dsp_latestposts.cfm"><br />
<cfinclude template="dsp_archives.cfm"><br />
<cfinclude template="dsp_categories.cfm"><br />
<cfinclude template="dsp_bloglinks.cfm"><br />
<cfinclude template="dsp_searchform.cfm"><br />
<cfoutput><a href = "#request.homeurl#blog/rss.cfm" target="_blank"><center>rss feed</center></a></cfoutput>








