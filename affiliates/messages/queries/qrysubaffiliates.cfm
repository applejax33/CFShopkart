<!---query the this person subaffiliates--->
<cfquery name = "qrySubAffiliates" datasource = "#request.dsn#">
SELECT * FROM afl_affiliates
WHERE subaffiliateof = '#qryLogin.affiliateID#'
</cfquery>







