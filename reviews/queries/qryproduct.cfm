<cfquery name = "qryProduct" datasource="#request.dsn#">
SELECT * FROM products
WHERE ItemID = #itemid#
</cfquery>







