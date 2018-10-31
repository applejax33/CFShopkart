<!---Determines what state the menu item is in when the page first loads--->
<cfparam name = "MainState" default="Open">
<cfparam name = "CategoriesState" default="Open">
<cfparam name = "ProductsState" default="Open">
<cfparam name = "OptionsState" default="Open">
<cfparam name = "SalesState" default="Open">
<cfparam name = "EmailListState" default="Open">
<cfparam name = "ContentState" default="Open">
<cfparam name = "OrdersState" default="Open">
<cfparam name = "controlpaneloptionsState" default="Open">
<cfparam name = "MessagesState" default="Open">

<cfquery name="qMenu" datasource="#request.dsn#">
SELECT * FROM afl_menu
ORDER BY ordervalue ASC
</cfquery>

<cfif isdefined('request.affiliateid')>
<cfquery name = "qMessages" datasource="#request.dsn#">
SELECT * FROM afl_messages 
WHERE recipient = '#request.affiliateid#' AND wasread = 'No'
</cfquery>
</cfif>

<style>
td {font-size: 10pt; font-family: Arial, Helvetica, sans-serif;}
td a{font-size: 10pt; font-family: Arial, Helvetica, sans-serif;}
.NavTitle {cursor: pointer; height:20px;}
.menucontent {line-height: 24px;}
</style>

&nbsp;<br />
<table width = "200" cellpadding="4" cellspacing="0" class="MainMenu" background="images/menubg.jpg">
<tr class="NavTitle">
    <td width="90%" align="left" background="images/headerbg.jpg" class="NavTitle"><strong> &nbsp;&nbsp;&nbsp;Menu</strong></td>
</tr>
</table>
<span id="Main" <cfif MainState IS 'Closed'>style="display: none;"</cfif>>
  <table width = "200" cellpadding="4" cellspacing="0" border="0" class="NavLinks">
          <td align="left" valign="top" background="images/menucellbg.jpg" bgcolor="#FFFFFF" class="menucontent">
      &raquo; <a href="index.cfm?action=account.edit" >Your Account</a><br>
	  &raquo; <a href="index.cfm?action=account.changepassword">Change Password</a><a href="index.cfm?action=account.funds" ></a>
      <br />
      &raquo; <a href="index.cfm?action=reports.transactions">Earnings Report </a><br />
      &raquo; <a href="index.cfm?action=reports.subaffiliates">Referrals</a><br />
      &raquo; <a href="index.cfm?action=account.sellingtools" >Selling Tools </a><br />
      &raquo; <a href="index.cfm?action=messages.viewmessages" >Messages</a> 
	  <cfif isdefined('request.affiliateid')><cfif qMessages.recordcount GT 0><img src="images/new_msg.gif" border="0"  align="absmiddle" /></cfif></cfif><br />
      <!---&raquo; <a href="index.cfm?action=messages.new" >Send a Message</a><br />
      &raquo; <a href="index.cfm?action=messages.viewsent" >Sent Messages</a><br />--->
      <cfoutput query = "qMenu">
      &raquo; <a href="#link_url#" target="#link_target#">#link_title#</a><br />
	  </cfoutput>
      </td>
</tr>
</table>
</span> 




