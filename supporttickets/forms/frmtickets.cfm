<cfinclude template = "../actions/actchecklogin.cfm">
<cfinclude template = "../queries/qrytickets.cfm">

<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td align="right"><cfoutput>
      <div align="left"><a href="index.cfm?action=myaccount&amp;carttoken=#carttoken#">Back to Menu</a>
      </div>
      <div align="left"></div>
    </cfoutput></td>
    <td colspan="2" align="right"><cfoutput><img src="customers/icons/support.gif" width="32" height="32" align="absmiddle" /> <a href="index.cfm?action=tickets.new&carttoken=#carttoken#">New Support Ticket</a></cfoutput></td>
  </tr>
  <tr>
    <td class="TableTitles"><strong>Date</strong></td>
    <td class="TableTitles"><strong>Ticket No. </strong></td>
    <td class="TableTitles" width="10%" align="center"><strong>Status</strong></td>
  </tr>
<cfoutput query = "qryTickets" maxrows="8">
  <tr>
    <td width="25%">#dateformat(datesubmitted, "mm/dd/yyyy")#</td>
    <td><a href = "index.cfm?action=tickets.view&ticketid=#ticketid#&carttoken=#carttoken#">#ticketid#</a> <cfif nextaction IS 'Waiting for reply'><b>updated!</b></cfif></td>
    <td align="center">#status#</td>
  </tr>
</cfoutput>
<cfif qryTickets.recordcount IS 0>
  <tr>
    <td colspan="3">You have no recent support tickets</td>
  </tr>
</cfif>
</table>








