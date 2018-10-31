<!---Show the volume discount table if any exist for this product--->
<cfif NOT qryProducts.showvoldiscounts IS 'No'>

<table width="95%" border = "1" align="left" cellpadding="4" cellspacing="0" bordercolor="#000000">
<tr> 
  <td colspan="2" class="TableTitles"><strong>Quantity Pricing</strong></td>
</tr>
<tr> 
  <td width = "50%" class="volumediscounts_quantity"><strong>Quantity</strong></td>
  <td class="volumediscounts_priceeach"><strong>Price Each</strong></td>
</tr>
<tr>
<td height="32" class="volumediscount_quantities"><cfloop query="qrydiscounts" startrow="1" endrow="1"><cfoutput><cfset LastQ = #MinQ# - 1>#LastQ#</cfoutput></cfloop> <cfif LastQ GT 1>or less</cfif></td>
<td class="volumediscount_prices"><cfoutput><cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyformat(SalePrice, "Local")# 
<cfelse>#LSCurrencyformat(SalePrice, "Local")#</cfif></cfoutput></td>
</tr>
<cfset CurrentRow = 0>
<cfoutput query = "qrydiscounts"> 
<cfset CurrentRow = CurrentRow + 1>
<cfset NextRow = CurrentRow + 1>
  <tr> 
	<td height="32" class="volumediscount_quantities">#MinQ# <cfloop query="qrydiscounts" StartRow="#NextRow#" EndRow="#NextRow#"><cfset LastQ = #MinQ# - 1> to #LastQ#</cfloop>
	<cfif CurrentRow IS qrydiscounts.RecordCount + 1> or more </cfif></font></td>
	<cfif DiscountType IS 'Amount Off'>
	  <cfset DiscountPrice = #SalePrice# - #AmountOff#>
	</cfif>
	<cfif DiscountType IS 'Percent Off'>
	  <cfset DiscountPrice = #SalePrice# - (#SalePrice# * #AmountOff#)>
	</cfif>
	<td class="volumediscount_prices">
		<cfif request.EnableEuro IS 'Yes'>
		  #LSEuroCurrencyformat(DiscountPrice, "Local")# 
		  <cfelse>
		  #LSCurrencyformat(DiscountPrice, "Local")# 
</cfif>
		</td>
	<cfset TotalPrice = #DiscountPrice# * #MinQ#>
  </tr>
</cfoutput> </table>
</cfif>    




