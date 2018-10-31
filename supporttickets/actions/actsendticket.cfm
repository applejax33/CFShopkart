<cfquery name = "qryUserInfo" datasource="#request.dsn#">
SELECT * FROM customerhistory
WHERE customerid = <cfqueryparam value="#cookie.customerid#" cfsqltype="cf_sql_integer">
</cfquery>

<!---Generate a ticketID for this one--->
<cfset charlist  = "0|2|4|6|8|9|7|5|3|1|A|C|E|H|J|K|M|P|O|Q|S|T|U|V|W|X|Y|0|2|4|6|8|9|7|5|3|1">

<cfset TheDateCreated = #Now()#>
<cfset TheDateCreated = #dateformat(TheDateCreated, "yyyy-mm-dd")#>

<cfset ThisTicketID = "">
<cfloop condition="NOT len(ThisTicketID)">

	<cfloop from="1" to="15" index="i">
	
		<!--- pick a random number between 1 and the length of the list of chars to use --->
		<cfset ThisNum = RandRange(1,listlen(charlist, "|"))>
	
		<!--- get the character that is at the random numbers position in the list of characters ---> 
		<cfset ThisChar = ListGetAt(Charlist, ThisNum, "|")>
	
		<!--- append the new random character to the Password ---> 
		<cfset ThisTicketID = "#ThisTicketID##ThisChar#">

	</cfloop>

<cfset ThisTicketID = '#cookie.customerid#-#ThisTicketID#'>

<!--- Make sure code is not already in use --->
<cfquery name="qTickets" datasource="#Request.dsn#">
SELECT ticketID FROM support_tickets
WHERE ticketid = <cfqueryparam value="#ThisTicketID#" cfsqltype="cf_sql_varchar">
</cfquery>

<!---Already used so generate another one--->
<cfif qTickets.RecordCount>
	<cfset ThisTicketID = "">
</cfif>
</cfloop>

<!---Now enter the ticket into the database--->
<cfquery name = "InsertNewTicket" datasource="#request.dsn#">
INSERT INTO support_tickets
(ticketid, title, message, status, datesubmitted, supportrep, nextaction, emailaddress, name, customerid)
VALUES
(<cfqueryparam value="#ThisTicketID#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#form.title#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#form.message#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="Submitted" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#TheDateCreated#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#request.companyname#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="NEW TICKET" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#qryUserInfo.emailaddress#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#qryUserInfo.FirstName# #qryUserInfo.LastName#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#cookie.customerid#" cfsqltype="cf_sql_varchar">)
</cfquery>

<cfsavecontent variable="messagebody">
<cfoutput>
<h3>New Support Ticket Notification</h3>
<b>Ticket ID: #ThisTicketID#</b>
<p>
From: #qryUserInfo.firstname# #qryUserInfo.lastname# has submitted a support ticket.  Log into your store control panel to view the support ticket and to reply to it.  Below is the message this person sent:
<p>
#form.message#
</cfoutput>
</cfsavecontent>

<cfif request.UseMailServer IS 'Yes'>

	<cfif request.UseMailLogin IS 'Yes'>
        <cfmail server="#request.MailServer#"
        username="#request.mailuser#"
        Password="#request.mailpassword#"
        From="#qryUserInfo.EmailAddress#"
        TO="#request.emailaddress#"
        SUBJECT="NEW SUPPORT TICKET (#ThisTicketID#) submitted"
        type="html">
        #messagebody#
        </cfmail>
      <cfelse>
        <cfmail server="#request.MailServer#"
        From="#qryUserInfo.EmailAddress#"
        TO="#request.emailaddress#"
        SUBJECT="NEW SUPPORT TICKET (#ThisTicketID#) submitted"
        type="html">
        #messagebody#
        </cfmail>       
    </cfif>

<cfelse>

	<cfif request.UseMailLogin IS 'Yes'>
        <cfmail username="#qryCustomerInfo.EmailAddress#"
        Password="#request.mailpassword#"
        From="#qryUserInfo.EmailAddress#"
        TO="#request.emailaddress#"
        SUBJECT="NEW SUPPORT TICKET (#ThisTicketID#) submitted"
        type="html">
        #messagebody#
        </cfmail>
      <cfelse>
        <cfmail From="#qryUserInfo.EmailAddress#"
        TO="#request.emailaddress#"
        SUBJECT="NEW SUPPORT TICKET (#ThisTicketID#) submitted"
        type="html">
        #messagebody#
        </cfmail>       
    </cfif>

</cfif>

<!---Send an email to the support rep--->
<p>
<center><b>Your support ticket has been sent!</b>
<p>
<cfoutput><a href = "index.cfm?action=tickets.default&carttoken=#carttoken#">Back to tickets</a></center></cfoutput>







