<!---Support Ticket System--->
<cfparam name="licenseid" default="free">
<link href="../support.css" rel="stylesheet" type="text/css">

<!---Check the license number and if it's not valid display a message and then abort--->
<cfquery name = "qryLicense" datasource="#request.dsn#">
SELECT * FROM cart_users
WHERE licenseid = '#licenseid#'
</cfquery>

<cfif qryLicense.recordcount IS 0>
<p>&nbsp;</p>
<center>Support System is not available unless you purchase a support license.<br />
You may visit <a href = "http://www.cfshopkart.com/" target="_blank">www.cfshopkart.com</a> to purchase a license.  
<p>
If you are seeing this message and you have purchased a license, it may have expired.</center>
<cfabort>
</cfif>

<cfparam name = "action" default="default">
<cfinclude template = "queries/qrycompanyinfo.cfm">

<cfswitch expression="#action#">
	<cfcase value = "default">
		<cfinclude template = "forms/frmtickets.cfm">	
	</cfcase>
	<cfcase value = "view">
		<cfinclude template = "actions/actreadticket.cfm">	
	</cfcase>
	<cfcase value = "new">
		<cfinclude template = "forms/frmNewTicket.cfm">	
	</cfcase>
	<cfcase value = "send">
		<cfinclude template = "actions/actSendTicket.cfm">	
	</cfcase>			
	<cfcase value = "replytoticket">
		<cfinclude template = "actions/actpostresponse.cfm">	
	</cfcase>
	<cfdefaultcase>
		<cfinclude template = "forms/frmTickets.cfm">	
	</cfdefaultcase>
</cfswitch>



