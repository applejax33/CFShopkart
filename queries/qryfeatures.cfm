<cfsetting requesttimeout="1000">

<!---mysql--->
<cfif request.dbtype IS 'mysql'>
    <cfquery name = "qryFeatures" datasource="#request.dsn#">
    SELECT * FROM products JOIN product_categories ON products.itemid = product_categories.itemid
    WHERE products.IsFeatured = <cfqueryparam value="Yes" cfsqltype="cf_sql_varchar"> 
    AND product_categories.categoryid > <cfqueryparam value="0" cfsqltype="cf_sql_integer">
    GROUP BY products.productid
    ORDER by fOrderValue ASC
    </cfquery>
</cfif>

<!---MS ACCESS--->
<cfif request.dbtype IS 'msaccess'>
    <cfquery name = "qryAllItems" datasource="#request.dsn#">
    SELECT * FROM products
    </cfquery>
    
    <cfset collist = qryAllItems.Columnlist>
    <cfset collist = replacenocase(collist, "itemid", "products.itemid", "ALL")>
    
    <!---requery determine sort order--->
    <cfquery name = "qryFeatures" datasource="#request.dsn#">
    SELECT #collist# FROM products LEFT JOIN product_categories ON products.itemid = product_categories.itemid
    WHERE IsFeatured = <cfqueryparam value="yes" cfsqltype="cf_sql_varchar"> 
    AND LEN(products.subof) < <cfqueryparam value="1" cfsqltype="cf_sql_varchar"> 
    AND product_categories.categoryid > <cfqueryparam value="0" cfsqltype="cf_sql_integer">
    ORDER By fOrderValue ASC
    </cfquery>
</cfif>



