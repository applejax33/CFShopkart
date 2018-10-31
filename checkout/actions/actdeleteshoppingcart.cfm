<!---Removes the shopping cart from the database upon completion of order--->
<cfquery name = "DeleteShoppingCart" datasource="#request.dsn#">
	DELETE FROM shoppingcarts WHERE OrderNumber = '#OrderNumber#'
</cfquery>

<cflock scope="session" timeout="10" type="exclusive">
<cfset session.CrtItemID = ''>
<cfset session.CrtProductID = ''>
<cfset session.CrtProductName = ''>
<cfset session.CrtQuantity = ''>
<cfset session.CrtPrice = ''>
<cfset session.CrtWeight = ''>
<cfset session.CrtThumbnails = ''>
<cfset session.CrtOptions = ''>
<cfset session.CrtType = ''>
<cfset session.CrtApproved = ''>
<cfset session.CartToken= ''>
</cflock>

<cfquery name = "qryUpdateOrder" datasource="#request.dsn#">
UPDATE orders SET processed = 'yes'
WHERE ordernumber = '#ordernumber#'
</cfquery>








