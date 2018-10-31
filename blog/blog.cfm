<cfparam name = "action" default = "default">
<cfparam name = "mytoken" default = "0">
<cfparam name = "template" default = "NA">
<cfset request.action = action>

<cfif listlen(request.action, ".") GT 1>
	<cfset request.action = listgetat(request.action, 2, ".")>
</cfif>

<cfinclude template = 'actions/act_loadcss.cfm'>

<cfswitch expression="#request.action#">
	<cfcase value="blog_showday">
		<cfinclude template = "displays/dsp_dayblogs.cfm">
	</cfcase>
	<cfcase value="blog_showmonth">
		<cfinclude template = "displays/dsp_monthblogs.cfm">
	</cfcase>
	<cfcase value="blog_showCategory">
		<cfinclude template = "displays/dsp_categoryblogs.cfm">
	</cfcase>
	<cfcase value="blog_showBlog">
		<cfinclude template = "displays/dsp_post.cfm">
	</cfcase>
	<cfcase value="blog_search">
		<cfinclude template = "actions/act_search.cfm">
	</cfcase>
	<cfcase value="blog_reply">
		<cfinclude template = "forms/frm_reply.cfm">
	</cfcase>
	<cfcase value="blog_postreply">
		<cfinclude template = "actions/act_postreply.cfm">
	</cfcase>
	<cfcase value="blog_showrss">
		<cfinclude template = "displays/dsp_rss.cfm">
	</cfcase>
	<cfdefaultcase>
		<cfinclude template = "displays/dsp_main.cfm">
	</cfdefaultcase>
</cfswitch>



