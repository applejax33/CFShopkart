</td></tr>
<tr>
<td>
<cfif qryCatalog.recordcount IS 0 and qrySubCategories.recordcount IS 0><center><b>No products available in this Category</b></center></cfif>
<cfif qryCatalog.recordcount gt 0>
<!---Display the pagination: uncomment this if you want to show pagination at the bottom of the page--->
<!---<table width = "100%" cellpadding="4" cellspacing="0">
	<tr>
		<td width="70%">
		<form name = "SortForm" <cfoutput>action="index.cfm?action=viewcategory&category=#category#&disp=#disp#&start=#start#"</cfoutput> method="post">
		 Sorty by <select name="viewby" OnChange="this.form.submit();">
		  <option value = 'productname' <cfif viewby IS 'productname'>SELECTED</cfif>>By Item Name</option>
		  <option value = 'price' <cfif viewby IS 'price'>SELECTED</cfif>>By Price</option>	  		  
		 </select>
		 <select name="sortorder" OnChange="this.form.submit();">
		  <option value = 'ASC' <cfif sortorder IS 'ASC'>SELECTED</cfif>>Low to High</option>
		  <option value = 'DESC' <cfif sortorder IS 'DESC'>SELECTED</cfif>>High to Low</option>	  		  
		 </select>
		</form>		</td>
		<td width="15%">
          <!---Display the page numbers--->
			<cfif isdefined('form.disp')>
				<cfset disp = #form.disp#>
			</cfif>

          <cfif disp LT qryCatalog.recordcount + 1>
            <form name = "PageSelect" method="Post" <cfoutput>action="index.cfm?action=ViewCategory&category=#category#&viewby=#viewby#&sortorder=#sortorder#"</cfoutput>>
              <select name="start" OnChange="this.form.submit();">
                <cfset PageCount = 1>
								<!---Get total number of pages--->
								<cfset TotalPages = 0>
								<cfloop Index="Pages" FROM="1" TO="#qryCatalog.recordcount#" Step="#disp#">
									<cfset TotalPages = TotalPages + 1>
								</cfloop>
								<!---build page selection--->
                <cfloop Index="Pages" FROM="1" TO="#qryCatalog.recordcount#" Step="#disp#">
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
        </div></td>
    <td width="15%">
	<form name="Displayoptions" method="POST" <cfoutput>action="index.cfm?action=viewcategory&category=#category#"</cfoutput>>
      <select name = "disp" onchange="this.form.submit();">
			<option value="8" <cfif disp IS '8'>SELECTED</cfif>>Display 8 per page</option>
			<option value="16" <cfif disp IS '16'>SELECTED</cfif>>Display 16 per page</option>
			<option value="24" <cfif disp IS '24'>SELECTED</cfif>>Display 24 per page</option>
			<option value="48" <cfif disp IS '48'>SELECTED</cfif>>Display 48 per page</option>
			<option value="60" <cfif disp IS '60'>SELECTED</cfif>>Display 60 per page</option>
		</select>
	</form></td>
</tr>
</table>--->
</cfif>
</td>
</tr>

</table>

<cfif ShowSubCats IS 'No' AND qryCatalog.recordcount IS 0><b>No products available in this Category</b>
</cfif>



