<cfparam name="dc_category" default="0">
<cfparam name="parentcat" default="0">

<cfquery name = "qryCategories" datasource="#request.dsn#">
SELECT * FROM discountclub_categories 
WHERE CategoryID = <cfqueryparam value="#dc_category#" cfsqltype="cf_sql_integer">
</cfquery>

<cfquery name = "qryBrowseCategories" datasource="#request.dsn#">
SELECT * FROM discountclub_categories
WHERE subcategoryof = <cfqueryparam value="#dc_category#" cfsqltype="cf_sql_varchar">
Order by CategoryName ASC 
</cfquery>

<!---If above query returns zero result then query again, but this time get the subs of the parent category--->
<cfif qryBrowseCategories.recordcount IS 0>
    <cfquery name = "qryBrowseCategories" datasource="#request.dsn#">
    SELECT * FROM discountclub_categories 
    WHERE subcategoryof = <cfqueryparam value="#qryCategories.subcategoryof#" cfsqltype="cf_sql_varchar">
    Order by CategoryName ASC 
    </cfquery>
</cfif>

<table width="100%" cellpadding="0" cellspacing="0">
<tr>
<td height="150" valign="top">
<div id="catalogdiv">
<!---<cfinclude template = "../queries/qrycategories.cfm">--->
<table width="100%" cellpadding="0" cellspacing="0" class="CategoryTable">
<cfoutput query = "qryBrowseCategories"> 
<cfset parentcat = subcategoryof>
<tr class="CategoryRow">
<td class="CategoryCell" onmouseover="this.className='CategoryCellHover';" onmouseout="this.className='CategoryCell';" onclick="window.location.href = 'index.cfm?carttoken=#carttoken#&action=coupons_view&dc_category=#CategoryID#';">
	<div><cfif NOT qryBrowseCategories.categoryimage IS 'None'><div style="width: 34px; float: left;"><img src = "images/#qryBrowseCategories.categoryimage#" border="0" align="absmiddle" /></div></cfif> 
    <div style="float: left; vertical-align: middle; padding-top: 6px; padding-bottom: 6px;"><a href = "index.cfm?carttoken=#carttoken#&action=coupons_view&dc_category=#CategoryID#" class="cateogrylinks">#CategoryName#</a></div></div>
</td>
</tr>
</cfoutput> 

<cfif NOT dc_category IS '0'>

<cfquery name = "qryParent" datasource="#request.dsn#">
SELECT * FROM discountclub_categories
WHERE categoryid = #parentcat#
</cfquery>

<cfif NOT qryParent.recordcount IS 0>
<cfoutput>
<tr class="CategoryRow">
<td class="CategoryCell" onmouseover="this.className='CategoryCellHover';" onmouseout="this.className='CategoryCell';" onclick="window.location.href = 'index.cfm?carttoken=#carttoken#&action=coupons_view&dc_category=#qryParent.subcategoryof#';">
	<a href = "index.cfm?carttoken=#carttoken#&action=coupons_view&dc_category=#qryParent.subcategoryof#">[Previous Category]</a>
</td>
</tr>
</cfoutput>
</cfif>
</cfif>
</table>
</div>
</td>
</tr>
</table>

