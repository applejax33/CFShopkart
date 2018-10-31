<cfinclude template = "../queries/qry_blogsettings.cfm">

<cfoutput query = "qry_BlogSettings">
	<cfset notify = qry_BlogSettings.notify>
</cfoutput>

<cfparam name="message" default="">

<cfset error=0>
	<cfif NOT len(trim(form.b_name))>
		<cfset error=1>
		<cfset message=message & "Please enter a your name<br>">
	</cfif>

	<cfif NOT REFind(".+@.+#request.bslash#..+",form.b_email)>
		<cfset error=1>
		<cfset message=message & "Please enter a valid email address<br>">
	</cfif>	

	<cfif NOT len(trim(form.blog_contents))>
		<cfset error=1>
		<cfset message=message & "Please enter your comment<br>">
	</cfif> 

	<cfif NOT error>

	<cfset replydate = #CreateODBCDateTime(now())#>
	<cfset replyuuid = #CreateUUID()#>

	<!---remove html tags--->
	<cfscript>
		form.blog_contents = Replace(form.blog_contents, '<', '&lt;','ALL');
		form.blog_contents = Replace(form.blog_contents, '>', '&gt;','ALL');
		form.blog_contents = Replace(form.blog_contents, Chr(10), '<br />', 'ALL');
	</cfscript>

<cfquery name="ReplyPost" datasource="#request.dsn#">
INSERT INTO blog_reply
(reply_id,reply_date,reply_blog_id,reply_email,reply_name,reply_contents<cfif IsDefined("form.disp")>,display_email</cfif>)
values
(<cfqueryparam value="#replyuuid#" cfsqltype="cf_sql_varchar">,
<cfqueryparam value="#replydate#" cfsqltype="cf_sql_integer">,
<cfqueryparam value="#form.b_uuid#" cfsqltype="cf_sql_varchar">,
<cfqueryparam value="#form.b_email#" cfsqltype="cf_sql_varchar">,
<cfqueryparam value="#form.b_name#" cfsqltype="cf_sql_varchar">,
<cfqueryparam value="#form.blog_contents#" cfsqltype="cf_sql_varchar">
<cfif IsDefined("form.disp")>
,<cfqueryparam value="#form.disp#" cfsqltype="cf_sql_varchar">
</cfif>)
</cfquery>

		<cfif notify eq 1>
				<cfmail TO="#qry_blogsettings.notifyemail#"
				FROM="#form.b_email#"
				SUBJECT="Comment posted to your blog" 
				type="html">
				#form.b_name# has posted a comment to your post titled
				"#form.blog_replyto#" you posted on #form.blog_postdate#
				</cfmail>  
		</cfif>
	
	<cflocation url = "index.cfm?action=blog.blog_showBlog&bid=#form.bid#&isplugin=yes&template=#template#">
	
	</cfif>

	<cfif error>
		<cfinclude template = "../forms/frm_reply.cfm">
	</cfif>







