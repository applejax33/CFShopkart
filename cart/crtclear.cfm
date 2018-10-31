<!---Clears the Cart --->

<cfquery name = "qryClearCart" datasource="#request.dsn#">
DELETE FROM shoppingcarts WHERE CartToken = <cfqueryparam value="#CartToken#" cfsqltype="cf_sql_varchar">
</cfquery>

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
    <cfset session.affilid = "0">
</cflock>

<cfset tempvariable = StructClear(session)>
<cflocation url = "index.cfm?action=view">




