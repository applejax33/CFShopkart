<cfquery name = "qryProductOptions" datasource="#request.dsn#">
SELECT * FROM products_options
<cfif isdefined('itemid')>
	WHERE itemid = <cfqueryparam value="#itemid#" cfsqltype="cf_sql_integer">
</cfif>
</cfquery>



