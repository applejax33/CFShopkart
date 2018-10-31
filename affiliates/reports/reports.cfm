<link href="../../ControlPanel.css" rel="stylesheet" type="text/css"> 

<cfswitch expression="#request.action#">
	<cfdefaultcase>
		<cfinclude template = "displays/dspTransactions.cfm">
	</cfdefaultcase>
	<cfcase value = "transactions">
		<cfinclude template = "displays/dspTransactions.cfm">
	</cfcase>
	<cfcase value = "subaffiliates">
		<cfinclude template = "displays/dspSubAffiliates.cfm">
	</cfcase>
</cfswitch>