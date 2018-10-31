<!---Insert the order into the database--->
<cfparam name="form.card_type" default="">
<cfparam name="form.card_number" default="">
<CFPARAM name="card_expiredate" default="">
<cfparam name="form.card_cvs" default="">
<cfparam name="form.po_number" default="">

<cfif ISDEFINED('form.ExpMonth')>
	<cfset card_expiredate = '#form.ExpMonth#/#form.ExpYear#'>
</cfif>

<cfinclude template = "../queries/qrycompanyinfo.cfm">
<cfinclude template="../queries/qrycustomeremail.cfm">

<cfset TheMemo = #form.Memo#>

<cfif isdefined('form.ShipFromState')>
	<cfset TheMemo = TheMemo & ' - Ship Items from #form.ShipFromState#, #form.ShipFromCountry#'>
</cfif>

<cfoutput query = "qryCompanyInfo">
<cfset TheCompanyName = '#CompanyName#'>
<cfset TheCompanyEmail = '#EmailAddress#'>
<cfset TheCustomerEmail = '#Form.Emailaddress#'>
<cfset TheMailServer = '#MailServer#'>
</cfoutput>

<!---Set the total shipping costs to a variable so it can be changed if needed--->
<cfset request.ShippingCharges = '#Cart.TotalShippingCosts#'>
<cfset request.ShippingMethod = 'N/A'>

<cfif ISDEFINED('form.ShippingMethod')>
<cfset request.ShippingMethod = '#form.ShippingMethod#'>
</cfif>

<!---Create a date variable to determine when the order was placed--->
<cfset TheCurrentDate = #Now()#>

<cfset FraudFlag = 'Green'>
<cfset FraudReason = ''>

<!---Create a value for the shippedto field--->
<cfset TempVar.ShippedTo = '#form.ship_firstname# #form.ship_lastname#<br> #form.ship_company# <br>
#form.ship_address# <br> #form.ship_city#, #form.ship_state#  #form.ship_zip#<br>#form.ship_country#'>
<!---Now Dump the shopping cart contents into the database along with other info about this order--->

<cflock scope="Session" type="EXCLUSIVE" timeout="10">
<cfoutput>
<cfset cart.CrtProductID = '#session.CrtProductID#'>
<cfset cart.CrtProductName = '#session.CrtProductName#'>
<cfset cart.CrtQuantity = '#session.CrtQuantity#'>
<cfset cart.CrtPrice = '#session.CrtPrice#'>
<cfset cart.CrtWeight = '#session.CrtWeight#'>
<cfset Cart.CrtThumbNails = '#session.CrtThumbNails#'>
<cfset Cart.CrtItemID = '#session.CrtItemID#'>
<cfset Cart.CrtType = '#session.CrtType#'>
<cfset Cart.CrtApproved = '#session.CrtApproved#'>
<cfset Cart.CrtOptionFields = '#session.CrtOptionFields#'>
</cfoutput>
</cflock>

<!----check to make sure a duplicate order isn't being inserted--->
<cfquery name = "CheckDuplicateOrders" datasource="#Request.dsn#">
SELECT * FROM orders
WHERE OrderNumber = '#form.ordernumber#'
</cfquery>

<!---If there is a duplicate, delete it before inserting the order--->
<cfif NOT CheckDuplicateOrders.recordcount IS 0>
	<CFQUERY Name = "RemoveDuplicate" Datasource = "#request.dsn#">
	DELETE FROM orders
	WHERE OrderNumber = '#form.ordernumber#'
	</CFQUERY>

	<CFQUERY Name = "RemoveDuplicate" Datasource = "#request.dsn#">
	DELETE FROM orders_items
	WHERE OrderNumber = '#form.ordernumber#'
	</CFQUERY>
    
</cfif>

<cfset DefaultDownloads = '0'>
<cfloop from="1" to='#ListLen(Cart.CrtApproved, "^")#' index="mycount">
	<cfset defaultdownloads = '#DefaultDownloads#^0'>
</cfloop>

<!---Set all the items for CrtShipped to Pending--->
<cfset cart.shipped = "">
<cfset cart.tracking = "">
<cfset cart.package = "">
<cfloop from = "1" to = "#listlen(Cart.CrtItemID, '^')#" index="mycount">
 <cfset cart.shipped = listappend(Cart.Shipped, "Pending", "^")>
 <cfset cart.tracking = listappend(Cart.tracking, "0", "^")>
 <cfset cart.package = listappend(Cart.package, "1", "^")>
</cfloop>

<!---Insert the order--->
<CFQUERY Name = "AddOrderedItemsToDatabase" Datasource = "#request.dsn#">
INSERT INTO orders
(OrderNumber, CustomerID, CrtItemID, CrtProductID, CrtProductName, CrtPrice, CrtQuantity, 
QuotedShipping, FiguredTax, OrderStatus, DateOfOrder, PaymentMethod, OrderCompleted, ShippingMethod, 
DiscountAmount, OrderTotal, ShippedTo, memo, TrackingNumber, CrtType, CrtApproved, FraudFlag, 
FraudReason, VisitorIP, downloads, paid, crtShipped, crtTrackingNumbers, crtPackageNumber, ShipName, shipfirstname, shiplastname, shipbusinessname, shipaddress, ShipAddress2,
shipcity, shipstate, shipzip, shipcountry, giftcode, giftamountused, po_number, crtCoupons)
VALUES
('#form.ordernumber#', '#CustomerID#', '#Cart.CrtItemID#', '#Cart.CrtProductID#', '#Cart.CrtProductName#',
'#Cart.CrtPrice#', '#Cart.CrtQuantity#', #request.ShippingCharges#, #Cart.FiguredTax#, 'Received',
#createodbcdatetime(thecurrentdate)#, '#form.payment_method#', 'No', '#request.ShippingMethod#', '#CouponsTotal#',
#GrandTotal#, '#TempVar.ShippedTo#', '#TheMemo#', '0', '#Cart.CrtType#', '#Cart.CrtApproved#', 
'#FraudFlag#', '#FraudReason#', '#ipaddress#', '#DefaultDownloads#', 'no', '#cart.shipped#', '#cart.tracking#', '#cart.package#', '#form.ship_firstname# #form.ship_lastname#', '#form.ship_firstname#', '#form.ship_lastname#', 
'#form.ship_company#', '#form.ship_address#', '#form.ship_address2#', '#form.ship_city#', '#form.ship_state#', '#form.ship_zip#', 
'#form.ship_country#', '#GiftCode#', '#GiftCardTotal#', '#form.po_number#', '#cart.crtCoupons#')
</CFQUERY>

<!---insert ordered items--->
<cfloop index="IndexCount" from="1" To="#ListLen(Cart.CrtProductID, "^")#">
<cfquery name = "insertitems" datasource="#request.dsn#">
INSERT INTO orders_items
(ordernumber, itemname, itemid, itemsku, quantity, item_price, item_type, item_status, item_package, item_tracking, item_notes)
VALUES
('#form.ordernumber#', '#ListGetAt(Cart.CrtProductName, indexcount, "^")#', '#ListGetAt(Cart.CrtItemID, indexcount, "^")#', '#ListGetAt(Cart.CrtProductID, indexcount, "^")#', '#ListGetAt(Cart.CrtQuantity, indexcount, "^")#', '#ListGetAt(Cart.CrtPrice, indexcount, "^")#', '#ListGetAt(Cart.CrtType, indexcount, "^")#', 'Pending', '0', '0', '')
</cfquery>
</cfloop>

<!---insert ordered options: now stored for future use and easier customization--->
<cfloop list="#Cart.CrtOptionFields#" delimiters="^" index="this_itemsoptions">
	<!---the item id is always as the beginning of each string in the "|" delimited set--->
	<cfset op_itemid = listgetat(this_itemsoptions, 1, "|")>
	<cfloop list="#this_itemsoptions#" delimiters="|" index="this_option">
	<!---this if statement ensures that we skip the first item in the list since it will always be the product item number, and we don't want to insert that, just the options--->
    	<cfif listlen(this_option, "-") GT 1>
        	<cfset op_id = listgetat(this_option, 1, "-")>
            <cfset op_val = listgetat(this_option, 2, "-")>
    
            <cfquery name = "qInsertOption" datasource="#request.dsn#">
            INSERT INTO orders_options
            (OrderNumber, OptionID, OptionValue, ItemID)
            VALUES
            ('#form.ordernumber#', '#op_id#', '#op_val#', '#op_itemid#')
            </cfquery>
		</cfif>    
    </cfloop>
</cfloop>

<!---Insert affiliate commission if applicable--->
<cfinclude template="actinsertaffiliatecomm.cfm">

<!---Insert any info about subscriptions if this person is purchasing one or more subscription items--->
<cfinclude template = "actinsertsubscriptions.cfm">

<!---Update items in stock if they weren't update previously--->
<cfif CheckDuplicateOrders.recordcount IS 0>
	<cfinclude template = "actadjustinventory.cfm">

	<!---update item stats; units sold--->
    <cfloop index="IndexCount" from="1" To="#ListLen(Cart.CrtProductID, "^")#">
        <cfset ProdID = #ListGetAt(Cart.CrtItemID, IndexCount, "^")#>
        <cfset ProdName = #ListGetAt(Cart.CrtProductName, IndexCount, "^")#>
        <cfset ProdQty = #ListGetAt(Cart.CrtQuantity, IndexCount, "^")#>
    
        <cfquery name = "FindProduct" datasource="#request.dsn#">
        SELECT *
        FROM products
        WHERE ItemID = #ProdID#
        </cfquery>
    
        <cfoutput query = "FindProduct">
            <cfset NewUnitsSold = #UnitsSold# + #ProdQty#>
        </cfoutput>
    
        <cfif NOT #FindProduct.RecordCount# IS 0>
            <cfif isdefined('NewUnitsInStock')>
                <cfquery name = "UpdateStock" datasource="#request.dsn#">
                UPDATE products
                SET UnitsSold = '#NewUnitsSold#'
                WHERE ItemID = #ProdID#
                </cfquery>
            </cfif>
        </cfif>
    </cfloop>

</cfif><!---end if duplicate order (protects against refreshing browser)--->

<!---If this person wanted to be added to the mailing list, then add their email address to it--->
<cfinclude template = "actaddtoemaillist.cfm">

<!---Update the shopping cart with the order number so it can be deleted from the db when they finalize it--->
<cfquery name = "qryUpdateShoppingCartOrderNumber" datasource = "#request.dsn#">
UPDATE shoppingcarts SET OrderNumber = '#form.OrderNumber#'
WHERE CartToken = '#CartToken#'
</cfquery>