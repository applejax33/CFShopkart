<!---Combine the local and the remote top navigation menu items into one query for simplification--->
<cfquery name = "qryNavTop" datasource="#request.dsn#">
SELECT * FROM nav_links
WHERE sublinkof = <cfqueryparam value="0" cfsqltype="cf_sql_varchar">
ORDER BY ordervalue ASC
</cfquery>



