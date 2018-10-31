<!---Build the path to this category--->
<cfquery name = "qryBuildPath" datasource="#request.dsn#">
SELECT * FROM categories
WHERE categoryid = #CurrentCategory#
</cfquery>

<cfoutput query = "qryBuildPath">
	<cfset thispath = #categorypath#>
</cfoutput>

<!---loop over the path of the current catgory and query each category in the path and build
the path to it from that--->
<cfset categorypath = "">
<cfloop from = "1" to="#listlen(thispath, '/')#" index="cCount">
	<cfset catid = #listgetat(thispath, cCount, "/")#>
	
	<cfquery name = "qryCurrentCat" datasource="#request.dsn#">
	SELECT * FROM categories
	WHERE categoryid = #catid#
	</cfquery>
	
	<cfif cCount LT 3>
		<cfif cCount IS 1>
		<cfset categorypath = categorypath & '<a class="footer" href = "index.cfm?action=viewcategory&category=#catid#">#qryCurrentCat.CategoryName#</a>'>
		
		<cfelse>
	
		<cfset categorypath = categorypath & ' > <a class="footer" href = "index.cfm?action=viewcategory&category=#catid#">#qryCurrentCat.CategoryName#</a>'>
		
		</cfif>
	</cfif>	
</cfloop>

	<cfset categorypath = categorypath & ' > <a class="footer" href = "index.cfm?action=viewcategory&category=#qryBuildPath.CategoryID#">#qryBuildPath.CategoryName#</a>'>





