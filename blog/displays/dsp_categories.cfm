<!---displays the categories--->
<cfinclude template = "../queries/qry_categories.cfm">

<table width="196" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td align="left" class="title">Categories</td>
  </tr>
  <tr>
    <td align="left">
		<cfloop query="qry_Categories">
		<cfset blog_cat = #blog_cat_id#>
		<cfinclude template = "../queries/qry_blogsincategory.cfm">
		<cfoutput>
			<a class="blog_post" href = "index.cfm?template=#template#&isplugin=yes&action=blog.blog_showCategory&blog_cat=#blog_cat_id#">#blog_cat_name# (#qry_BlogsInCategory.recordcount#)<br></b>
		</cfoutput>
		</cfloop>
		</td>
  </tr>
</table>










