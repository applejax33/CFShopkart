<!---Displays the archives--->

<cfinclude template = "../queries/qry_blogarchives.cfm">

<table width="196" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td align="left" class="title">Archives</td>
  </tr>
  <tr>
    <td align="left">
		<!---Go back a maximum of 3 years--->
		<cfloop query="qry_ArchiveYears" endrow="3">
				<!---Get all the months that were posted during this year--->
				<cfquery name="qry_Months" dbtype="query">
				SELECT DISTINCT blog_month FROM qry_AllPosts WHERE blog_year = #qry_ArchiveYears.blog_year#
				</cfquery>
		<cfoutput>
			<b class="blog_date">#qry_ArchiveYears.blog_year#<br></b>
					&raquo; <a class="blog_post" href = "index.cfm?template=#template#&isplugin=yes&action=blog.blog_showmonth&m=#qry_Months.blog_month#&y=#blog_year#">#monthasstring(qry_Months.blog_month)#</a><br>
		</cfoutput>
		</cfloop>
		</td>
  </tr>
</table>








