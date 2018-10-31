<cfquery name = "qryMessages" datasource="#request.dsn#">
SELECT * FROM afl_messages
WHERE recipient = 'admin'
</cfquery>








