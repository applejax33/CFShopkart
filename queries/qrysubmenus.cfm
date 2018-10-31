<cfquery name = "qrySubMenus" datasource="#request.dsn#">
SELECT * FROM nav_links
WHERE SubLinkOf = <cfqueryparam value="#qryNavTop.id#" cfsqltype="cf_sql_varchar">
ORDER BY ordervalue ASC
</cfquery>



