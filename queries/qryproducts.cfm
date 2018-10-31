<!---this query selects just one product if an itemid is passed in.--->
<cfquery name = "qryproducts" Datasource="#request.dsn#">
SELECT *
FROM products
<cfif ISDEFINED('url.itemid')>WHERE ItemID = <cfqueryparam value="#url.itemid#" cfsqltype="cf_sql_integer"></cfif>
<cfif ISDEFINED('form.itemid')>WHERE ItemID = <cfqueryparam value="#form.itemid#" cfsqltype="cf_sql_integer"></cfif>
<cfif ISDEFINED('TheItemID')>WHERE ItemID = <cfqueryparam value="#Theitemid#" cfsqltype="cf_sql_integer"></cfif>
</cfquery>



