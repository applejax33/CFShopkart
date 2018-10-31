<!---displays the product image(s)--->
<cfif NOT qryProducts.showimage IS 'No'>
    <cfinclude template = "Productimages.cfm">
    <cfoutput>#imagetable#</cfoutput>
</cfif>




