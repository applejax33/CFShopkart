<!---Called from act_AssignToGroups.cfm, this file queries the currently selected members groups--->
<cfquery name = "qryGroups" datasource="#request.dsn#">
SELECT * FROM afl_groups
</cfquery>








