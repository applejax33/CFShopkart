<cfif url.action IS "Delete">

<!---Create temporary variables to use instead of accessing the session variables over and over--->
<cflock scope="SESSION" type="READONLY" timeout="10">
<cfoutput>
<cfset cart.CrtProductID = '#session.CrtProductID#'>
<cfset cart.CrtProductName = '#session.CrtProductName#'>
<cfset cart.CrtQuantity = '#session.CrtQuantity#'>
<cfset cart.CrtPrice = '#session.CrtPrice#'>
</cfoutput>
</cflock>

<cfoutput>
<CFSET NewProductName = ListDeleteAt(#cart.CrtProductName#, #url.CartIndex#, "^")>
<CFSET cart.CrtProductName = #NewProductName#>
<CFSET NewProductID = ListDeleteAt(#cart.CrtProductID#, #url.CartIndex#, "^")>
<CFSET cart.CrtProductID = #NewProductID#>
<CFSET NewQuantity = ListDeleteAt(#cart.CrtQuantity#, #url.CartIndex#, "^")>
<CFSET cart.CrtQuantity = #NewQuantity#>
<CFSET NewPrice = ListdeleteAt(#cart.CrtPrice#, #url.CartIndex#, "^")>
<CFSET cart.CrtPrice = #NewPrice#>
</cfoutput>

<!---Now write the temporary variables back to the session variables--->
<cflock scope="SESSION" type="EXCLUSIVE" timeout="10">
<cfoutput>
<cfset session.CrtProductID = '#cart.CrtProductID#'>
<cfset session.CrtProductName = '#cart.CrtProductName#'>
<cfset session.CrtQuantity = '#cart.CrtQuantity#'>
<cfset session.CrtPrice = '#cart.CrtPrice#'>
</cfoutput>
</cflock>

<cflocation url="#URLSessionFormat("index.cfm?Action=View")#">
</cfif>



