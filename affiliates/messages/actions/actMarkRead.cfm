<cfquery name = "MarkAsRead" datasource="#request.dsn#">
UPDATE afl_messages
SET wasread = 'Yes'
WHERE msgid = #url.msgid#
</cfquery>







