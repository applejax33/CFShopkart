<cfquery name = "qrySubMenus2" datasource="#request.dsn#">
SELECT * FROM nav_links
WHERE SubLinkOf = <cfqueryparam value="#qrySubMenus.id#" cfsqltype="cf_sql_varchar">
ORDER BY ordervalue ASC
</cfquery>



