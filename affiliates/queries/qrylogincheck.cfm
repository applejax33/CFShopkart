<cfquery name = "qryLogin" datasource="#request.dsn#">
SELECT * FROM afl_affiliates
WHERE affiliateID = <cfqueryparam value="#request.affiliateID#" cfsqltype="cf_sql_varchar">
AND password = <cfqueryparam value="#request.affiliatepw#" cfsqltype="cf_sql_varchar">
AND account_status = <cfqueryparam value="1" cfsqltype="cf_sql_varchar">
OR email = <cfqueryparam value="#request.affiliateID#" cfsqltype="cf_sql_varchar">
AND password = <cfqueryparam value="#request.affiliatepw#" cfsqltype="cf_sql_varchar">
AND account_status = <cfqueryparam value="1" cfsqltype="cf_sql_varchar">
</cfquery>



