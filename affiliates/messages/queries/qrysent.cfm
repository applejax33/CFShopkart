<cfquery name = "qrySent" datasource="#request.dsn#">
SELECT * FROM afl_messages_sent
WHERE sender = '#qryLogin.AffiliateID#'
</cfquery>








