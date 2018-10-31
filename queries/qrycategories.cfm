<cfquery name = "qryAllCategories" datasource="#request.dsn#">
SELECT * FROM categories 
Order by OrderValue ASC 
</cfquery>

<cfquery name = "qryCategories" dbtype="query">
SELECT * FROM qryAllCategories 
<cfif ISDEFINED('url.Category')>
	WHERE CategoryID = <cfqueryparam value="#url.Category#" cfsqltype="cf_sql_integer">
</cfif>
<cfif ISDEFINED('form.Category')>
	WHERE CategoryID = <cfqueryparam value="#form.Category#" cfsqltype="cf_sql_integer">
</cfif>
Order by OrderValue ASC 
</cfquery>

<cfquery name = "qryMainCategories" dbtype="query">
SELECT * FROM qryAllCategories 
WHERE SubCategoryof = <cfqueryparam value="0" cfsqltype="cf_sql_varchar">
Order by OrderValue ASC 
</cfquery>





