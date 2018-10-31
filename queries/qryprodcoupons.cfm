<cfquery name = "qryProdCoupons" datasource="#request.dsn#">
SELECT * FROM products JOIN product_categories ON products.itemid = product_categories.itemid
WHERE product_categories.categoryid = #qryCoupons.CategoryID#
</cfquery>



