<h3>Account Menu</h3>
<cfinclude template = "../actions/actchecklogin.cfm">
<cfinclude template = "../queries/qrycustomers.cfm">

<p>
<table width="450" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td class="TableTitles" colspan="2"><cfoutput query = "qryCustomers"><strong>Welcome back #firstname#!</strong></cfoutput></td>
  </tr>
<cfoutput>
  <tr>
    <td width="10%"><img src="customers/icons/orders.gif" width="32" height="32"></td>
    <td><a href="index.cfm?action=customers_orders&carttoken=#carttoken#">Past Orders</a></td>
  </tr>
  <tr>
    <td><img src="customers/icons/profile.gif" width="32" height="32"></td>
    <td><a href="index.cfm?action=customers_settings&carttoken=#carttoken#">Edit Account Settings</a></td>
  </tr>
  <tr>
    <td><img src="customers/icons/subscriptions.gif" width="32" height="32"></td>
    <td><a href="index.cfm?action=customers_subscriptions&carttoken=#carttoken#">Manage Subscriptions</a></td>
  </tr>
  <tr>
    <td><img src="customers/icons/support.gif" width="32" height="32" /></td>
    <td><a href="index.cfm?action=tickets.default&amp;carttoken=#carttoken#">Support Tickets</a></td>
  </tr>
  <tr>
    <td><img src="customers/icons/logoff.gif" width="32" height="32"></td>
    <td><a href="index.cfm?action=logout&carttoken=#carttoken#">Log Out</a></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  </cfoutput>
</table>








