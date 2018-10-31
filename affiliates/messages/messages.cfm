<cfswitch expression="#request.action#">
<cfdefaultcase>
	<cfinclude template = "forms/frmMessages.cfm">
</cfdefaultcase>
<cfcase value = "Send">
		<cfinclude template = "actions/actSend.cfm">
</cfcase>
<cfcase value = "New">
	<cfinclude template = "forms/frmNew.cfm">
</cfcase>
<cfcase value = "View">
	<cfinclude template = "forms/frmViewMessage.cfm">
</cfcase>
<cfcase value = "Reply">
	<cfinclude template = "forms/frmReply.cfm">
</cfcase>
<cfcase value = "delete">
	<cfinclude template = "actions/actDelete.cfm">
</cfcase>
<cfcase value = "viewsent">
	<cfinclude template = "forms/frmSentMessages.cfm">
</cfcase>
<cfcase value = "viewsentmessage">
	<cfinclude template = "forms/frmViewSentMessage.cfm">
</cfcase>
</cfswitch>