<!---This query selects all items in a particular category--->
<cfsetting requesttimeout="1000">

<!---mysql--->
<cfif request.dbtype IS 'mysql'>
    <cfquery name = "qryCatalog" datasource="#request.dsn#">
    SELECT * FROM products JOIN product_categories ON products.itemid = product_categories.itemid
    <cfif isdefined('currentcategory')>
    	WHERE product_categories.categoryid = <cfqueryparam value="#currentcategory#" cfsqltype="cf_sql_integer"> 
        AND product_categories.categoryid > <cfqueryparam value="0" cfsqltype="cf_sql_integer">
        AND products.isoption = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
        <cfif NOT request.ShowOutOfStockItems IS 'Yes'>
        	AND products.UnitsInStock > <cfqueryparam value="0" cfsqltype="cf_sql_integer">
	        AND products.isoption = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
		</cfif>
    <cfelse>
        <cfif NOT request.ShowOutOfStockItems IS 'Yes'>
        	AND product.UnitsInStock > <cfqueryparam value="0" cfsqltype="cf_sql_integer">
	        AND products.isoption = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
		</cfif>
    </cfif>
    GROUP BY products.productid
    ORDER by #viewby# #sortorder#
    </cfquery>
</cfif>

<!---MS ACCESS--->
<cfif request.dbtype IS 'msaccess'>
    <cfquery name = "qryAllItems" datasource="#request.dsn#">
    SELECT * FROM products WHERE isoption = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
    </cfquery>
    
    <cfset collist = qryAllItems.Columnlist>
    <cfset collist = replacenocase(collist, "itemid", "products.itemid", "ALL")>
    
    <!---requery determine sort order--->
    <cfquery name = "qryCatalog" datasource="#request.dsn#">
    SELECT #collist# FROM products LEFT JOIN product_categories ON products.itemid = product_categories.itemid
    <cfif isdefined('currentcategory')>
    	WHERE categoryid = <cfqueryparam value="#currentcategory#" cfsqltype="cf_sql_integer"> 
        AND LEN(products.subof) < <cfqueryparam value="1" cfsqltype="cf_sql_integer"> 
        AND product_categories.categoryid > <cfqueryparam value="0" cfsqltype="cf_sql_integer">
        <cfif NOT request.ShowOutOfStockItems IS 'Yes'>
        	AND UnitsInStock > <cfqueryparam value="0" cfsqltype="cf_sql_integer">
		</cfif>
    <cfelse>
        WHERE LENGTH(products.subof) 
		<cfif NOT request.ShowOutOfStockItems IS 'Yes'>
        	AND UnitsInStock > <cfqueryparam value="0" cfsqltype="cf_sql_integer">
		</cfif>
    </cfif>
      ORDER By #viewby# #sortorder#
    </cfquery>
</cfif>