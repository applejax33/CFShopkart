<cfset CurrentCategoryPath = "NONE">

<cfinclude template = "../queries/qrycategories.cfm">

<!---Check to see if the categoryid variable exists.  If it does then query the database and get the path of the currently selected category--->
<cfif ISDEFINED('url.Category')>
	<cfquery name = "GetPath" datasource = '#request.dsn#'>
	SELECT CategoryPath FROM categories WHERE CategoryID = #url.Category#
	</cfquery>
	<cfset CurrentCategoryPath = '#GetPath.CategoryPath##url.Category#/'>
</cfif>

<cfif ISDEFINED('form.Category')>
	<cfquery name = "GetPath" datasource = '#request.dsn#'>
	SELECT CategoryPath FROM categories WHERE CategoryID = #form.Category#
	</cfquery>

	<cfset CurrentCategoryPath = '#GetPath.CategoryPath##form.Category#/'>	
</cfif>

	<cf_MainCategoryTree Directory="/"
	ShowCurrentView="Yes"
	PathView="#CurrentCategoryPath#"
	Datasource="#request.dsn#"
	CartToken="#CartToken#"
	ShowBullet="No">



