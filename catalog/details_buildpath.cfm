<!---Builds a path to the item to show on details page--->
<cfset CurrentViewPath = #qryCategories.CategoryPath#>
<cfset OutputString = '<a href = "#request.HomeURL#">Home</a>'>
<cfif NOT CurrentViewpath IS "/">
<cfloop From='1' To='#ListLen(CurrentViewpath, "/")#' Index="MyCount">
	<cfset TheCategoryID = #ListGetAt(CurrentViewPath, MyCount, "/")#>
		<cfinclude template = "../queries/qryFindCategory.cfm">
		<cfoutput query = "FindCategory">
			<cfset OutputString = OutputString & ' | <a href="index.cfm?carttoken=#carttoken#&action=viewcategory&Category=#CategoryID#">#CategoryName#</a>'>
  </cfoutput>
</cfloop>
</cfif>
<cfif ISDEFINED('url.Category')>
<cfset OutputString = OutputString & ' | <a href="index.cfm?carttoken=#carttoken#&action=viewcategory&Category=#url.Category#">#qryCategories.CategoryName#</a> | #qryproducts.ProductName#'>
</cfif>
<!---show the path--->
<cfif isdefined('url.category')><cfoutput>#OutPutString#</cfoutput></cfif>




