<cfquery name = "qryProdCoupons" datasource="#request.dsn#">
SELECT * FROM products JOIN product_categories ON products.itemid = product_categories.itemid
WHERE product_categories.categoryid = #qryCoupons.CategoryID#
</cfquery>

<!---
<cfquery name = "qryAllproducts" Datasource = "#request.dsn#">
SELECT * FROM products 
</cfquery>		

	<!---This code below builds a query of products that match the selected category--->
	<cfset LItemID = "">
	<cfset LProductID = "">
	<cfset LProductName = "">
	<cfset LPrice = "">
	<cfset LThumbNail = "">
	<cfset LImageURL = "">
	<cfset LBriefDescription = "">
	<cfset LIsFeatured = "">
	<cfset LCategory = "">
	
	<cfset qryProdCoupons = QueryNew("")>
	
	<cfoutput query = "qryALLproducts">
	
	<!---Get the category list for this product and loop over the list.  If the list contains
	the selected category, add it to the query of products to display--->
	<cfset CategoryList = '#Category#'>
	  <cfloop index="Mycount" From="1" To='#ListLen(CategoryList, "^")#'>	
			<cfset ThisCategory = '#ListGetAt(CategoryList, mycount, "^")#'>
		
			<cfif ThisCategory IS #qryCoupons.CategoryID#>
			  
				<cfset LItemID = ListAppend(LItemID, "#ItemID#", "|")>
				<cfset LProductID = ListAppend(LProductID, "#ProductID#", "|")>
				<cfset LProductName = ListAppend(LProductName, "#ProductName#", "|")>
				<cfset LPrice = ListAppend(LPrice, "#Price#", "|")>
				<cfset LThumbNail = ListAppend(LThumbNail, "#ThumbNail#", "|")>
				<cfset LImageURL = ListAppend(LImageURL, "#ImageURL#", "|")>
				<cfset LBriefDescription = ListAppend(LBriefDescription, "#BriefDescription#", "|")>
				<cfset LIsFeatured = ListAppend(LIsFeatured, "#IsFeatured#", "|")>
				<cfset LCategory = ListAppend(LCategory, "#Category#", "|")>
	
			</cfif>
		</cfloop>
	</cfoutput>
	
	<cfset AItemID = ListToArray(LItemID, "|")>
	<cfset AProductID = ListToArray(LProductID, "|")>
	<cfset AProductName = ListToArray(LProductName, "|")>
	<cfset APrice = ListToArray(LPrice, "|")>
	<cfset AThumbNail = ListToArray(LThumbNail, "|")>
	<cfset AImageURL = ListToArray(LImageURL, "|")>
	<cfset ABriefDescription = ListToArray(LBriefDescription, "|")>
	<cfset AIsFeatured = ListToArray(LIsFeatured, "|")>
	<cfset ACategory = ListToArray(LCategory, "|")>
	
	<!---Now create a query based on the list values above--->
	<cfset nColumnNumber1 = QueryAddColumn(qryProdCoupons, "ItemID", AItemID)>
	<cfset nColumnNumber2 = QueryAddColumn(qryProdCoupons, "ProductID", AProductID)>
	<cfset nColumnNumber3 = QueryAddColumn(qryProdCoupons, "ProductName", AProductName)>
	<cfset nColumnNumber4 = QueryAddColumn(qryProdCoupons, "Price", APrice)>
	<cfset nColumnNumber5 = QueryAddColumn(qryProdCoupons, "ThumbNail", AThumbNail)>
	<cfset nColumnNumber6 = QueryAddColumn(qryProdCoupons, "BriefDescription", ABriefDescription)>
	<cfset nColumnNumber7 = QueryAddColumn(qryProdCoupons, "IsFeatured", AIsFeatured)>
	<cfset nColumnNumber8 = QueryAddColumn(qryProdCoupons, "ImageURL", AImageURL)>
	<cfset nColumnNumber9 = QueryAddColumn(qryProdCoupons, "Category", ACategory)>
--->







