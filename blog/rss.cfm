<cfsetting enablecfoutputonly="yes">
<cfinclude template = "queries/qry_allposts.cfm">
<cfinclude template = "queries/qry_blogsettings.cfm">
<cfset ndate = #GetHttpTimeString(Now())#>
<cfloop query = "qry_AllPosts" endrow="1">
<cfset getlatestdate = CreateDateTime(DatePart("yyyy", blog_date),DatePart("m", blog_date),DatePart("d", blog_date),DatePart("h", blog_time),DatePart("n", blog_time),DatePart("s", blog_time))>
<cfset ldate = #GetHttpTimeString(getlatestdate)#>
</cfloop>
<cfsavecontent variable="rssheader">

<cfset desc = replace(qry_BlogSettings.rss_sitedescription, "'", "&##39;", "ALL")>
<cfoutput>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
			<channel>
			<atom:link href="#request.homeurl#blog/rss.cfm" rel="self" type="application/rss+xml" />
			<title>#xmlFormat(qry_BlogSettings.rss_sitename)#</title>
			<link>#xmlFormat(request.homeURL)#</link>
			<description>#desc#</description>
			<language>en-us</language>
			<pubDate>#ndate#</pubDate>
			<lastBuildDate>#ldate#</lastBuildDate>
			<generator>CF_SiteBuilder Blog Plugin</generator>
			<docs>http://blogs.law.harvard.edu/tech/rss</docs>
			<managingEditor>#xmlFormat(qry_BlogSettings.blog_owner_email)# (#qry_BlogSettings.blog_owner#)</managingEditor>
			<webMaster>#xmlFormat(qry_BlogSettings.blog_owner_email)# (#qry_BlogSettings.blog_owner#)</webMaster>
</cfoutput>
</cfsavecontent>
<cfsavecontent variable="rsscontent">
<cfloop query="qry_AllPosts" endrow="15">
<cfset makepostdate = CreateDateTime(DatePart("yyyy", blog_date),DatePart("m", blog_date),DatePart("d", blog_date),DatePart("h", blog_time),DatePart("n", blog_time),DatePart("s", blog_time))>
<cfset pdate = #GetHttpTimeString(makepostdate)#>
<cfif qry_AllPosts.currentrow eq 1><cfset grabthisdate = pdate></cfif>
<cfinclude template="queries/qry_blogcategory.cfm">
<cfoutput>			

<cfset the_day = dateformat(blog_date, "d")>
<cfset the_month = dateformat(blog_date, "mm")>
<cfset the_year = dateformat(blog_date, "yyyy")>

			<item>
				<title>#xmlFormat(blog_headlines)#</title>
				<link>#request.homeURL#?action=blog.blog_showday&amp;d=#the_day#&amp;m=#the_month#&amp;y=#the_year#</link>
				<description>#xmlFormat(REReplace(blog_contents,"<[^>]*>","","All"))#</description>
				<category>#xmlFormat(qry_blogCategory.blog_cat_name)#</category>
				<pubDate>#pdate#</pubDate>
				<guid>#request.homeURL#?action=blog.blog_showday&amp;d=#the_day#&amp;m=#the_month#&amp;y=#the_year#</guid>
			</item>
</cfoutput>
</cfloop>
</cfsavecontent>
<cfset loadtherss = trim(rssheader & rsscontent & "</channel></rss>")>
<cfsetting enablecfoutputonly="no">
<cfoutput><cfcontent type="text/xml"><?xml version="1.0" encoding="ISO-8859-1" ?>#loadtherss#</cfoutput>

