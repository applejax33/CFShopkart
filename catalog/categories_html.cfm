<cfparam name="category" default="0">
<cfparam name="parentcat" default="0">
<cfparam name="showempty" default="1">

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
<table width="100%" cellpadding="0" cellspacing="0">
<tr>
<td height="150" valign="top">
<div id="catalogdiv">
<!---<cfinclude template = "../queries/qrycategories.cfm">--->
<table width="100%" cellpadding="0" cellspacing="0" class="CategoryTable">
<cfloop query = "qryBrowseCategories"> 

	<!---get item count--->
    <cfquery name = "qCount" datasource="#request.dsn#">
    SELECT count(*) AS totalrecords FROM product_categories JOIN products ON products.itemid = product_categories.itemid
   	WHERE product_categories.categoryid = <cfqueryparam value="#qryBrowseCategories.categoryid#" cfsqltype="cf_sql_integer"> 
    AND products.isoption = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
    <cfif request.ShowOutOfStockItems NEQ 'Yes'>
      	AND products.UnitsInStock > <cfqueryparam value="0" cfsqltype="cf_sql_integer">
	</cfif>
    </cfquery>

	<cfquery name = "qSubs" datasource="#request.dsn#">
    SELECT count(*) as totalrecords FROM categories WHERE subcategoryof = '#qryBrowseCategories.categoryid#'
    </cfquery>

	<cfoutput>
        <cfif qCount.totalrecords GT 0 OR qSubs.totalrecords GT 0 OR showempty IS 1>
            <cfset parentcat = subcategoryof>
            <tr class="CategoryRow">
            <td class="CategoryCell" onmouseover="this.className='CategoryCellHover';" onmouseout="this.className='CategoryCell';" onclick="window.location.href = 'index.cfm?carttoken=#carttoken#&action=ViewCategory&Category=#qryBrowseCategories.CategoryID#';">
                <cfif request.use_urlrewrite IS 'Yes'>
                    <a href = "#qryBrowseCategories.urlrw#" class="cateogrylinks">#qryBrowseCategories.CategoryName# <cfif qCount.totalrecords GT 0>(#qCount.totalrecords#)<cfelse>(0)</cfif></a>
                <cfelse>
                    <a href = "index.cfm?carttoken=#carttoken#&action=ViewCategory&Category=#qryBrowseCategories.CategoryID#" class="cateogrylinks">#qryBrowseCategories.CategoryName# <cfif qCount.totalrecords GT 0>(#qCount.totalrecords#)<cfelse>(0)</cfif></a>
                </cfif>
            </td>
            </tr>
        </cfif>
    </cfoutput> 
</cfloop>

<cfif NOT category IS '0'>

<cfquery name = "qryParent" datasource="#request.dsn#">
SELECT * FROM categories
WHERE categoryid = #parentcat#
</cfquery>

<cfif NOT qryParent.recordcount IS 0>
<cfoutput>
<tr class="CategoryRow">
<td class="CategoryCell" onmouseover="this.className='CategoryCellHover';" onmouseout="this.className='CategoryCell';" onclick="window.location.href = 'index.cfm?carttoken=#carttoken#&action=ViewCategory&Category=#qryParent.subcategoryof#';">
	<a href = "index.cfm?carttoken=#carttoken#&action=ViewCategory&Category=#qryParent.subcategoryof#">[Previous Category]</a>
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



