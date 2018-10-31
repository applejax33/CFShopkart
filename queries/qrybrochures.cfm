<cfquery name = "qryBrochures" datasource="#request.dsn#">
SELECT * FROM brochures
<cfif isdefined('url.itemID')>
	WHERE itemid = <cfqueryparam value="#url.itemid#" cfsqltype="cf_sql_integer">
</cfif>
</cfquery>



