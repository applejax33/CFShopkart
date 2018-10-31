<cfquery name = "qry_ProductImages" datasource="#request.dsn#">
SELECT * FROM products_images
<cfif isdefined('qryProductsByBrand.Itemid')>
	WHERE itemid = <cfqueryparam value="#qryProductsByBrand.Itemid#" cfsqltype="cf_sql_varchar">
</cfif>
ORDER BY OrderValue ASC
</cfquery>



