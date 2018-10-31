<cfquery name = "qry_ProductImages" datasource="#request.dsn#">
SELECT * FROM products_images
<cfif isdefined('qryFeatures.Itemid')>WHERE itemid = '#qryFeatures.Itemid#'</cfif>
ORDER BY OrderValue ASC
</cfquery>



