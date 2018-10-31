<cfquery name = "qryMessages" datasource="#request.dsn#">
SELECT * FROM afl_messages
WHERE recipient = '#qryLogin.affiliateid#' and wasread = 'No'
ORDER BY datesent DESC
</cfquery>








