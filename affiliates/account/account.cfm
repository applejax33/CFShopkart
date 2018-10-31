<link href="../../ControlPanel.css" rel="stylesheet" type="text/css"> 

<cfswitch expression="#request.action#">
	<cfdefaultcase>
		<cfinclude template = "forms/frmedit.cfm">
	</cfdefaultcase>
	
	<cfcase value="update">
		<cfinclude template = "actions/actupdate.cfm">
	</cfcase>
	<cfcase value="edit">
		<cfinclude template = "forms/frmedit.cfm">
	</cfcase>

	<cfcase value="changepassword">
		<cfinclude template = "forms/frmpassword.cfm">
	</cfcase>
	<cfcase value="updatepassword">
		<cfinclude template = "actions/actchangepassword.cfm">
	</cfcase>

	<cfcase value="banners">
		<cfinclude template = "forms/frmbanners.cfm">
	</cfcase>

	<cfcase value="logout">
		<cfinclude template = "actions/actlogout.cfm">
	</cfcase>

	<cfcase value="sellingtools">
		<cfinclude template = "forms/frmsellingtools.cfm">
	</cfcase>

</cfswitch>