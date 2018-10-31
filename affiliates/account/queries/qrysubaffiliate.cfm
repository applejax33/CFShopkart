<cfquery name = "qrySubAffiliate" datasource="#request.dsn#">
SELECT * FROM afl_affiliates
WHERE affiliateid = <cfqueryparam value="#Subaffiliateid#" cfsqltype="cf_sql_varchar">
</cfquery>