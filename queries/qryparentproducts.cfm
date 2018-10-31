<cfquery name = "qryParent" datasource="#request.dsn#">
SELECT * FROM products WHERE itemid = <cfqueryparam value="#qryProducts.subof#" cfsqltype="cf_sql_integer">
</cfquery>



