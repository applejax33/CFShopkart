<cfquery name = "qryReviews" datasource="#request.dsn#">
SELECT * FROM product_reviews
WHERE itemid = '#itemid#'
<cfif isdefined('url.id')>WHERE id = '#url.id#'</cfif>
</cfquery>







