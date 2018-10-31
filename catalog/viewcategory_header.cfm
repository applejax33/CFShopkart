<CFPARAM name="start" default="1">
<CFPARAM name="disp" default="24">
<CFPARAM name="ShowSubCats" default="Yes">
<cfparam name = "viewby" default="ordervalue">
<cfparam name = "sortorder" default="ASC">
<cfparam name = "currentcategory" default="0">

<!---set some cookies so we can save their sorting and display preferences...these clear when the browser window is closed.--->
<cfif isdefined('url.category')>
	<cfcookie name="category" value="#url.category#">
</cfif>
<cfif isdefined('url.sortorder')>
	<cfcookie name="sortorder" value="#url.sortorder#">
</cfif>
<cfif isdefined('url.disp')>
	<cfcookie name="disp" value="#url.disp#">
</cfif>
<cfif isdefined('url.viewby')>
	<cfcookie name="viewby" value="#url.viewby#">
</cfif>
<cfif isdefined('url.start')>
	<cfcookie name="start" value="#url.start#">
</cfif>
<cfif isdefined('url.sortorder')>
	<cfcookie name="sortorder" value="#url.sortorder#">
</cfif>

<cfif isdefined('form.category')>
	<cfcookie name="category" value="#form.category#">
</cfif>
<cfif isdefined('form.sortorder')>
	<cfcookie name="sortorder" value="#form.sortorder#">
</cfif>
<cfif isdefined('form.disp')>
	<cfcookie name="disp" value="#form.disp#">
</cfif>
<cfif isdefined('form.viewby')>
	<cfcookie name="viewby" value="#form.viewby#">
</cfif>
<cfif isdefined('form.start')>
	<cfcookie name="start" value="#form.start#">
</cfif>
<cfif isdefined('form.sortorder')>
	<cfcookie name="sortorder" value="#form.sortorder#">
</cfif>

<cfif isdefined('cookie.category')>
	<cfset category = cookie.category>
</cfif>
<cfif isdefined('cookie.sortorder')>
	<cfset sortorder = cookie.sortorder>
</cfif>
<cfif isdefined('cookie.disp')>
	<cfset disp = cookie.disp>
</cfif>
<cfif isdefined('cookie.viewby')>
	<cfset viewby = cookie.viewby>
</cfif>
<cfif isdefined('cookie.start')>
	<cfset start = cookie.start>
</cfif>
<cfif isdefined('cookie.sortorder')>
    <cfset sortorder = cookie.sortorder>
</cfif>
<cfif isdefined('cookie.category')>
	<cfset currentcategory = cookie.category>
</cfif>

<!---JW:  1/13/08 replaced qryproudcts.cfm with qrycatalog.cfm which gets rid of the need to build
a query...uses the new product_categories table--->

<!---<cfinclude template = "../queries/qryproducts.cfm">--->
<cfinclude template = "../queries/qrycatalog.cfm">
<cfinclude template = "../queries/qrysubcategories.cfm">

<!---if this category has no products in it, then jump to first sub category--->
<cfif qrySubCategories.recordcount GT 0>
	<cfif qryCatalog.recordcount IS 0>
    	<cfoutput query = "qrySubCategories" maxrows="1">
        	<cfset CurrentCategory = qrySubCategories.categoryid>
            <cfset url.category = CurrentCategory>
        </cfoutput>

        <cfinclude template = "../queries/qrycatalog.cfm">
        <cfinclude template = "../queries/qrysubcategories.cfm">

	</cfif>
</cfif>        
        
<cfinclude template = "../queries/qrycompanyinfo.cfm">
<cfinclude template = "../queries/qrysales.cfm">


<!--- loop over each product and build a list of products that match this 
category.  Then create a custom query based on the list--->

<CFSET end=start + disp>
<CFIF end GREATER THAN qryCatalog.RecordCount>
  <CFSET end=999>
<CFELSE>
  <CFSET end=end-1>
</CFIF>

<!---go right to the product if it's the only one in the category and there are no subcategories--->
<cfif qryCatalog.recordcount IS 1 and qrySubCategories.recordcount IS 0>

<cfloop query = "qryCatalog">
	<cfquery name = "ProductQuery" datasource="#request.dsn#">
	SELECT * FROM products WHERE itemid = <cfqueryparam value="#qryCatalog.itemid#" cfsqltype="cf_sql_integer">
	</cfquery>
</cfloop>

<cfoutput query = "ProductQuery">

<cfif ISDEFINED('url.Category')>
<script language="javascript">
<!-- 
location.replace("index.cfm?carttoken=#carttoken#&action=ViewDetails&ItemID=#ItemID#&Category=#url.Category#&viewby=#viewby#&sortorder=#sortorder#");
-->
</script>
</cfif>

<cfif ISDEFINED('form.Category')>
<script language="javascript">
<!-- 
location.replace("index.cfm?carttoken=#carttoken#&action=ViewDetails&ItemID=#ItemID#&Category=#form.Category#&viewby=#viewby#&sortorder=#sortorder#");
-->
</script>
</cfif>

</cfoutput>
</cfif>

<!---read the category details if it exists--->
<cfset catdetails = ''>

<cfif fileexists('#request.CatalogPath#docs#request.bslash#categories#request.bslash#category_#qryCategories.categoryid#.cfm')>
    <cffile action = "read"
    file = "#request.CatalogPath#docs#request.bslash#categories#request.bslash#category_#qryCategories.categoryid#.cfm" 
    variable = "catdetails"
    >
</cfif>

<table width="100%" cellpadding="4" cellspacing="0">
    <tr>
	  <td colspan="3">
		<!---build the path to the current category--->
			<cfset CurrentViewPath = #qryCategories.CategoryPath#>
			<cfset OutputString = '<a href = "#request.HomeURL#">Home</a>'>
			<cfif NOT CurrentViewpath IS "/">
			<cfloop From='1' To='#ListLen(CurrentViewpath, "/")#' Index="MyCount">
				<cfset TheCategoryID = #ListGetAt(CurrentViewPath, MyCount, "/")#>
					<cfquery name = "FindCategory" datasource="#request.dsn#">
					SELECT * FROM categories WHERE CategoryID = #TheCategoryID#
					</cfquery>
					<cfoutput query = "FindCategory">
						<cfset OutputString = OutputString & ' | <a href="index.cfm?carttoken=#carttoken#&action=viewcategory&Category=#CategoryID#">#CategoryName#</a>'>
			  </cfoutput>
			</cfloop>
			</cfif>
			<cfif ISDEFINED('url.Category')>
			<cfset OutputString = OutputString & ' | #qryCategories.CategoryName#'>
  </cfif>
  <cfif NOT currentcategory IS '0'>
  	<cfoutput>#OutPutString#</cfoutput>      
  </cfif>
      </td>
	  </tr>
<cfif NOT currentcategory IS 0>
<tr>
	<td>
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
	    <tr>
		<!---Show the category name if there is a custom description specified--->
	      <td> 
	      <cfoutput query = "qryCategories">
		  <cfif len(catdetails) IS 0><h3>#qryCategories.CategoryName#</h3><cfelse>#catdetails#</cfif><a name="topofpage"></a>
		  </cfoutput>
          </td>
		 </tr>
	 </table>
</td>
</tr>
</cfif>    
<cfif NOT ShowSubCats IS 'No'>
	<!---If there are sub categories, display them first--->
	<cfset mycount = 0>
	<tr>
	  <td>
        <table align = "center" border="0" cellspacing="0" cellpadding="2">
          <tr>
		  <cfoutput query = "qrySubCategories">
            <td width="130" valign="bottom">
            <p align="center"><a href = "index.cfm?carttoken=#carttoken#&Action=ViewCategory&Category=#CategoryID#">
			<cfif NOT #qrySubCategories.CategoryImage# IS 'None'><img src="images/#qrySubCategories.CategoryImage#" border="0" alt="#qrySubCategories.CategoryName#" title="#qrySubCategories.CategoryName#" <cfif NOT #qrySubCategories.CategoryRImage# IS 'None'>onmouseover="this.src='images/#qrySubCategories.CategoryRImage#';" onmouseout="this.src='images/#qrySubCategories.CategoryImage#';"</cfif>></cfif><br>
            <b>#CategoryName#</b></a></td>
			<cfset mycount = mycount + 1>
			<cfif mycount IS 4>
			<tr><cfset mycount = 0>
		  </cfif>
		  </cfoutput>
          </table>
		</td>
	</tr>

<tr>
<td>
<!---Display the pagination--->
<table width = "100%" cellpadding="4" cellspacing="0">
<cfif qryCatalog.recordcount GT 0>
	<tr>
		<td width="70%">
		<form name = "SortForm" <cfoutput>action="index.cfm?action=viewcategory&category=#category#&disp=#disp#&start=#start#"</cfoutput> method="post">
		 Sort by 
		   <select name="viewby" onchange="this.form.submit();">
             <option value = 'ordervalue' <cfif viewby IS 'ordervalue'>SELECTED</cfif>>Featured Products</option>
             <option value = 'productname' <cfif viewby IS 'productname'>SELECTED</cfif>>By Item Name</option>
             <option value = 'price' <cfif viewby IS 'price'>SELECTED</cfif>>By Price</option>
             <cfif request.showproductreviews IS 'Yes'>
               <option value = 'rating' <cfif viewby IS 'rating'>SELECTED</cfif>>Customer Rating</option>
             </cfif>
             <option value = 'UnitsSold' <cfif viewby IS 'UnitsSold'>SELECTED</cfif>>Most Popular</option>
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
</cfif>
</table>
</td>
</tr>

	<cfif NOT #qrySubCategories.RecordCount# IS 0>
		<cfif NOT qryCatalog.RecordCount IS 0>
			<tr class="TableTitles">
				<td></td>
		  </tr>
		</cfif>
	</cfif>
</cfif>