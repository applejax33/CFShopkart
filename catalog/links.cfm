<!---displays a list of links in a table (if there are some)--->

<cfif request.LinksDisplay IS 'HTML'>
	<cfinclude template = "Links_HTML.cfm">
</cfif>

<cfif request.LinksDisplay IS 'Image'>
	<cfinclude template = "Links_image.cfm">
</cfif>



