<cfquery name = "qry_ArchiveYears" datasource="#request.dsn#">
SELECT DISTINCT blog_year FROM blog_posts ORDER BY blog_year ASC
</cfquery>







