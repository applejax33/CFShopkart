<cfquery name = "qryDelete" datasource="#request.dsn#">
DELETE FROM afl_messages
WHERE msgid = #url.msgid#
</cfquery>

<cflocation url = "index.cfm?action=messages.viewmessages">







