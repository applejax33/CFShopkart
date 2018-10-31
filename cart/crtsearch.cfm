<cfoutput>
<script language="JavaScript">
 function ViewItem(itemid){
		window.location.href = 'index.cfm?carttoken=#carttoken#&action=ViewDetails&ItemID=' + itemid;
 }
</script>
</cfoutput>

<cfif ISDEFINED('form.Searchbox')>
<cfset SearchQuery = '#form.SearchBox#'>
</cfif>

<cfif ISDEFINED('url.Searchbox')>
<cfset SearchQuery = '#url.SearchBox#'>
</cfif>

<cfif ISDEFINED('url.SearchQuery')>
<cfset SearchQuery = '#url.SearchQuery#'>
</cfif>

<cfinclude template = "../queries/qryproductsearch.cfm">

<CFPARAM name="start" default="1">
<!--- Number of records to display on a page --->
<CFPARAM name="disp" default="#request.MaxRecords#">

<CFSET end=Start + disp>
<CFIF start + disp GREATER THAN QryProducts.RecordCount>
  <CFSET end=999>
<CFELSE>
  <CFSET end=disp>
</CFIF>

<p style="font-weight: bold">Search Results:</p>
<table width="100%" border="0" cellspacing="0" cellpadding="4" class="SearchTable">
  <tr> 
    <td width="5%" class="TableTitles"><div align="left">&nbsp;</div></td>
    <cfif request.ShowProductID IS 'Yes'>
      <td width="10%" class="TableTitles" style="font-weight: bold">Sku</td>
    </cfif>
    <td class="TableTitles"><div align="left"><strong>Item</strong></div></td>
    <td width="10%" class="TableTitles"><div align="center"><strong>Price</strong></div></td>
  </tr>
  <cfset SearchCount = 0>
  <cfset MyCount = 0>
  <cfoutput query="qryProducts" startrow="#start#" maxrows="#end#">
      <cfset SearchCount = SearchCount + 1>
	  <cfset mycount = mycount + 1>
      <tr class="selecttr" onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'"> 
        <td valign="top" onclick="ViewItem(#itemid#);" class="SearchTableRow">
        <div class="search_thumbnailcell">
        <a href="index.cfm?carttoken=#carttoken#&action=ViewDetails&ItemID=#ItemID#">        
            <cfinclude template = "../queries/qryProductimages.cfm">
            
            <cfif qry_ProductImages.recordcount IS 0>
                <cfset TheThumbnail = "#request.HomeURL#photos/tiny/nopic.jpg">
            </cfif>
            
            <cfloop query = "qry_ProductImages" startrow="1" endrow="1">
                <cfset TheThumbnail = "#request.HomeURL#photos/tiny/#qry_ProductImages.iFileName#">
            </cfloop>           
            <img src="#TheThumbnail#" border="0" Alt="#ProductName#" class="search_thumbnail" />                    
        </a>
        </div>
        </td>
        <cfif request.ShowProductID IS 'Yes'><td valign="top" class="SearchTableRow" onclick="ViewItem(#itemid#);"><a href="index.cfm?carttoken=#carttoken#&action=ViewDetails&ItemID=#ItemID#" class="search_sku">#sku#</a></td></cfif>
        <td valign="top" class="SearchTableRow" onclick="ViewItem(#itemid#);"><div class="search_itemcell"><a href="index.cfm?carttoken=#carttoken#&action=ViewDetails&ItemID=#ItemID#" class="search_productname">#ProductName#</a><br /><div class="search_briefdescription">#briefdescription#</div>
        </div>
        </td>
        <td valign="middle" class="SearchTableRow" onclick="ViewItem(#itemid#);">
            <div class="search_price"><cfif NOT Price IS 0>
              <cfif request.EnableEuro IS 'Yes'>
                #lseurocurrencyformat(Price, "Local")#
              </cfif>
              <cfif NOT request.EnableEuro IS 'Yes'>
                #lscurrencyformat(Price, "Local")# 
              </cfif>
              <cfelse>
              &nbsp;
            </cfif>
            </div>
		</td>
      </tr>
	<cfif mycount IS 2><cfset mycount = 0></cfif>
  </cfoutput> 
</table>
<CFOUTPUT>
<br>
<table border="0" align="center" cellpadding="10">
<tr>
<!--- Display prev link --->
<CFIF start NOT EQUAL 1>
  <CFIF start GTE disp>
    <CFSET prev=disp>
    <CFSET prevrec=start - disp>
  <CFELSE>
    <CFSET prev=start - 1>
    <CFSET prevrec=1>
  </CFIF>
  <td class="search_previous"><font face="wingdings"></font> <a
href="index.cfm?carttoken=#carttoken#&action=Search&SearchQuery=#SearchQuery#&start=#prevrec#">Previous #prev#
Results</a></td>

</CFIF>
<!--- Display next link --->
<CFIF end LT QryProducts.RecordCount>
  <CFIF start + disp * 2 GTE qryProducts.RecordCount>
    <CFSET next=QryProducts.RecordCount - start - disp + 1>
  <CFELSE>
    <CFSET next=disp>
  </CFIF>
  <td class="search_next"><a href="index.cfm?carttoken=#carttoken#&action=Search&SearchQuery=#SearchQuery#&start=#Evaluate("start + disp")#">Next
#next# Results</a> <font face="wingdings"></font></td>
</cfif>
</table>
</CFOUTPUT>

<cfif SearchCount IS 0>
  <i>Your search returned <strong>0</strong> Results. Please try your search again</i> 
</cfif>
<!---This file is called from index.cfm when the form field SearchCatalog is present
--->



