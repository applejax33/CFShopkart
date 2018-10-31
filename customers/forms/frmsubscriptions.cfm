<cfinclude template = "../actions/actchecklogin.cfm">
<cfinclude template = "../queries/qrysubscriptions.cfm">
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td><h2>Your Subscriptions</h2></td>
    <td><div align="right"><cfoutput><a href="index.cfm?action=myaccount&carttoken=#carttoken#">Back to Menu</a></cfoutput></div></td>
  </tr>
</table>
<cfif qrySubscriptions.recordcount IS 0>
You are not subscribed to anything at this time.
<cfelse>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td width="15%" class="TableTitles"><strong>Date</strong></td>
    <td width="10%" class="TableTitles"><strong>Status</strong></td>
    <td width="12%" class="TableTitles"><strong>Order</strong></td>
    <td class="TableTitles"><strong>Description</strong></td>
    <td width="10%" class="TableTitles"><div align="center"><strong>Paid</strong></div></td>
    <td width="15%" class="TableTitles"><div align="center"><strong> Expires On</strong></div></td>
  </tr>
  <cfloop query = "qrySubscriptions">
  
  <!---get info about this subscription--->
  <cfquery name = "qrySubscriptionInfo" datasource="#request.dsn#">
  SELECT * FROM products_subscriptions
  WHERE r_id = '#qrySubscriptions.r_id#'
  </cfquery>
  
  <tr>
    <td><cfoutput>#dateformat(startdate, 'mmm dd, yyyy')#</cfoutput></td>
    <td><cfoutput>#status#</cfoutput></td>
    <td><cfoutput>
    <cfif NOT ordernumber IS 'none'>
    <a href = "index.cfm?action=customers_vieworder&OrderNumber=#ordernumber#&CustomerID=#customerid#&carttoken=#carttoken#">
    #ordernumber#
	</a>
	<cfelse>
    #ordernumber#
    </cfif>
	</cfoutput></td>
    <td><cfoutput>#qrySubscriptionInfo.r_name#</cfoutput></td>
    <td><cfoutput>#qrySubscriptionInfo.r_startupfee#</cfoutput></td>
    <td><div align="center"><cfoutput>#dateformat(expiredate, 'mmm dd, yyyy')#</cfoutput></div></td>
  </tr>
  </cfloop>
</table>
<p>If you would like to cancel a subscription, please open a support ticket and submit a request.</p>
</cfif>








