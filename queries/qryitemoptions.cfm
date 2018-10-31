<cfif request.dbtype IS 'mysql'>
    <cfquery name = "qryOptions" datasource="#request.dsn#">
    SELECT * FROM products_options JOIN options ON options.optionid = products_options.optionid
    <cfif isdefined('itemid')>WHERE products_options.itemid = <cfqueryparam value="#itemid#" cfsqltype="cf_sql_varchar"></cfif>
    Order by options.orderid ASC
    </cfquery>
</cfif>

<cfif request.dbtype IS 'msaccess'>
    <cfquery name = "qryAll" datasource="#request.dsn#">
    SELECT * FROM options
    </cfquery>

	<cfset collist = qryAll.Columnlist>
    <cfset collist = replacenocase(collist, "OptionID", "products_options.optionid", "ALL")>
    <cfset collist = replacenocase(collist, "Itemid", "products_options.itemid", "ALL")>

    <cfquery name = "qryOptions" datasource="#request.dsn#">
    SELECT #collist# FROM products_options 
    LEFT JOIN options ON options.optionid = products_options.optionid
    <cfif isdefined('itemid')>WHERE products_options.itemid = <cfqueryparam value="#itemid#" cfsqltype="cf_sql_integer"></cfif>
    Order by options.orderid ASC
    </cfquery>
</cfif>



