<cfquery name = "qryAccount" datasource="#request.dsn#">
SELECT * FROM afl_affiliates
WHERE affiliateid = <cfqueryparam value="#qryLogin.affiliateid#" cfsqltype="cf_sql_varchar">
</cfquery>