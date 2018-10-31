<!---This file updates the cart contents.--->
<cfparam name = "CouponError" default="">
<cfparam name = "ItemToAdd" default="0">
<cfparam name = "couponcode" default="">

<!---Create temporary variables to use instead of accessing the session variables over and over--->
<cflock scope="Session" type="EXCLUSIVE" timeout="10">
<cfoutput>
<cfset cart.CrtItemID = '#session.CrtItemID#'>
<cfset cart.CrtProductID = '#session.CrtProductID#'>
<cfset cart.CrtProductName = '#session.CrtProductName#'>
<cfset cart.CrtQuantity = '#session.CrtQuantity#'>
<cfset cart.CrtPrice = '#session.CrtPrice#'>
<cfset cart.CrtWeight = '#session.CrtWeight#'>
<cfset cart.CrtThumbNails = '#session.CrtThumbNails#'>
<cfset Cart.CrtOptions = '#session.CrtOptions#'>
<cfset Cart.CrtType = '#session.CrtType#'>
<cfset Cart.CrtApproved = '#session.CrtApproved#'>
<cfset cart.CrtCoupons = '#session.CrtCoupons#'>
<cfset cart.CrtOptionFields = '#session.CrtOptionFields#'>
</cfoutput>
</cflock>

<!---If the cart is not emtpy them process the update--->
<cfif NOT cart.CrtItemID IS ''>

<!---First update the quantities--->
<cfset RemovedItems = ''> <!---setup a remove list for items that were removed from the catalog while this person was shopping and need to be removed from the cart--->
<cfloop index="MyCount" from="1" To="#ListLen(Form.ChangeQuantity)#">
	<cfset QToChange = #ListGetAt(form.ChangeQuantity, MyCount, ",")#>
    <!---Get the previous Quantity of this item--->
    <cfset OldQuantity = #ListGetAt(form.OldQuantity, MyCount, ",")#>

	<cfif isnumeric(qToChange)>
		<cfif NOT QToChange IS 0>
			<cfif NOT QTochange CONTAINS "-">

				<CFSET NewQuantity = #QToChange#>
    
                <cfset TheItemID = ListGetAt(cart.CrtItemID, MyCount, "^")>
    
                <!---query the products for this item--->
                <cfinclude template = "../queries/qryproducts.cfm">
                
                 <!---If the item was removed from the catalog while this person had it in their cart, then
                      mark it for deletion from the cart--->
                 <cfif qryproducts.recordcount IS 0>
                    <cfset RemovedItems = ListAppend(RemovedItems, TheItemID)>
                 </cfif>

				 <cfif NOT qryproducts.recordcount IS 0>
 					
					<!---Now check the inventory and make sure that they are not asking for more than what is available.
                    If they are, then set the quantity to the maximum amount in stock.--->
                     <cfif request.EnableInventory IS 'Yes'>
                        
						<cfoutput query = "qryproducts">
                          <cfset Maxproducts = #UnitsInStock#>
                            <cfif qryProducts.CanBackOrder IS 'No'>
                                <cfif NewQuantity GT Maxproducts>
                                    <cfset NewQuantity = Maxproducts>
                                </cfif>
                                <cfif NewQuantity LT 1><cfset NewQuantity = 1></cfif>
                            </cfif>
                        </cfoutput>

    
                        <!---Above takes care of if it's just an item....if they ordered options that have items attached to them, then we need to max the quantity to the lowest
                        unitsinstock of the options (added for keeping track of inventory of options)--->
            
                        <cfset OptionCheckID = ListGetAt(cart.crtOptionFields, MyCount, "^")>
                        
                        <!---for each option ordered associated with an itemid, reduce the quantity to the maximum in stock of each one
                        This results in having the maximum quantity set to the option that has the least number in stock.--->
                        <cfloop from="1" to="#listlen(OptionCheckID, '|')#" index="op_count">
                        	<cfif listlen(OptionCheckID, "|") GT 1>
								<cfset this_field = listgetat(OptionCheckID, 2, "|")>

                                    <cfset op_id = listgetat(this_field, 1, "-")>
                                    <cfset op_value = listgetat(this_field, 2, "-")> <!---note: value indications location of value in the lists for dropdowns and radiolists--->
                                    <cfset op_itemid = 0>
                            		

                                    <!---look up itemid for this option--->
                                        <cfquery name = "qOption" datasource="#request.dsn#">
                                        SELECT * FROM options WHERE optionid = #op_id#
                                        </cfquery>
                                        
                                        <cfif qOption.FieldType IS 'RadioList' OR qOption.FieldType IS 'DropDown'>
                                            <cfset op_itemid = listgetat(qOption.itemidslist, op_value, '^')>
                                        <cfelse>
                                            <cfset op_itemid = qOption.itemid>
                                        </cfif>
                            
                                        <cfif NOT op_itemid IS 0>

                                            <cfquery name = "qProduct" datasource="#request.dsn#">
                                            SELECT UnitsInStock,CanBackOrder FROM products
                                            WHERE itemid = #op_itemid#
                                            </cfquery>
                                            
                                            <cfoutput query = "qProduct">
                                              <cfset Maxproducts = #qProduct.UnitsInStock#>
                                                <cfif qProduct.CanBackOrder IS 'No'>
                                                    <cfif NewQuantity GT Maxproducts>
                                                        <cfset NewQuantity = Maxproducts>
                                                    </cfif>
                                                    <cfif NewQuantity LT 1><cfset NewQuantity = 1></cfif>
                                                </cfif>                            
                                            </cfoutput>
                                            
                                        </cfif>
                          		</cfif>
                          </cfloop> <!---end loop over options--->
				</cfif><!---end if inventory is enabled (line 55)--->

				<!---Get the actual price of each of this item from the database--->
                <cfoutput query = "Qryproducts">
                    <cfset PriceEach = #Price#>
                </cfoutput>
    
                <!---Set new quantity--->
                <cfoutput>
                    <CFSET SetQuantity = ListSetAt(cart.CrtQuantity, MyCount, #NewQuantity#, "^")>
                    <CFSET cart.CrtQuantity = #SetQuantity#>
                </cfoutput>
    
                <!---Recalculate the price--->
                <!---See if this item has a volume discount...if so then figure it in to the new price--->
                <cfset TotalOfItems = #PriceEach# * #NewQuantity#>
                <!---Create a variable based on the old quantity that determines what the price was of all the
                    options for each item in the cart.  This will be used to recalculate the total option pricing
                    for this item which will be added back in below--->
                <cfset TotalOfEachOption = #ListGetAt(Cart.Crtoptions, MyCount, "^")# / #OldQuantity#>
    
                <cfinclude template = "../queries/qrydiscounts.cfm">
                <cfset TheDiscountType = 'None'>
                <cfloop query="qrydiscounts">
                    <cfif #NewQuantity# GTE MinQ>
                      <cfset TheDiscountType = '#DiscountType#'>
                      <cfset TheDiscount = #AmountOff#>
                    </cfif>
                </cfloop>
                <cfif NOT TheDiscountType IS 'None'>
                    <cfif TheDiscountType IS 'Percent Off'>
                       <cfset TotalOfItems = #TotalOfItems# - (#TotalOfItems# * #TheDiscount#)>
                    </cfif>
                    <cfif TheDiscountType IS 'Amount Off'>
                       <cfset TotalOfItems = #TotalOfItems# - (#NewQuantity# * #TheDiscount#)>
                    </cfif>
                 </cfif>
    
                 <!---Calculate in the Option Pricing--->
                 <!---Figure up the new total options pricing based on the NEW quantity--->
                 <cfset TotalOfoptions = TotalOfEachOption * NewQuantity>
                 <cfset TotalOfItems = TotalOfItems + TotalOfoptions>
    
                <!---Write the new price to the temporary variable--->
                <cfoutput>
                    <CFSET SetPrice = ListSetAt(cart.CrtPrice, MyCount, #TotalOfItems#, "^")>
                    <CFSET cart.CrtPrice = #SetPrice#>
                </cfoutput>
    
                <!---Write the temporary variables back to the session variables--->
                <cflock scope="SESSION" type="EXCLUSIVE" timeout="10">
                    <cfoutput>
                        <cfset session.CrtQuantity = '#cart.CrtQuantity#'>
                        <cfset session.CrtPrice = '#Cart.CrtPrice#'>
                    </cfoutput>
                </cflock>
             </cfif> <!---End if for check if qryProductRecordCount IS 0 LINE 43--->
            </cfif>
        </cfif>
    </cfif>
</cfloop>

<!---Next Delete items from the cart that were checked--->
<!---Modified on Nov 26th, 2007 by Jon W. Updated it so that it now searches for the itemid and deletes it to avoid listindex errors--->
<cfset ItemDeleteList = ''>

<cfif ISDEFINED('form.DeleteList')>
	<cfset ItemDeleteList = #Form.deleteList#>

	<cfset itemsremoved = 0>
	<cfloop index="DelCount" From="1" To="#ListLen(ItemDeleteList)#">
	<!---Find Out which item(s) should be deleted--->

	<cfset ItemToDelete = ListGetAt(#ItemDeleteList#, DelCount)>
	
	<cfset ItemWasDeleted = "No">
    <cfloop index="itempos" from="1" To="#ListLen(Cart.CrtItemID, '^')#">
	
	<cfif ItemWasDeleted IS "No">
	<cfset thisitem = ListGetAt(Cart.CrtItemID, itempos, '^')>
	<!---Now Delete the item at the CartIndex Number--->
		<cfif thisitem IS ItemToDelete>
			<CFSET NewItemID = ListDeleteAt(#cart.CrtItemID#, itempos, "^")>
			<CFSET cart.CrtItemID = #NewItemID#>
			<CFSET NewProductName = ListDeleteAt(#cart.CrtProductName#, itempos, "^")>
			<CFSET cart.CrtProductName = #NewProductName#>
			<CFSET NewProductID = ListDeleteAt(#cart.CrtProductID#, itempos, "^")>
			<CFSET cart.CrtProductID = #NewProductID#>
			<CFSET NewQuantity = ListDeleteAt(#cart.CrtQuantity#, itempos, "^")>
			<CFSET cart.CrtQuantity = #NewQuantity#>
			<CFSET NewPrice = ListdeleteAt(#cart.CrtPrice#, itempos, "^")>
			<CFSET cart.CrtPrice = #NewPrice#>
			<CFSET NewWeight = ListDeleteAt(#Cart.CrtWeight#, itempos, "^")>
			<CFSET Cart.CrtWeight = #NewWeight#>
			<CFSET NewThumbNails = ListDeleteAt(#Cart.CrtThumbnails#, itempos, "^")>
			<CFSET Cart.CrtThumbNails = #NewThumbNails#>
			<CFSET Newoptions = ListDeleteAt(#Cart.Crtoptions#, itempos, "^")>
			<CFSET Cart.Crtoptions = #Newoptions#>
			<CFSET NewTypes = ListDeleteAt(#Cart.CrtType#, itempos, "^")>
			<CFSET Cart.CrtType = #NewTypes#>
			<CFSET NewApproved = ListDeleteAt(#Cart.CrtApproved#, itempos, "^")>
			<CFSET Cart.CrtApproved = #NewApproved#>            
			<CFSET NewOptionFields = ListDeleteAt(#Cart.CrtOptionFields#, itempos, "^")>
            <CFSET Cart.CrtOptionFields = NewOptionFields>
			<cfset ItemWasDeleted = 'Yes'>
			<cfset itemsremoved = itemsremoved + 1>
		</cfif>
	</cfif>
  </cfloop>
</cfloop>
</cfif>


<!---***COUPONS***--->
<!---Delete any coupons that have been checked for removal--->
<cfset CouponsDeleted = 0>
<cfif isdefined('form.removecouponlist')>
	<cfif NOT #listlen(form.removecouponlist)# IS 0>
		<cfloop from="1" to="#listlen(form.removecouponlist)#" index="ccount">
			<cfset CouponToDelete = ListGetAt(#form.removecouponlist#, ccount)>
			<cfset CouponToDelete = CouponToDelete - CouponsDeleted>

			<cfset itemtodelete = listgetat(form.removecouponlist, ccount)>
			<cfset newcouponlist = ListDeleteAt(cart.crtcoupons, coupontodelete, "^")>
			<cfset cart.crtcoupons = newcouponlist>
			<cfset CouponsDeleted = CouponsDeleted + 1>
		</cfloop>
	</cfif>
</cfif>

<!---check if a coupon code was entered.  If so, add it to the list of codes--->
<cfif NOT len(trim(couponcode)) IS 0>
	<cfinclude template = "crtAddCoupon.cfm">
</cfif>
<!---*** END OF COUPONS***--->

<!---Update the information into the shopping cart table--->
<cfquery name = "AddToCart" datasource = "#request.dsn#">
UPDATE shoppingcarts
set CrtItemID = <cfqueryparam value="#Cart.CrtItemID#" cfsqltype="cf_sql_varchar">,
CrtProductID = <cfqueryparam value="#Cart.CrtProductID#" cfsqltype="cf_sql_varchar">,
CrtProductName = <cfqueryparam value="#Cart.CrtProductName#" cfsqltype="cf_sql_varchar">,
CrtQuantity = <cfqueryparam value="#Cart.CrtQuantity#" cfsqltype="cf_sql_varchar">,
CrtPrice = <cfqueryparam value="#cart.CrtPrice#" cfsqltype="cf_sql_varchar">,
CrtWeight = <cfqueryparam value="#cart.CrtWeight#" cfsqltype="cf_sql_varchar">,
CrtThumbnails = <cfqueryparam value="#cart.CrtThumbNails#" cfsqltype="cf_sql_varchar">,
CrtOptions = <cfqueryparam value="#cart.CrtOptions#" cfsqltype="cf_sql_varchar">,
CrtType = <cfqueryparam value="#cart.CrtType#" cfsqltype="cf_sql_varchar">,
CrtApproved = <cfqueryparam value="#cart.CrtApproved#" cfsqltype="cf_sql_varchar">,
CrtCoupons = <cfqueryparam value="#cart.CrtCoupons#" cfsqltype="cf_sql_varchar">
WHERE CartToken = <cfqueryparam value="#CartToken#" cfsqltype="cf_sql_varchar">
</cfquery>

<!---Write the temporary variables back to the session variables--->
<cflock scope="SESSION" type="EXCLUSIVE" timeout="10">
	<cfoutput>
		<cfset session.CrtItemID = '#Cart.CrtItemID#'>
		<cfset session.CrtProductID = '#cart.CrtProductID#'>
		<cfset session.CrtProductName = '#cart.CrtProductName#'>
		<cfset session.CrtQuantity = '#cart.CrtQuantity#'>
		<cfset session.CrtPrice = '#cart.CrtPrice#'>
		<cfset session.CrtWeight = '#Cart.CrtWeight#'>
		<cfset session.CrtThumbnails = '#Cart.CrtThumbNails#'>
		<cfset session.CrtOptions = '#Cart.CrtOptions#'>
		<cfset session.CrtType = '#Cart.CrtType#'>
		<cfset session.CrtApproved = '#Cart.CrtApproved#'>
        <cfset session.CrtCoupons = '#Cart.CrtCoupons#'>
        <cfset session.CrtOptionFields = '#Cart.CrtOptionFields#'>
	</cfoutput>
</cflock>

</cfif> <!---End if to check for empty cart (LINE 20)--->

<cfif NOT itemtoadd IS 0>
	<cflocation url = "index.cfm?action=addtocart&itemid=#itemtoadd#&carttoken=#carttoken#">
<cfelse>
	<cflocation url = "index.cfm?action=view&CouponError=#CouponError#&CartToken=#CartToken#">
</cfif>