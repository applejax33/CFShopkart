<!---displays the subitems in a table if there are any--->
<cfif qrySubs.recordcount GT 0>
<table width="100%" cellpadding="4" cellspacing="0">
<tr>
	<td width="15%" bgcolor="#CCCCCC"><strong>SKU</strong></td>
	<td bgcolor="#CCCCCC"><strong>Options</strong></td>
	<td width="10%" align="center" bgcolor="#CCCCCC"><strong>Price</strong></td>
	<td width="10%" align="center" bgcolor="#CCCCCC"><strong>Qty</strong></td>
	</tr>
<cfloop query = "qrySubs">
<cfset OriginalPrice = qrySubs.Price>
<cfinclude template = "../cart/crtcheckforsale.cfm">
<cfoutput>
<tr>
	<td width="15%">#SKU#</td>
	<td>#ProductName# <cfset itemid = qrySubs.itemid><cfinclude template = "details_optionssubitems.cfm"></td>
	<td width="10%" align="center">
	<cfif request.EnableEuro IS 'Yes'>
	  #LSEuroCurrencyformat(Price, "Local")#
	  <cfelse>
	  #LSCurrencyformat(Price, "Local")#
	  </cfif></td>
	<td width="10%" align="center">
	  <input type="text" name="qty" size="3" value="0" onfocus="this.value='';" onblur="if(this.value == '') {this.value ='0';};"></td>
  	  <input type = "Hidden" name="ItemID" Value="#ItemID#">
</tr>	
</cfoutput>
</cfloop>
</table>
</cfif>





