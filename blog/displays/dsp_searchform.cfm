<!---displays the search form--->
<cfinclude template = "../queries/qry_categories.cfm">

<table width="196" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td class="title">Search </td>
  </tr>
  <form name="searchform" method="post" template=#template#&isplugin=yes&action=blog."index.cfm?template=#template#&isplugin=yes&action=blog.blog_search">
	<tr>
    <td><input name="SearchForm" type="text" id="SearchForm" size="20">
    <input type="submit" name="Submit" value="Go"></td>
  </tr>
	</form>
</table>








