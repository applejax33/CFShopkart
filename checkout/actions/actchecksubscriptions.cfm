<!---This file is called from the frmFinalize.cfm file and checks to see if this customer signed up for any subscriptions for this order.  If so they are told they did and the accout is set to activated.--->

<cfquery name="qrySubscriptions" datasource="#request.dsn#">
SELECT * FROM customers_subscriptions
WHERE customerid = '#qryOrders.CustomerID#' AND ordernumber = '#qryOrders.OrderNumber#'
</cfquery>
<style type="text/css">
<!--
.style1 {
	color: #FF0000;
	font-weight: bold;
}
-->
</style>


<cfif qrySubscriptions.recordcount GT 0>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td><h3>You have ordered the following subscription(s):</h3></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="4" style="border: 1px #000000 solid;">
  <tr>
    <td class="TableTitles"><strong>Description</strong></td>
    <td width="20%" class="TableTitles"><div align="center"><strong>Signup Date</strong></div></td>
    <td width="20%" class="TableTitles"><div align="center"><strong> Expires On</strong></div></td>
    </tr>
  <cfloop query = "qrySubscriptions">
  
  <!---get info about this subscription--->
  <cfquery name = "qrySubscriptionInfo" datasource="#request.dsn#">
  SELECT * FROM products_subscriptions
  WHERE r_id = '#qrySubscriptions.r_id#'
  </cfquery>
  
  <tr>
    <td><cfoutput>#qrySubscriptionInfo.r_name#</cfoutput></td>
    <td><div align="center"><cfoutput>#dateformat(qrySubscriptions.startdate, "mmm dd, yyyy")#</cfoutput></div></td>
    <td><cfoutput>
      <div align="center"><cfif qrySubscriptions.subscription_length IS 'Never'>Does not expire<cfelse>#dateformat(qrySubscriptions.expiredate, "mmm dd, yyyy")#</cfif></div></cfoutput></td>
    </tr>
  </cfloop>
</table>

<p class="style1">Note: If you navigate away from this page or close this window you can view any subscriptions you ordered by going to your account and clicking the Subscriptions link.</p>

<!---activate subscription if paid is yes--->
<cfif paymentsent IS 'Yes'>
    <cfquery name="qryActivateSubscriptions" datasource="#request.dsn#">
    UPDATE customers_subscriptions
    SET status = 'active'
    WHERE customerid = '#qryOrders.CustomerID#' AND ordernumber = '#qryOrders.OrderNumber#'
    </cfquery>
<cfelse>
	Your subscriptions will not be activated until we have verified receipt of payment.  Thank you!
</cfif>

</cfif>







