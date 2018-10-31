<!--Displays the featured items in a vertical table--->
<cfinclude template = "../queries/qryProductsByBrand.cfm">
<cfinclude template="../queries/qrybrands.cfm">

<cfparam name = "brandselected" default="">
<CFPARAM name="start" default="1">
<CFPARAM name="disp" default="24">

<CFSET end=start + disp>
<CFIF end GREATER THAN qryProductsByBrand.RecordCount>
  <CFSET end=999>
<CFELSE>
  <CFSET end=end-1>
</CFIF>

<cfif NOT qryProductsByBrand.recordcount IS 0>
<cfset BrandCount = 0>
  <table width = "100%" border="0" cellpadding="3" cellspacing="0">
    <tr> 
     <td class="TableTitles" colspan="4"><div class="brandnametitle">Browse By Brand</div></td>
     </tr>
  <tr>
  	<td>   
    <form name = "brandbrowser" <cfoutput>action="index.cfm?action=browsebybrand&carttoken=#carttoken#"</cfoutput> method="post" class="browse_brands_form">
    <center>
    <select name="brandselected" class="browse_brands_dropdown" OnChange="this.form.submit();">
        <option value = "None">Select Brand</option>
		<cfoutput query = "qryBrands">
            <cfif NOT len(trim(brand)) IS 0><option value="#brand#" <cfif brand IS brandselected>SELECTED</cfif>>#brand#</option></cfif>
        </cfoutput>
    </select>
    </center>
    </form>    
    </td>
  	<td colspan="2" align="right" width="10%">
    <div align="right">
          <!---Display the page numbers--->
			<cfif isdefined('form.disp')>
				<cfset disp = #form.disp#>
			</cfif>

          <cfif disp LT qryProductsByBrand.recordcount + 1>
            <form name = "PageSelect" method="Post" <cfoutput>action="index.cfm?action=browsebybrand&brandselected=#brandselected#&carttoken=#carttoken#"</cfoutput>>
              <select name="start" OnChange="this.form.submit();">
                <cfset PageCount = 1>
								<!---Get total number of pages--->
								<cfset TotalPages = 0>
								<cfloop Index="Pages" FROM="1" TO="#qryProductsByBrand.recordcount#" Step="#disp#">
									<cfset TotalPages = TotalPages + 1>
								</cfloop>
								<!---build page selection--->
                <cfloop Index="Pages" FROM="1" TO="#qryProductsByBrand.recordcount#" Step="#disp#">
				<cfoutput><option value = "#Pages#" <cfif Pages IS Start>SELECTED</cfif>>Page 
                  #PageCount# of #totalpages#</option></a></cfoutput>
                  <cfset PageCount = PageCount + 1>
                </cfloop>
              </select>
			 <cfoutput>
			<input type="hidden" value="#disp#" name="disp">
			 </cfoutput>
            </form>
          </cfif>
        </div>		    	
    </td>
    <td align="left" width="10%">
    <form name="Displayoptions" method="POST" <cfoutput>action="index.cfm?action=browsebybrand&brandselected=#brandselected#&carttoken=#carttoken#"</cfoutput>>
      <select name = "disp" onchange="this.form.submit();">
			<option value="8" <cfif disp IS '8'>SELECTED</cfif>>Display 8 per page</option>
			<option value="16" <cfif disp IS '16'>SELECTED</cfif>>Display 16 per page</option>
			<option value="24" <cfif disp IS '24'>SELECTED</cfif>>Display 24 per page</option>
			<option value="48" <cfif disp IS '48'>SELECTED</cfif>>Display 48 per page</option>
			<option value="60" <cfif disp IS '60'>SELECTED</cfif>>Display 60 per page</option>
		</select>
	</form>
    </td>
  </tr>
         <tr> 
       <cfoutput query = "qryProductsByBrand" startrow="#start#" maxrows="#end#"> 
	   	 <cfset BrandCount = BrandCount + 1>
          <td width="25%" valign="middle" class="bodytxt" height="100"> 
            <p align="center"><a href="index.cfm?carttoken=#carttoken#&action=ViewDetails&itemid=#itemid#">
                <cfinclude template = "../queries/qryBrandProductimages.cfm">                
                <cfset TheThumbnail = "#request.homeURL#photos/small/nopic.jpg">
                <cfloop query = "qry_ProductImages" startrow="1" endrow="1">
				<cfset TheThumbnail = "#request.homeURL#photos/small/#qry_ProductImages.iFileName#"></cfloop>
                <img src="#TheThumbnail#" alt="#ProductName#" name="FeaturedItem" border="0">               
            <br>#ProductName#</a><br>
              </td>
			  <cfif BrandCount IS 4>
			  </tr><tr>
			  <cfset BrandCount = 0>
			  </cfif>
      </cfoutput> 
          </tr>
   </table>
   <cfelse>
   <p>
   <b>Sorry no products matched your search.</b>
</cfif>



