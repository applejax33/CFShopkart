<!---Displays a list of related items if there are any below the description of the product--->
<cfset relatedcount = 0>
<cfif listlen(qryProducts.SimilarItems, "^") GT 0>
<table width = "100%" border="0" cellpadding="3" cellspacing="0" class="relateditems_table">

	 <tr> 
	<cfloop from = "1" to = "#listlen(qryProducts.SimilarItems, '^')#" index="r">
	<cfset relatedid = listgetat(qryProducts.SimilarItems, r, "^")>
	
    <cfinclude template = "../queries/qryrelateditem.cfm">    
	<cfset showitem = 'Yes'>
	
	<!---Do not show if the item is out of stock and inventory is enabled--->
	<cfif request.EnableInventory IS 'Yes' AND qryRelatedItem.UnitsInStock LT 1>
		<cfset showitem = 'No'>
	</cfif>	

	<cfif showitem is 'Yes'>
		<cfset cellheight = '50'>

		<cfoutput query = "qryRelatedImage">
			<cfset cellheight = #thumbheight#>
		</cfoutput>

		<!---determine the tallest cell height for the image so it looks uniform--->		
		<cfif NOT isdefined('lastcellheight')>
			<cfset lastcellheight = cellheight>
		</cfif>
		
		<cfif isdefined('lastcellheight')>
			<cfif cellheight GT lastcellheight OR cellheight IS lastcellheight>
				<cfset lastcellheight = cellheight>
			<cfelse>
				<cfset cellheight = lastcellheight>
			</cfif>
		</cfif>
		
		<cfoutput query = "qryRelatedItem"> 
		 <cfset relatedcount = relatedcount + 1>
		  <td width="25%" valign="top" class="relateditems_cell">
		  <table width="100%" cellspacing="0" cellpadding="2">
		  <tr>
		  <td height="#cellheight#">
			<center><a href="index.cfm?action=ViewDetails&itemid=#itemid#"><img src="#request.homeurl#photos/small/#qryRelatedImage.iFileName#" alt="#ProductName#" name="FeaturedItem" border="0"></a></center>			</td>
			<tr>
			<td>
			<center>
			<a href="index.cfm?action=ViewDetails&itemid=#itemid#">#ProductName#</a><br>
			</center>			</td>
			</tr>
			</table>			  </td>
			  <cfif relatedcount IS 3>
			  </tr><tr>
			  <cfset relatedcount = 0>
			  </cfif>
		  </cfoutput> 
	</cfif>
</cfloop>
	  </tr>
</table>
</cfif>



