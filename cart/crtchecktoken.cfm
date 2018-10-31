<!---check the carttoken--->
<cfparam name = "carttoken" default="0">

<!---if there is a session then set the carttoken to whatever the session is--->
<cfif isdefined('cookie.carttoken')>
	<cfset carttoken = cookie.carttoken>
</cfif>

<!---If the carttoken session is not found and carttoken is not null then set the session to whatever carttoken is--->
<cfif NOT isdefined('cookie.carttoken')>
	<cfif NOT carttoken IS 'NULL'>
    	<cfset cookie.carttoken = carttoken>
	</cfif>
</cfif>

 <!---If any one of the session variables do not exist then check the db for the carttoken to restore the shopping cart.
NOTE: The db is only queried if the person is not able to create sessions. --->  
<cfif NOT isdefined('session.CrtItemID') OR NOT isdefined('session.CrtProductID') OR NOT isdefined('session.CrtProductName') OR NOT isdefined('session.CrtQuantity') OR NOT isdefined('session.CrtPrice')
OR NOT isdefined('session.CrtWeight') OR NOT isdefined('session.CrtThumbNails') OR NOT isdefined('session.CrtOptions') OR NOT isdefined('session.CrtOptionFields') OR NOT isdefined('session.CrtType')
OR NOT isdefined('session.CrtApproved') OR NOT isdefined('session.CrtCoupons')>
	<cfinclude template = "../queries/qryshoppingcarts.cfm">

	<cfif qryShoppingCarts.recordcount GT 0>
		<!---Assign the values stored in the db into the session variables if the carttoken value is valid--->
        <cfoutput query = "qryShoppingCarts">
            <cflock scope="SESSION" type="EXCLUSIVE" timeout="10">
                <cfset session.CrtItemID="#CrtItemID#">
                <cfset session.CrtProductID="#CrtProductID#">
                <cfset session.CrtProductName = "#CrtProductName#">
                <cfset session.CrtQuantity = "#CrtQuantity#">
                <cfset session.CrtPrice = "#CrtPrice#">
                <cfset session.CrtWeight = "#CrtWeight#">
                <cfset session.CrtThumbNails = "#CrtThumbNails#">
                <cfset session.Crtoptions = "#CrtOptions#">
                <cfset session.CrtOptionFields = "#CrtOptionFields#">
                <cfset session.CrtType = "#CrtType#">
                <cfset session.CrtApproved = "#CrtApproved#">
                <cfset session.CrtCoupons = "#CrtCoupons#">
                <cfset session.wishlist = "#wishlist#">
                <cfset session.affilid = "#affilID#">
                <cfset cookie.carttoken = "#carttoken#">
            </cflock>
        </cfoutput>	
    </cfif>

	<!--- no session exists and carttoken is invalid so set to null so a new token is created--->
	<cfif qryShoppingCarts.recordcount IS 0>
    	<cfset carttoken = '0'>
    </cfif>
</cfif>

<!---Update: 4/09/2010 - move create cart to add to cart process so that empty carts are no longer created when someone enters the site--->