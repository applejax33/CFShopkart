<cfquery name = "qry_ProductImages" datasource="#request.dsn#">
SELECT * FROM products_images
<cfif isdefined('qryBestSellers.Itemid')>
	WHERE itemid = <cfqueryparam value="#qryBestSellers.Itemid#" cfsqltype="cf_sql_varchar">
</cfif>
ORDER BY OrderValue ASC
</cfquery>



