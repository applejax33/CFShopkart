<!---called from actvalidate.cfm; checks to make sure the po number entered is a valid one--->

<cfset waspoerror = 'No'>

<cfquery name = "qryCheckPO" datasource="#request.dsn#">
SELECT * FROM ponumbers
WHERE po_number = '#form.ponumber#'
</cfquery>

<cfif qryCheckPO.recordcount IS 0>
	<cfset waspoerror = 'Yes'>
</cfif>







