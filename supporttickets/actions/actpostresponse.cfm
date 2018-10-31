<cfquery name = "qryGetTicket" datasource="#request.dsn#">
SELECT * FROM support_tickets
WHERE ticketid = <cfqueryparam value="#form.ticketid#" cfsqltype="cf_sql_varchar">
</cfquery>

<!---Get customers email address--->
<cfquery name = "qryCustomerInfo" datasource="#request.dsn#">
SELECT * FROM customerhistory
WHERE customerid = <cfqueryparam value="#cookie.customerid#" cfsqltype="cf_sql_integer">
</cfquery>

<!---Enters a response/update for this ticket--->
<cfquery name = "qryInsertResponse" datasource="#request.dsn#">
INSERT INTO support_replies
(ticketid, reply, replyby)
VALUES
(<cfqueryparam value="#form.ticketid#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#form.ticketreply#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#qryCustomerInfo.firstname# #qryCustomerInfo.lastname#" cfsqltype="cf_sql_varchar">)
</cfquery>

<!---Set the status of this ticket to open since this person responded to it--->
<cfquery name = "qryUpdateStatus" datasource="#request.dsn#">
UPDATE support_tickets
SET status = <cfqueryparam value="Open" cfsqltype="cf_sql_varchar">,
nextaction = <cfqueryparam value="Reply Needed" cfsqltype="cf_sql_varchar">
WHERE ticketid = <cfqueryparam value="#form.ticketid#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfsavecontent variable="messagebody">
<cfoutput>
<h3>Support Ticket Response</h3>

The customer has posted a response to a support ticket with the <br />
Ticket ID of #form.ticketID#<br />
From: #qryCustomerInfo.FirstName#  #qryCustomerInfo.FirstName#
Response is below:<br />
<p>
#form.ticketreply#
</cfoutput>
</cfsavecontent>

<cfif request.UseMailServer IS 'Yes'>

	<cfif request.UseMailLogin IS 'Yes'>
        <cfmail server="#request.MailServer#"
        username="#request.mailuser#"
        Password="#request.mailpassword#"
        From="#qryCustomerInfo.EmailAddress#"
        TO="#request.emailaddress#"
        SUBJECT="SUPPORT TICKET REPLY #form.TicketID#"
        type="html">
        #messagebody#
        </cfmail>
      <cfelse>
        <cfmail server="#request.MailServer#"
        From="#qryCustomerInfo.EmailAddress#"
        TO="#request.emailaddress#"
        SUBJECT="SUPPORT TICKET REPLY #form.TicketID#"
        type="html">
        #messagebody#
        </cfmail>       
    </cfif>

<cfelse>

	<cfif request.UseMailLogin IS 'Yes'>
        <cfmail username="#qryCustomerInfo.EmailAddress#"
        Password="#request.mailpassword#"
        From="#qryCustomerInfo.EmailAddress#"
        TO="#request.emailaddress#"
        SUBJECT="SUPPORT TICKET REPLY #form.TicketID#"
        type="html">
        #messagebody#
        </cfmail>
      <cfelse>
        <cfmail From="#qryCustomerInfo.EmailAddress#"
        TO="#request.emailaddress#"
        SUBJECT="SUPPORT TICKET REPLY #form.TicketID#"
        type="html">
        #messagebody#
        </cfmail>       
    </cfif>

</cfif>

<p>
<center><b>Your response has been posted.</b>
<p>
<cfoutput><a href = "index.cfm?action=tickets.default&carttoken=#carttoken#">Go Back</a></p></center></cfoutput>







