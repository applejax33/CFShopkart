<cfparam name = "SearchQuery" default=" ">

<cfif request.dbtype IS 'mysql'>
<cfquery name = "qryProducts" datasource="#request.dsn#">
SELECT * FROM products JOIN product_categories ON products.itemid = product_categories.itemid
WHERE LOWER(ProductID) LIKE '%#lcase(SearchQuery)#%' AND isoption = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
<cfif request.showoutofstockitems IS 'No'>AND unitsinstock > <cfqueryparam value="0" cfsqltype="cf_sql_integer"></cfif> 
AND product_categories.categoryid > <cfqueryparam value="0" cfsqltype="cf_sql_integer">
OR LOWER(ProductName) LIKE '%#lcase(SearchQuery)#%' AND isoption = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
<cfif request.showoutofstockitems IS 'No'>AND unitsinstock > <cfqueryparam value="0" cfsqltype="cf_sql_integer"></cfif> 
AND product_categories.categoryid > <cfqueryparam value="0" cfsqltype="cf_sql_integer">
OR LOWER(Details) LIKE '%#lcase(SearchQuery)#%' AND isoption = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
<cfif request.showoutofstockitems IS 'No'>AND unitsinstock > <cfqueryparam value="0" cfsqltype="cf_sql_integer"></cfif> 
AND product_categories.categoryid > <cfqueryparam value="0" cfsqltype="cf_sql_integer">	
GROUP BY products.productid
ORDER BY product_categories.OrderValue ASC
</cfquery>
</cfif>

<cfif request.dbtype IS 'msaccess'>
<cfquery name = "qryProducts" datasource="#request.dsn#">
SELECT * FROM products JOIN product_categories ON products.itemid = product_categories.itemid
WHERE LCase(ProductID) LIKE '%#lcase(SearchQuery)#%' AND isoption = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
<cfif request.showoutofstockitems IS 'No'>AND unitsinstock > <cfqueryparam value="0" cfsqltype="cf_sql_integer"></cfif> 
AND product_categories.categoryid > <cfqueryparam value="0" cfsqltype="cf_sql_integer">
OR LCase(ProductName) LIKE '%#lcase(SearchQuery)#%' AND isoption = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
<cfif request.showoutofstockitems IS 'No'>AND unitsinstock > <cfqueryparam value="0" cfsqltype="cf_sql_integer"></cfif> 
AND product_categories.categoryid > <cfqueryparam value="0" cfsqltype="cf_sql_integer">
OR LCase(Details) LIKE '%#lcase(SearchQuery)#%' AND isoption = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
<cfif request.showoutofstockitems IS 'No'>AND unitsinstock > <cfqueryparam value="0" cfsqltype="cf_sql_integer"></cfif> 
AND product_categories.categoryid > <cfqueryparam value="0" cfsqltype="cf_sql_integer">
GROUP BY products.productid
ORDER BY product_categories.OrderValue ASC
</cfquery>
</cfif>



