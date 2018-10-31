<!---COUPONS - Figure in any coupons added and show them here--->

<cfif not #ListLen(cart.CrtCoupons, "^")# IS 0>
	<tr> 
	  <td colspan="1" valign="middle" width="20%"><strong><font size="1">Coupon Code</font></strong></td>
	  <td colspan="4" valign="middle"><font size="1"><strong>Description</strong></font></td>
	  <td align="right" valign="middle" width="10%">&nbsp;</td>
	</tr>
	<cfloop from="1" to="#listlen(cart.CrtCoupons, '^')#" index='maincouponcount'>
	  	<cfset ThisCoupon = #ListGetAt(cart.CrtCoupons, CouponCount, "^")#>
	  	<cfinclude template = '../queries/qrycoupons.cfm'>
	  	<cfset limitstring = ''>
	  	<!---If there's a limit specify there is (not applicable to entire catalog coupons)--->
	  	<cfif NOT #qryCoupons.cLimit# IS 0>
			<cfset limitstring = 'limit #qryCoupons.cLimit#'>
	 	 </cfif>

	  	<!---***Set the description***--->

	  	<!---Off the entire store--->
	    <cfif qryCoupons.ProductID IS '0' AND qryCoupons.CategoryID IS '0'>
			<cfif qryCoupons.PromoType IS 'PercentOff'>
			  <cfset ThisDescription = '#qryCoupons.AmountOFf#% off Entire Order'>
			  <!---Figure up the total to take off for coupons--->
			  <cfset PercentageDiscount = #qryCoupons.AmountOff# / 100>
			  <cfset FiguredDiscount = #Cart.OrderTotal# * #PercentageDiscount#>
			  <cfset CouponsTotal = #CouponsTotal# + FigureDiscount>
			</cfif>
			<cfif qryCoupons.PromoType IS 'AmountOff'>
			  <cfif #request.EnableEuro# IS 'Yes'>
				<cfset ThisDescription = '#lseurocurrencyformat(qryCoupons.AmountOFf, "Local")# off entire order'>
			  </cfif>
			  <cfif NOT #request.EnableEuro# IS 'Yes'>
				<cfset ThisDescription = '#lscurrencyformat(qryCoupons.AmountOFf, "Local")# off entire order'>
			  </cfif>
			  <cfset CouponsTotal = #CouponsTotal# + #qryCoupons.AmountOff#>
			</cfif>
	  	</cfif>

	  	<!---Off a specific Category--->
	  	<cfif qryCoupons.ProductID IS '0' AND NOT qryCoupons.CategoryID IS '0'>
			 <cfquery name = "LookupCategory" datasource="#request.dsn#">
			 SELECT * FROM categories WHERE CategoryID = <cfqueryparam value="#qryCoupons.CategoryID#" cfsqltype="cf_sql_integer"> 
			 </cfquery>
			  <!---Figure out which items in the cart are in the specified Category and then figure
				 up a total to take the discount from--->
		  		<cfinclude template = "../queries/qryprodcoupons.cfm">
		  		<!---Loop over the custom query and find each item in the shopping cart and calculate the
					amount to take off from.  If the TotalToTakeFrom is 0 then that means there are no
					product from the specified category and so therefore, the coupon won't apply--->
		  		<cfset TotalToTakeFrom = 0>
		  		<cfset TotalItemsApplied = 0>
		  		<!---for amount off, used to determin the amount to multiply
					by.  This number is restricted by the limit--->
		  		<cfloop query = "qryProdCoupons">
					<cfloop from="1" to="#ListLen(cart.crtItemID, '^')#" index="itemidcount">
			  			<cfset ThisItemID = #ListGetAt(cart.crtItemID, itemidcount, "^")#>
			  			<!---If there is a limit then take that in to consideration--->
			  			<cfif NOT qryCoupons.cLimit IS 0>
							<!---if the number of items is greater than the limit imposed by this coupon then don't
					 			continue to add to the totaltotakefrom--->
							<cfif NOT qrycount GT qryCoupons.cLimit>
				  				<cfif ThisItemID IS qryProdCoupons.ItemID>
									<cfset TotalItemsApplied = TotalItemsApplied + 1>
									<!---For amount off calcs, see comment above--->
									<cfset ThisPrice = #ListGetAt(cart.crtPrice, itemidcount, "^")#>
									<cfset TotalToTakeFrom = TotalToTakeFrom + ThisPrice>
				  				</cfif>
							</cfif>
			  			</cfif>
			  			<!---If there is not limit then just figure it up--->
			 			 <cfif NOT qryCoupons.cLimit IS 0>
							<cfif ThisItemID IS qryProdCoupons.ItemID>
				  				<cfset TotalItemsApplied = TotalItemsApplied + 1>
				  				<!---For amount off calcs, see comment above--->
								<cfset ThisPrice = #ListGetAt(cart.crtPrice, itemidcount, "^")#>
								<cfset TotalToTakeFrom = TotalToTakeFrom + ThisPrice>
							</cfif>
			 			 </cfif>
					</cfloop>
		  		</cfloop>

		  		<!---If it's percent off--->
		  		<cfif qryCoupons.PromoType IS 'PercentOff'>
					<cfset ThisDescription = '#qryCoupons.AmountOFf#% off #LookUpCategory.CategoryName# #cLimitstring#'>
					<!---Figure the discount amount and take it off the total to take from figured above--->
					<!---If there are products in the category this coupon applies to then add in the discount--->
					<cfif TotalToTakeFrom GT 0>
						  <cfset PercentageDiscount = #qryCoupons.AmountOff# / 100>
						  <cfset FiguredDiscount = #TotalToTakeFrom# * #PercentageDiscount#>
						  <cfset CouponsTotal = #CouponsTotal# + FigureDiscount>
					</cfif>
		 		 </cfif>
		  		 <!---If it's amount off--->
		  		 <cfif qryCoupons.PromoType IS 'AmountOff'>
					<cfif NOT #qryCoupons.cLimit# IS 0>
			  			<cfset limitstring = 'limit #qryCoupons.cLimit#'>
					</cfif>
					<cfif #request.EnableEuro# IS 'Yes'>
			  			<cfset ThisDescription = '#lseurocurrencyformat(qryCoupons.AmountOff, "Local")# off #LookUpCategory.CategoryName# #limitstring#'>
					</cfif>
					<cfif NOT #request.EnableEuro# IS 'Yes'>
			  			<cfset ThisDescription = '#lscurrencyformat(qryCoupons.AmountOff, "Local")# off #LookUpCategory.CategoryName# #limitstring#'>
					</cfif>
					<!---Multiply the Total Items this applies to (established by the limit)--->
					<cfset AmounToTakeOff = #qryCoupons.AmountOff# * #TotalItemsApplied#>
					<cfset CouponsTotal = #CouponsTotal# + #AmountToTakeOff#>
		  		</cfif>
	  	</cfif>

	 	<!---Off a specific Product--->
	  	<cfif NOT qryCoupons.ProductID IS '0' AND NOT qryCoupons.CategoryID IS '0'>
		  	<cfquery name = "LookupProduct" datasource="#request.dsn#">
		  	SELECT * FROM products WHERE ItemID = <cfqueryparam value="#qryCoupons.ProductID#" cfsqltype="cf_sql_integer">
		  	</cfquery>
		  	<!---see if the specified item is in the cart and if so then give the discount.  If not
				no discount will be given--->
		  	<cfset TotalToTakeFrom = 0>
		  	<cfset TotalItemsApplied = 0>
			<!---for amount off, used to determine the amount to multiply
					by.  This number is restricted by the limit (if there is one)--->
		  	<cfloop from="1" to="#ListLen(cart.crtItemID, '^')#" index="itemidcount">
				<cfset ThisItemID = #ListGetAt(cart.crtItemID, itemidcount, "^")#>
				<cfif ThisItemID IS LookupProduct.ItemID>
					  <cfset ThisPrice = #ListGetAt(cart.crtPrice, itemidcount, "^")#>
				 	  <cfset ThisQuantity = #ListGetAt(cart.crtQuantity, itemidcount, "^")#>
				  		<!---If there is no limit then set the discount amount to the total--->
				  	   	<cfif qryCoupons.cLimit IS 0>
							<cfset TotalToTakeFrom = TotalToTakeFrom + (ThisPrice * ThisQuantity)>
							<cfset TotalItemsApplied = ThisQuantity>
				  	   	</cfif>
				  		<!---If there is a limit set to the number they can get a discount on, then
						 figure up the amount the discount will apply to--->
				  		<cfif NOT qryCoupons.cLimit IS 0>
						<!---If the number ordered is less than or equal to the limit then set the 
							values to whatever the quantity is--->
							<cfif ThisQuantity LT qryCoupons.cLimit OR ThisQuantity IS qryCoupons.cLimit>
								  <cfset TotalToTakeFrom = TotalToTakeFrom + (ThisPrice * ThisQuantity)>
								  <cfset TotalItemsApplied = ThisQuantity>
							</cfif>
							<!---If the number ordered is greater than or equal to the limit then set the 
								values to whatever the limit is--->
							<cfif ThisQuantity GT qryCoupons.cLimit>
								  <cfset TotalToTakeFrom = TotalToTakeFrom + (ThisPrice * cLimit)>
								  <cfset TotalItemsApplied = qryCoupons.cLimit>
							</cfif>
						</cfif>
				</cfif>
			</cfloop>

		  <!---If it's percent off--->
		  <cfif qryCoupons.PromoType IS 'PercentOff'>
				<cfset ThisDescription = '#qryCoupons.AmountOFf#% off #LookUpProduct.ProductName# #limitstring#'>
				<cfif TotalToTakeFrom GT 0>
					  <cfset PercentageDiscount = #qryCoupons.AmountOff# / 100>
					  <cfset FiguredDiscount = #TotalToTakeFrom# * #PercentageDiscount#>
					  <cfset CouponsTotal = #CouponsTotal# + FigureDiscount>
				</cfif>
		  </cfif>
		  <!---If it's amount off--->
		  <cfif qryCoupons.PromoType IS 'AmountOff'>
			<cfif #request.EnableEuro# IS 'Yes'>
			  <cfset ThisDescription = '#lseurocurrencyformat(qryCoupons.AmountOff, "Local")# off #LookUpProduct.ProductName# #limitstring#'>
			</cfif>
			<cfif NOT #request.EnableEuro# IS 'Yes'>
			  <cfset ThisDescription = '#lscurrencyformat(qryCoupons.AmountOff, "Local")# off #LookUpProduct.ProductName# #limitstring#'>
			</cfif>
			<!---Multiply the Total Items this applies to (established by the limit)--->
			<cfset AmounToTakeOff = #qryCoupons.AmountOff# * #TotalItemsApplied#>
			<cfset CouponsTotal = #CouponsTotal# + #AmountToTakeOff#>
		  </cfif>

		</cfif><!---End if for Specific Product--->

		  <cfoutput> 
			<tr> 
			  <td colspan="1" valign="middle">#ThisCoupon#</td>
			  <td colspan="4" valign="middle">#ThisDescription#</td>
			  <td align="right" valign="middle">&nbsp;</td>
			</tr>
		  </cfoutput>
	   
	</cfloop>
</cfif>



