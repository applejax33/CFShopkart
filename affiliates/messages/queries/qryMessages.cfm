<cfquery name = "qryMessages" datasource="#request.dsn#">
SELECT * FROM afl_messages
WHERE recipient = '#qryLogin.affiliateid#'
ORDER BY datesent DESC
</cfquery>








