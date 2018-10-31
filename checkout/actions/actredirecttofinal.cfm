<!---this page acts as a redirect only to the final screen where their order summary is shown along with thank you.
This was put in because I found that a few customers were hitting the back button to change something on their order
AFTER they already paid; then complaing that they were double-billed.--->
<cfparam name = "ordernumber" default="0">
<cfparam name = "customerid" default="0">

<!---clear the ordernumber cookie and shopping cart so they cannot reorder--->
<cfcookie name="customerordernumber" value="" expires="now">

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
    <cfset session.wishlist = "">
    <cfset session.affilid = "">
    <cfset cookie.carttoken = "">
</cflock>
<br>
Please wait, we are generating your order summary....
<br>

<cflocation url = "index.cfm?action=finalize&ordernumber=#ordernumber#&customerid=#customerid#&carttoken=#carttoken#">