<cfquery name = "qryReplies" datasource="#request.dsn#">
SELECT * FROM support_replies
WHERE ticketid = <cfqueryparam value="#url.ticketid#" cfsqltype="cf_sql_varchar">
</cfquery>







