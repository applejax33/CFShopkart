<!---This script changes the quantity.  Information passed from a form--->
<cfif isnumeric(form.ChangeQuantity)>
<CFSET NewQuantity = #form.ChangeQuantity#>

<cfif NewQuantity IS 0>
<cflocation url="index.cfm?action=view">
</cfif>

<cfif NewQuantity CONTAINS "-">
<cflocation url="index.cfm=viewcart">
</cfif>

<!---Create temporary variables to use instead of accessing the session variables over and over--->
<cflock scope="SESSION" type="EXCLUSIVE" timeout="10">
<cfoutput>
<cfset cart.CrtProductID = '#session.CrtProductID#'>
<cfset cart.CrtQuantity = '#session.CrtQuantity#'>
<cfset cart.CrtPrice = '#session.CrtPrice#'>
</cfoutput>
</cflock>

<cfoutput>
<cfset TheProductID = #ListGetAt(cart.CrtProductID, Form.CartIndex, "^")#>
</cfoutput>
<cfinclude template = "../queries/qryproducts.cfm">
<!---Now check the inventory and make sure that they are not asking for more than what is available.
If they are, then set the quantity to the maximum amount in stock.--->

<cfoutput query = "qryproducts">
<cfset Maxproducts = #UnitsInStock#>
<cfif NewQuantity GT Maxproducts>
<cfset NewQuantity = Maxproducts>
</cfif>
</cfoutput>

<cfoutput>
<cfset TheProductPrice = #ListGetAt(cart.CrtPrice, Form.CartIndex, "^")#>
<cfset CurrentProduct = #ListGetAt(cart.CrtProductID, Form.CartIndex, "^")#>

<!---Set new quantity--->
<CFSET SetQuantity = ListSetAt(cart.CrtQuantity, form.CartIndex, #NewQuantity#, "^")>
<CFSET cart.CrtQuantity = #SetQuantity#>

<!---Now write the temporary variables back to the session variables--->
<cflock scope="SESSION" type="EXCLUSIVE" timeout="10">
<cfoutput>
<cfset session.CrtQuantity = '#cart.CrtQuantity#'>
</cfoutput>
</cflock>

</cfoutput>
</cfif>
<cflocation url="index.cfm?Action=View">






