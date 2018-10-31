<cfset WasInThere = 'No'>

<cfif carttoken IS '0'>
    <cflock scope="SESSION" type="EXCLUSIVE" timeout="10">   
        <cfset session.CrtItemID="">
        <cfset session.CrtProductID="">
        <cfset session.CrtProductName = "">
        <cfset session.CrtQuantity = "">
        <cfset session.CrtPrice = "">
        <cfset session.CrtWeight = "">
        <cfset session.CrtThumbNails = "">
        <cfset session.Crtoptions = "">
        <cfset session.CrtType = "">
        <cfset session.CrtApproved = "">
        <cfset session.CrtCoupons = "">
        <cfset session.CrtOptionFields = "">
        <cfset session.affilid = "0">
    </cflock>

	<!---since the session is not found we need to create the session variable by generating a new carttoken--->
    <cfinclude template = "crtCreateToken.cfm">
        
</cfif>

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
<cfset Cart.CrtOptionFields = '#session.CrtOptionFields#'>
<cfset Cart.CrtType = '#session.CrtType#'>
<cfset Cart.CrtApproved = '#session.CrtApproved#'>
<cfset cart.CrtCoupons = '#session.CrtCoupons#'>
</cfoutput>
</cflock>

<cfparam name = "qty" default="1">
<cfparam name = "itemid" default="0">
<cfparam name = "couponcode" default="0">
<cfparam name = "itemtoadd" default="0">

<cfset GoRightToCheckout = 'No'>

<!---add an item to the cart--->

<cfif NOT itemid IS 0>
	<!---loop over each one found and add to cart (loop was put in to support multiple item order forms--->
	<cfloop from = "1" to = "#listlen(itemid)#" index="itemindex">
	
    <cfset sku_string = "">
	<cfset TheItemID = #listgetat(itemid, itemindex)#>
	<cfset TheQuantity = #listgetat(qty, itemindex)#> 
	
	<!---set for getting default thumbnail for item--->
	<cfset ThisItemID = #TheItemid#>
        
	<cfif NOT isnumeric(TheQuantity)>
        <cfset TheQuantity = 1>
    </cfif>   
    
	<cfif TheQuantity GT 0>
		<cfquery name = "qryProduct" datasource="#request.dsn#">
		SELECT * FROM products
		WHERE itemid = <cfqueryparam value="#TheItemID#" cfsqltype="cf_sql_integer">
		</cfquery>
		
		<cfif qryProduct.recordcount IS 0>
			One or more items you tried to add to your cart are no longer available.
			<cfabort>
		</cfif>
		
		<cfoutput query = "qryProduct">
			<cfset TheProductPrice = #price#>
			<cfset TheProductName = #ProductName#>
			<cfset TheProductWeight = #Weight#>
			<cfset TheProductID = #sku#>
            <cfset sku_string = #sku#>
			<cfset ItemType = 'normal'>
			<cfset GoRightToCheckout = #OneClickOrdering#>
			<cfif isgift IS 'Yes'>
				<cfset ItemType = 'giftcard'>
			</cfif>
		</cfoutput>

		<cfset ThisItemid = TheItemid>

		<!---get thumbnail of this item--->
		<cfinclude template = "../queries/qryproductimages.cfm">
        
		<cfif qry_ProductImages.recordcount IS 0>
        	<cfset TheThumbnail = "nopic.jpg">
		<cfelse>
            <cfloop query = "qry_ProductImages" startrow="1" endrow="1">
                <cfset TheThumbnail = "#qry_ProductImages.iFileName#">
            </cfloop>
		</cfif>
                	
    	<!---If this is a sub item then get the parent details--->
        <cfif len(trim(qryProduct.subof)) GT 0>

        	<!---fetch parent item--->
            <cfquery name = "qryParent" datasource="#request.dsn#">
            SELECT * FROM products
            WHERE itemid = <cfqueryparam value="#qryProduct.subof#" cfsqltype="cf_sql_integer">
            </cfquery>           

            <!----change some attributes if it's a sub item--->
            <cfoutput query = "qryParent">
                <cfset TheProductName = "#qryParent.ProductName#: #TheProductName#">
            </cfoutput>
            
            <cfset ThisItemid = qryProduct.subof>
			
            <cfif TheThumbnail IS 'nopic.jpg'>
				<!---Swap Thumbnail to parent if nothing found for subitem--->
                <cfinclude template = "../queries/qryproductimages.cfm">
                
                <cfif qry_ProductImages.recordcount IS 0>
                    <cfset TheThumbnail = "nopic.jpg">
				<cfelse>
                    <cfloop query = "qry_ProductImages" startrow="1" endrow="1">
                        <cfset TheThumbnail = "#qry_ProductImages.iFileName#">
                    </cfloop>
				</cfif>
			</cfif>

    	</cfif>

   
    	<!---build list of options to look for for this item--->
        <cfquery name = "qryOptions" datasource="#request.dsn#">
        SELECT * FROM products_options JOIN options ON options.optionid = products_options.optionid
        WHERE products_options.itemid = <cfqueryparam value="#TheItemid#" cfsqltype="cf_sql_varchar">
        Order by options.orderid ASC
        </cfquery>
        
        <cfset TheOptions = ''>
        <cfloop query = "qryOptions">
        	<cfset TheOptions = listappend(TheOptions, qryOptions.optionid)>
          </cfloop>
        
		<!---empty cart prior to adding if this is oneclick order item--->
		<cfif GoRightToCheckout IS 'Yes'>
			<cfset cart.CrtItemID = ''>
			<cfset cart.CrtProductID = ''>
			<cfset cart.CrtProductName = ''>
			<cfset cart.CrtQuantity = ''>
			<cfset cart.CrtPrice = ''>
			<cfset cart.CrtWeight = ''>
			<cfset cart.CrtThumbNails = ''>
			<cfset Cart.CrtOptions = ''>
            <cfset Cart.CrtOptionFields = ''>
			<cfset Cart.CrtType = ''>
			<cfset Cart.CrtApproved = ''>   
		</cfif>
		
		<cfset TotalOfItems = TheProductPrice>
		<cfset TotalOfOptions = 0>
		<cfset OriginalPrice = '#TotalOfItems#'>
		
		<!---See if there is a sale on this item--->
		<cfset SalePrice = OriginalPrice>
		<cfset TodaysDate = #Now()#>
		<cfset TodaysDate = dateformat(TodaysDate, "mm/dd/yyyy")>
		
		<!---If it's not a giftcard then apply the sale--->
		<cfif NOT itemtype IS 'giftcard'>
			<cfinclude template = "../queries/qrysales.cfm">
			<cfinclude template = "../queries/qrycategories.cfm">
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
			<cfif qrySales.CategoryID IS qryCategories.CategoryID AND qrySales.ProductID IS '0'>
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
			<cfif qrySales.ProductID IS TheItemID>
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
		</cfif>
		<!---END CHECK FOR A SALE--->
		
		<cfset TotalOfItems = SalePrice>
		
		<!---See if this item has a volume discount...if so then recalculate the price each--->             
		<cfinclude template = "../queries/qrydiscounts.cfm"> 
		<cfset TheDiscountType = 'None'> 
			<cfloop query="qryDiscounts">
				<cfif #TheQuantity# GTE MinQ>
				  <cfset TheDiscountType = '#DiscountType#'>
					<cfset TheDiscount = #AmountOff#>
				</cfif>
			</cfloop> 
			<cfif NOT TheDiscountType IS 'None'>
				<cfif TheDiscountType IS 'Percent Off'>
				   <cfset TotalOfItems = #TotalOfItems# - (#TotalOfItems# * #TheDiscount#)>
				</cfif>
				<cfif TheDiscountType IS 'Amount Off'>
				   <cfset TotalOfItems = #TotalOfItems# - #TheDiscount#>
				</cfif>
			 </cfif> 
		
        <cfset cart_optionstring = "#theItemID#">
		<cfset option_string = ""> <!---this is built from the various options form fields and appended to the product name--->
		<!---Check to see if the option fields are present for this item--->   
        <cfloop from="1" to="#listlen(TheOptions)#" index="ops">
			<cfset thisoption = listgetat(TheOptions, ops)>

            <cfquery name = "qryOptions" datasource="#request.dsn#">
            SELECT * FROM options
            WHERE OptionID = <cfqueryparam value="#thisoption#" cfsqltype="cf_sql_integer">
            </cfquery>
            
            <cfset op_id = qryOptions.OptionID>
            <cfset op_cartcaption = '#qryOptions.CartCaption#'>
            <cfset op_formname = 'form.ffield#qryOptions.OptionID#'>
            <cfset op_weight = 0>
            <cfset op_price = 0>
            <cfset op_itemid = 0>
            
            <!---if the form field is found then process--->
            <cfif isdefined('#op_formname#')>
    			               
                <cfset cart_optionstring = cart_optionstring & '|#op_id#'>
            
                <cfquery name = "qOption" datasource="#request.dsn#">
                SELECT * FROM options WHERE optionid = #op_id#
                </cfquery>
                
                <!---Get the value for this option that they chose---->
  				<cfset option_enteredvalues = evaluate(op_formname)>
                
					<cfif qOption.fieldtype IS 'DropDown' OR qOption.fieldtype IS 'RadioList'>
                        <cfset op_listlocation = evaluate(op_formname)>
                        <cfset op_displayvalue = listgetat(qOption.itemsList, op_listlocation, "^")>
                        <cfset op_value = evaluate(op_formname)>
                        <cfset op_itemid = listgetat(qOption.itemidslist, op_listlocation, "^")>
                        <cfset op_price = listgetat(qOption.pricelist, op_listlocation, "^")>
                        <cfset op_weight = listgetat(qOption.weightslist, op_listlocation, "^")>
                    </cfif>
                    
                    <!---if it's not a list or radio then it's just whatever the value of the field is--->
                    <cfif NOT qOption.fieldtype IS 'DropDown' AND NOT qOption.fieldtype IS 'RadioList'>
                        <cfset op_displayvalue = evaluate(op_formname)>
                        <cfset op_value = evaluate(op_formname)>
                        <cfset op_itemid = qOption.itemid>
                        <cfset op_price = qOption.optionprice>
                        <cfset op_weight = qOption.optionweight>
                    </cfif>
                    
                    <cfset this_sku = ''>
                    <!---lookup itemid and get sku--->
                    <cfquery name = "qItem" datasource="#request.dsn#">
                    SELECT sku FROM products WHERE itemid = #op_itemid#
                    </cfquery>
                    
                    <cfoutput query = "qItem">
                    	<cfset this_sku = '(#qItem.sku#)'>
                        <cfset sku_string = '#sku_string#-#qItem.sku#'>
                    </cfoutput>
                
                <!---this gets appended to the cart.crtOptions for this item (String format:  ^ItemID|OptionID-Option_Value^ItemID|OptionID-OptionValue...)--->
                <cfset cart_optionstring = cart_optionstring & '-#op_value#'>
                
                	<cfset option_string = '#option_string#<br><br>#op_cartcaption#</b>: #op_displayvalue# #this_sku#'>
                    <!---Add in the option pricing for this item--->
                    <cfset TotalOfItems = #TotalOfItems# + #op_price#>
                    <!---Keep track of the total of what the options cost--->
                    <cfset TotalOfOptions = #TotalofOptions# + #op_price#>
                    <!---Add weight to the product if applicable--->
                    <cfset TheProductWeight = #TheProductWeight# + #op_weight#>
            </cfif>
		
		</cfloop>

		<cfset TheProductName = '#TheProductName# (#sku_string#) #option_string#'>
		<!--- Now Look in the cart and see if there are any duplicate items.  If so, then
			 ignore the request to add to the cart--->
		   
		<cfif NOT #ListLen(cart.CrtProductName, "^")# IS 0>
		<cfloop index="LoopCount" FROM="1" TO="#ListLen(cart.CrtProductID, "^")#">
		<CFIF #ListGetAt(cart.CrtProductName, loopcount, "^")# IS #TheProductName#>
			<CFSET WasInThere = 'Yes'>
		</CFIF>
		</cfloop>
		</cfif>

		<cfif #WasInThere# IS 'Yes'>
		<CFLOCATION URL="index.cfm?Action=View&CartToken=#CartToken#">
		</cfif>
		
		<!---now calculate the total based on the quantity ordered--->
		<cfset TotalOfItems = TotalOfItems * TheQuantity>
		<cfset TheProductWeight = TheProductWeight * TheQuantity>
		
		<CFSET NewItemID = ListAppend(#cart.CrtItemID#, #theItemID#, "^")>
		<CFSET cart.CrtItemID = #NewItemID#>
		<CFSET NewProdID = ListAppend(#cart.CrtProductID#, #theProductID#, "^")>
		<CFSET cart.CrtProductID = #NewProdID#>
		<CFSET NewProductName = ListAppend(#cart.CrtProductName#, #TheProductName#, "^")>
		<CFSET cart.CrtProductName = #NewProductName#>
		<CFSET NewQuantity = ListAppend(#cart.CrtQuantity#, #theQuantity#, "^")>
		<CFSET cart.CrtQuantity = #NewQuantity#>
		<CFSET NewPrice = ListAppend(#cart.CrtPrice#, #TotalOfItems#, "^")>
		<CFSET cart.CrtPrice = #NewPrice#>
		<CFSET NewWeight = ListAppend(#cart.CrtWeight#, #TheProductWeight#, "^")>
		<CFSET cart.CrtWeight = #NewWeight#>
		<cfset NewThumbNail = ListAppend(#Cart.CrtThumbNails#, #theThumbNail#, "^")>
		<cfset Cart.CrtThumbnails = #NewThumbNail#>
		<!---Note:  CrtOptions keeps track of the total price the options add to the cart for this particular item.
			It is used when updating quantities.  Option pricing is figured in after any volume discounts--->
		<CFSET NewOptionPrices = ListAppend(#cart.CrtOptions#, #TotalOfOptions#, "^")>
		<CFSET cart.CrtOptions = #NewOptionPrices#>
		<CFSET NewType = ListAppend(#cart.CrtType#, #itemtype#, "^")>
		<CFSET cart.CrtType = #NewType#>
		<CFSET NewApproved = ListAppend(#cart.CrtApproved#, "No", "^")>
		<CFSET cart.CrtApproved = #NewApproved#>
		<CFSET NewOptionFields = ListAppend(#cart.CrtOptionFields#, #cart_optionstring#, "^")>
        <CFSET cart.CrtOptionFields = #NewOptionFields#>
        
		<!---Insert the information into the shopping cart table--->
		<cfquery name = "AddToCart" datasource = "#request.dsn#">
		UPDATE shoppingcarts
		SET CrtItemID = <cfqueryparam value="#Cart.CrtItemID#" cfsqltype="cf_sql_varchar">,
		CrtProductID = <cfqueryparam value="#Cart.CrtProductID#" cfsqltype="cf_sql_varchar">,
		CrtProductName = <cfqueryparam value="#Cart.CrtProductName#" cfsqltype="cf_sql_varchar">,
		CrtQuantity = <cfqueryparam value="#Cart.CrtQuantity#" cfsqltype="cf_sql_varchar">,
		CrtPrice = <cfqueryparam value="#cart.CrtPrice#" cfsqltype="cf_sql_varchar">,
		CrtWeight = <cfqueryparam value="#cart.CrtWeight#" cfsqltype="cf_sql_varchar">,
		CrtThumbnails = <cfqueryparam value="#cart.CrtThumbNails#" cfsqltype="cf_sql_varchar">,
		CrtOptions = <cfqueryparam value="#cart.CrtOptions#" cfsqltype="cf_sql_varchar">,
		CrtType = <cfqueryparam value="#cart.CrtType#" cfsqltype="cf_sql_varchar">,
		CrtApproved = <cfqueryparam value="#cart.CrtApproved#" cfsqltype="cf_sql_varchar">,
        CrtOptionFields = <cfqueryparam value="#cart.CrtOptionFields#" cfsqltype="cf_sql_varchar">
		WHERE CartToken = <cfqueryparam value="#CartToken#" cfsqltype="cf_sql_varchar">
		</cfquery>
		
		<!---Now write the temporary variables back to the session variables--->
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
	
		</cfif>
	</cfloop><!---end loop over form fields--->

	<cfif GoRightToCheckout IS 'Yes'>
        <CFLOCATION URL="#request.secureurl#index.cfm?action=checkout&CartToken=#CartToken#">
    <cfelse>
        <CFLOCATION URL="index.cfm?action=View&CartToken=#CartToken#">
    </cfif>

</cfif>

<!---adds a coupon--->
<cfif NOT couponcode IS 0>
    <cfinclude template = "crtAddCoupon.cfm">

    <cflock scope="SESSION" type="EXCLUSIVE" timeout="10">
    <cfoutput>
    <cfset session.CrtCoupons = '#Cart.CrtCoupons#'>
    </cfoutput>
    </cflock>

	<cfif NOT itemtoadd IS 0>
        <cflocation url = "index.cfm?action=addtocart&itemid=#itemtoadd#&carttoken=#carttoken#">
    <cfelse>
        <cflocation url = "index.cfm?action=view&CouponError=#CouponError#&CartToken=#CartToken#">
    </cfif>

</cfif>