<!--Displays the featured items in a vertical table--->
<cfinclude template = "../queries/qryBestSellers.cfm">
<cfinclude template = "../queries/qrysales.cfm">

<cfif NOT qryBestSellers.recordcount IS 0>
<cfset BSellerCount = 0>
  <table width = 100% border="0" cellpadding="3" cellspacing="0" class="BestSellersTable">
    <tr> 
     <td class="TableTitles" colspan="4"> 
	 <div align="center" class="BestSellersTitle">Best Sellers</div></td>
     </tr>
         <tr> 
       <cfoutput query = "qryBestSellers" maxrows="8"> 
	   	 <cfset BSellerCount = BSellerCount + 1>
          <td width="25%" valign="top" class="bodytxt"> 
            <p align="center"><a href="index.cfm?carttoken=#carttoken#&action=ViewDetails&itemid=#itemid#">
                       
            <cfinclude template = "../queries/qryBestSellersProductimages.cfm">
            
            <cfset TheThumbnail = "#request.homeURL#photos/nopic.jpg">
            
            <cfloop query = "qry_ProductImages" startrow="1" endrow="1">
                <cfset TheThumbnail = "#request.homeURL#photos/tiny/#qry_ProductImages.iFileName#">
            </cfloop>
            <img src="#TheThumbnail#" alt="#ProductName#" title="#ProductName#" name="BestSeller" border="0" class="BestSellerImage">            
            <br>#ProductName#</a>
              </b></td>
			  <cfif BSellerCount IS #request.SideBySideCols#>
			  </tr><tr>
			  <cfset BSellerCount = 0>
			  </cfif>
      </cfoutput> 
          </tr>
   </table>
</cfif>



