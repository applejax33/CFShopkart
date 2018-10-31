<cfif fileexists('#request.catalogpath#docs#request.bslash#comments_header.cfm')>
	<cfinclude template = "/docs/comments_header.cfm">
</cfif>

<cfquery name="qryComments" datasource="#request.dsn#">
SELECT * FROM comments
WHERE approved = '1'
</cfquery>
 <cfif qryComments.recordcount IS 0>
	<i>There are currently no comments.  Please use the for above to be the first to comment.</i>
<cfelse>

<hr />    
<table width="100%" cellpadding="6" cellspacing="0">
<cfoutput query = "qryComments">
<tr>
<td width="27%" valign="middle" bgcolor="##E8E8E8" style="border-bottom: ##666666 1px solid;">Posted on: #dateformat(post_date, "mmm dd, yyyy")#<br>
Posted by: #poster_name#</td>
<td width="73%" valign="top" style="border-bottom: ##666666 1px solid;">#comment#</td>
</tr>
</cfoutput>
</table>

</cfif>

<cfif fileexists('#request.catalogpath#docs#request.bslash#comments_footer.cfm')>
	<cfinclude template = "/docs/comments_footer.cfm">
</cfif>




