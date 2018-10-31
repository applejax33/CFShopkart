<!---This will display the categories.  When a user clicks on a category the screen is refreshed and they will then view that category plus any subcategories will be visible, indented beneath this one.--->

<cfif request.CategoryDisplay IS 'HTMLTree'>
	<cfinclude template = "Categories_HTMLTree.cfm">
</cfif>

<cfif request.CategoryDisplay IS 'Image'>
	<cfinclude template = "Categories_Image.cfm">
</cfif>

<cfif request.CategoryDisplay IS 'html'>
	<cfinclude template = "Categories_HTML.cfm">
</cfif>



