<cfparam name = "bid" default="0">
<cfparam name = "b_uuid" default="#bid#">
<cfparam name = "b_name" default="">
<cfparam name = "b_email" default="">
<cfparam name = "disp" default="1">
<cfparam name = "blog_contents" default="">
<cfparam name = "message" default="">

<cfinclude template = "../queries/qry_blogsettings.cfm">
<cfinclude template = "../queries/qry_post.cfm">

	<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
	<td valign="top"><div class="pad1">
	<!---Main Content Holding Cell Start--->
		<div class="blog_date">Post a Reply</div>
		<table width="100%" border="0" cellspacing="0" cellpadding="4">
		<form name="replyform" <cfoutput>action="index.cfm?template=#template#&isplugin=yes&action=blog.blog_postreply"</cfoutput> method="post">
		<cfoutput>
		<input type="hidden" name="bid" value="#bid#" />
		<input type="hidden" name="b_uuid" value="#b_uuid#" />
		<tr>
		<td colspan="2">#message#</td>
		</tr>
		<tr>
		<td width="80" class="form_post">Date</td><td class="form_post"><cfoutput>#dateFormat(now(), "dd mmm yyyy")#</cfoutput></td>
		</tr>
		<tr>
		<td width="80" class="form_post">Name</td><td class="form_post"><input type="text" name="b_name" class="form_post" size="20" value="#b_name#" /></td>
		</tr>
		<tr>
		<td width="80" class="form_post">Email</td><td class="form_post"><input type="text" name="b_email" class="form_post" size="20" value="#b_email#" /> 
		<input name="disp" type="checkbox" value="0" <cfif disp IS '0'>checked="checked"</cfif>/><span class="small">Hide my email address</span></td>
		</tr>
		<tr>
		<td width="80" valign="top" class="form_post">Reply</td>
		<td class="form_post"><textarea cols="40" rows="8" class="form_post" name="blog_contents">#blog_contents#</textarea></td>
		</tr>
		<tr>
		<td width="560" colspan="2" align="center" class="form_post"><input type="submit" class="inputstyle1" value="Post Your Comment" /></td>
		</tr>
		</cfoutput>
		<tr>
		<tr>
		<td colspan="2">&nbsp;
			
		</td>
		</tr>
		<tr>
		<td colspan="2">
		<div id="reply">
		<div class="reply_post"><div class="pad2">
		You are replying to:
		<cfloop query="qry_Post" endrow="#qry_blogsettings.index_count#">
			<cfoutput>#blog_headlines#</cfoutput>
			<cfoutput><input type = "hidden" name="blog_replyto" value="#blog_headlines#"></cfoutput>
			<cfoutput><input type = "hidden" name="blog_postdate" value="#dateformat(blog_date, 'mm/dd/yyyy')#"></cfoutput>
		</cfloop>
		</div></div></div>
		</td>
		</tr>
		</form>
		</table>
		<!--- Main content holding cell end --->
		</div> </td>
		<td width="208" valign="top" align="center">
			<cfinclude template = "../displays/dsp_rightnavigation.cfm">
		</td>
		</tr>
		</table>
</div></div>







