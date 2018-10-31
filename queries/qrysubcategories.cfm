<cfquery name = "qrySubCategories" Datasource="#request.dsn#">
SELECT * FROM categories
<cfif ISDEFINED('url.Category')>
WHERE SubCategoryOf = <cfqueryparam value="#url.Category#" cfsqltype="cf_sql_varchar">
</cfif>
<cfif ISDEFINED('form.Category')>
WHERE SubCategoryOf = <cfqueryparam value="#form.Category#" cfsqltype="cf_sql_varchar">
</cfif>
ORDER BY OrderValue ASC
</cfquery>



