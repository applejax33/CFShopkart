<!---This query updates the approval status of egoods purchased.  This is called from frmFinalize.cfm--->
<cfquery name = "UpdateApproval" datasource="#request.dsn#">
	UPDATE Orders
	SET CrtApproved = '#NewList#'
	WHERE OrderNumber = '#OrderNumber#'
</cfquery>







