<!--Displays the featured items in a vertical table--->
<cfinclude template = "../queries/qryFeatures.cfm">

<cfif NOT qryfeatures.recordcount IS 0>
<cfset FeaturedCount = 0>
  <table width = 100% border="0" cellpadding="3" cellspacing="0">
    <tr> 
     <td class="TableTitles" colspan="4"><div class="FeaturedTitle">Featured Items</div></td>
     </tr>
         <tr> 
       <cfoutput query = "qryFeatures"> 
	   	 <cfset FeaturedCount = FeaturedCount + 1>
          <td width="25%" valign="middle" class="bodytxt" height="100"> 
            <p align="center"><a href="index.cfm?carttoken=#carttoken#&action=ViewDetails&itemid=#itemid#">
                <cfinclude template = "../queries/qryFeaturedProductimages.cfm">                
                <cfset TheThumbnail = "#request.homeURL#photos/nopic.jpg">
                <cfloop query = "qry_ProductImages" startrow="1" endrow="1"><cfset TheThumbnail = "#request.homeURL#photos/tiny/#qry_ProductImages.iFileName#"></cfloop>
                <img src="#TheThumbnail#" alt="#ProductName#" name="FeaturedItem" border="0">               
            <br>#ProductName#</a><br>
              </td>
			  <cfif FeaturedCount IS #request.SideBySideCols#>
			  </tr><tr>
			  <cfset FeaturedCount = 0>
			  </cfif>
      </cfoutput> 
          </tr>
   </table>
</cfif>



