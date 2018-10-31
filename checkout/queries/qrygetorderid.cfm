<!----check to make sure a duplicate order isn't being inserted--->
<cfquery name = "gettempOrder" datasource="#Request.dsn#">
SELECT * FROM temporders
Where OrderID = <cfqueryparam value="#tempOrderID#" cfsqltype="cf_sql_integer">
</cfquery>







