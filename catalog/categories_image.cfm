<cfparam name="category" default="0">

<cfquery name = "qryCategories" datasource="#request.dsn#">
SELECT * FROM categories 
WHERE CategoryID = <cfqueryparam value="#category#" cfsqltype="cf_sql_integer">
</cfquery>

<cfquery name = "qryBrowseCategories" datasource="#request.dsn#">
SELECT * FROM categories
WHERE subcategoryof = <cfqueryparam value="#category#" cfsqltype="cf_sql_varchar">
Order by OrderValue ASC 
</cfquery>

<!---If above query returns zero result then query again, but this time get the subs of the parent category--->
<cfif qryBrowseCategories.recordcount IS 0>
    <cfquery name = "qryBrowseCategories" datasource="#request.dsn#">
    SELECT * FROM categories 
    WHERE subcategoryof = <cfqueryparam value="#qryCategories.subcategoryof#" cfsqltype="cf_sql_varchar">
    Order by OrderValue ASC 
    </cfquery>
</cfif>

<table width="100%" cellpadding="0" cellspacing="0" class="CategoryTable">
<cfoutput query = "qryBrowseCategories"> 
<tr class="CategoryRow">
<td class="CategoryCell" onmouseover="this.className='CategoryCellHover';" onmouseout="this.className='CategoryCell';" onclick="window.location.href = 'index.cfm?carttoken=#carttoken#&action=ViewCategory&Category=#CategoryID#';">
	<a href = "index.cfm?Action=ViewCategory&Category=#CategoryID#&carttoken=#carttoken#" class="links">
			<img name="catimage#categoryid#" id="catimage#categoryid#" src = "images/#LinkImage#" border="0" <cfif NOT #LinkRImage# IS 'none'>onmouseover="this.src='images/#LinkRImage#';" onmouseout="this.src='images/#LinkImage#';"</cfif> class="LinkImage" alt="#CategoryName#" title="#categoryname#"></a>
</td>
</tr>
</cfoutput> 
</table>



