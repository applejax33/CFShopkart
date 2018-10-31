<cfinclude template = "../queries/qrytickets.cfm">
<cfinclude template = "../queries/qryreplies.cfm">

<table width="98%" align="center" cellpadding="4" cellspacing="0" class="Ticket_ReadTicketTable">
<tr>
<td class="Ticket_ReadTicketArea">

<table width="100%" cellpadding="4" cellspacing="0" class="Ticket_OriginalMessageTable">
<tr>
<td class="Ticket_OriginalMessage">
<cfoutput query = "qryTickets">
<strong>Original message:</strong>
<br />
#htmleditformat(message)#
<p></p>
</cfoutput>
</td>
</tr>
</table>
<p>
<cfif qryReplies.recordcount IS 0>
<p style="font-weight: bold; font-style: italic">
This support ticket has not received a response yet.  A support rep will respond soon!  Thank you for your patience.</p>
<cfelse>
<!---Set support rep name to name of store owner--->
<cfset repname = '#request.firstname#'>

<cfoutput query = "qryReplies">
<table width="100%" cellpadding="4" cellspacing="0" class="Ticket_ResponsesTable">
<tr>
<td class="Ticket_ResponseMessage">
<strong>Reply From #replyby#:</strong> <cfif status IS 'unread'>New Reply!</cfif>
<br />
#reply#
</td>
</tr>
</table>
<p>
</cfoutput>
<p class="Ticket_StatusSection">
<cfif qryTickets.nextaction IS 'Waiting For Reply'>
	<cfif NOT qryTickets.status IS 'closed'>
		Post a response to this ticket:
		<br />
		<form method="post" action="index.cfm?action=tickets.replytoticket">
		<cfoutput><input type = "hidden" name = "ticketid" value="#qryTickets.ticketid#" /></cfoutput>
		<textarea name="ticketreply" cols="55" rows="8"></textarea>
		<br />
		<input type = "submit" name="replytoticketsubmit" value="Post Reply" />
		</form>
	<cfelse>
		<b><em>This ticket has been closed.  You will need to open a new ticket if you need additional help. Please reference the ticket id number in your new support ticket.</em></b>
	</cfif>
<cfelse>
	<cfif qryTickets.nextaction IS 'Ticket Closed'>	
		<b><em>This ticket has been closed.  You will need to open a new ticket if you need additional help.<br />Please reference the ticket id number in your new support ticket.</em></b>
    <cfelse>
    	<b><em>You cannot respond to this ticket until you get a response from your last reply.  Check back later for a reply. </em></b>
    </cfif>
</cfif>
</cfif>
<p>
<cfoutput><a href = "index.cfm?action=tickets.default&carttoken=#carttoken#">Go back</a></cfoutput>
</td>
</tr>
</table>
<!---Set status of all replies to read since the customer has looked at the ticket (only replies NOT by them).--->
<cfquery name = "qryUpdateReplyStatus" datasource="#request.dsn#">
UPDATE support_replies
SET status = 'Read'
WHERE ticketid = <cfqueryparam value="#qryTickets.ticketid#" cfsqltype="cf_sql_varchar">
AND replyby <> <cfqueryparam value="#cookie.customerid#" cfsqltype="cf_sql_varchar">
</cfquery>

<!---If it's closed then set the next action to ticket closed to confirm that this customer has read the final message--->
<cfif qryTickets.status IS 'Closed'>
	<cfquery name = "qryUpdateNextAction" datasource="#request.dsn#">
	UPDATE support_tickets
	SET nextaction = <cfqueryparam value="Ticket Closed" cfsqltype="cf_sql_varchar">
	WHERE ticketid = <cfqueryparam value="#qryTickets.ticketid#" cfsqltype="cf_sql_varchar">
	</cfquery>
</cfif>








