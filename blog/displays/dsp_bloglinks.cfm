<!---displays the bookmarks--->
<cfinclude template = "../queries/qry_bloglinks.cfm">

<table width="196" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td align="left" class="title">Bookmarks</td>
  </tr>
  <tr>
    <td align="left">
		<cfloop query="qry_BlogLinks">
		<cfoutput>
			<a class="blog_post" href = "#blog_link_url#" target="_blank">#blog_link_name#</a><br>
			</b>
		</cfoutput>
		</cfloop>
		</td>
  </tr>
</table>








