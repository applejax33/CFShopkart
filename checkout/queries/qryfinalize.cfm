<!---Called from frmFinalize.cfm:  This file queries the database looking for the customers order information	to display a summary on the final stage of checkout (after payment).  The queries look for either a url variable or a form variable--->

<cfquery name = "QryOrders" datasource = "#Request.DSN#">
SELECT * FROM orders
WHERE OrderNumber = <cfqueryparam value="#OrderNumber#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfquery name = "qryCustomers" datasource = "#Request.DSN#">
SELECT * FROM customerhistory
WHERE CustomerID = <cfqueryparam value="#QryOrders.CustomerID#" cfsqltype="cf_sql_varchar">
</cfquery>







