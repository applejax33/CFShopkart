<!---CHECK FOR A SALE--->

<!---See if there is a sale on this item--->
<cfset SalePrice = OriginalPrice>
<cfset TodaysDate = #Now()#>
<cfset TodaysDate = dateformat(TodaysDate, "mm/dd/yyyy")>

<cfoutput query = "qrysales">

<!---look to see if there is a sale on the entire catalog--->
<cfif CategoryID IS 0 AND ProductID IS 0>
	<cfif NOT EndDate LT TodaysDate>
	<cfif SaleType IS 'PercentOff'>
		<cfset ConvertPercent = AmountOff / 100>
		<cfset TheAmountToTakeOff = SalePrice * ConvertPercent>
		<cfset SalePrice = SalePrice - TheAmountToTakeOff>
	</cfif>
	<cfif SaleType IS 'AmountOff'>
		<cfset SalePrice = SalePrice - AmountOff>
	</cfif>
	</cfif>
</cfif>
<!---look to see if there is a sale in this category--->
<cfif qrySales.CategoryID IS theCategoryID AND qrySales.ProductID IS '0'>
	<cfif NOT EndDate LT TodaysDate>
	<cfif SaleType IS 'PercentOff'>
		<cfset ConvertPercent = AmountOff / 100>
		<cfset TheAmountToTakeOff = SalePrice * ConvertPercent>
		<cfset SalePrice = SalePrice - TheAmountToTakeOff>
	</cfif>
	<cfif SaleType IS 'AmountOff'>
		<cfset SalePrice = SalePrice - AmountOff>
	</cfif>
	</cfif>
</cfif>

<!---look to see if there is a sale on this product--->
<cfif qrySales.ProductID IS theItemID>
	<cfif NOT EndDate LT TodaysDate>
	<cfif SaleType IS 'PercentOff'>
		<cfset ConvertPercent = AmountOff / 100>
		<cfset TheAmountToTakeOff = SalePrice * ConvertPercent>
		<cfset SalePrice = SalePrice - TheAmountToTakeOff>
	</cfif>
	<cfif SaleType IS 'AmountOff'>
		<cfset SalePrice = SalePrice - AmountOff>
	</cfif>
	</cfif>
</cfif>

</cfoutput>

<!---END CHECK FOR A SALE--->



