<cfquery name = "qry_ProductImages" datasource="#request.dsn#">
SELECT * FROM products_images
<cfif not isdefined('productquery.itemid') AND NOT isdefined('thisitemid')>
	<cfif isdefined('qryproducts.Itemid')>
    	WHERE itemid = <cfqueryparam value="#qryproducts.Itemid#" cfsqltype="cf_sql_varchar">
	</cfif>
</cfif>
<cfif not isdefined('thisitemid')>
	<cfif isdefined('ProductQuery.Itemid')>
		WHERE itemid = <cfqueryparam value="#ProductQuery.Itemid#" cfsqltype="cf_sql_varchar">
	</cfif>
</cfif>
<cfif isdefined('ThisItemid')>
	WHERE itemid = <cfqueryparam value="#ThisItemid#" cfsqltype="cf_sql_varchar">
</cfif>
ORDER BY OrderValue ASC
</cfquery>

<cfquery name = "qry_AProductImages" datasource="#request.dsn#">
SELECT * FROM products_images
<cfif not isdefined('qryAdvSearch.itemid') AND NOT isdefined('thisitemid')>
	<cfif isdefined('qryproducts.Itemid')>
    	WHERE itemid = <cfqueryparam value="#qryproducts.Itemid#" cfsqltype="cf_sql_varchar">
 	</cfif>
</cfif>
<cfif not isdefined('thisitemid') and not isdefined('qryproducts.itemid')>
	<cfif isdefined('qryAdvSearch.Itemid')>
    	WHERE itemid = <cfqueryparam value="#qryAdvSearch.Itemid#" cfsqltype="cf_sql_varchar">
	</cfif>
</cfif>
<cfif isdefined('ThisItemid')>
	WHERE itemid = <cfqueryparam value="#ThisItemid#" cfsqltype="cf_sql_varchar">
</cfif>
ORDER BY OrderValue ASC
</cfquery>



