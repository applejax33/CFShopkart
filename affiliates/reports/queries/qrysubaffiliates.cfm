<cfquery name="qrySubAffiliates" datasource="#request.dsn#">
SELECT * FROM afl_affiliates 
WHERE subaffiliateof = <cfqueryparam value="#qryLogin.AffiliateID#" cfsqltype="cf_sql_varchar">
</cfquery>







