<!---Updates a PO Number with the order number and date--->
<cfquery name = "qryUpdatePONumber" datasource="#request.dsn#">
UPDATE ponumbers
SET ordernumber = '#form.ordernumber#',
dateused = #createodbcdate(TheCurrentDate)#
WHERE po_number = '#form.ponumber#'
</cfquery>