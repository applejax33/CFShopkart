<cfquery name = "qryoptions" datasource="#request.dsn#">
SELECT * 
FROM options 
<cfif ISDEFINED('ThisOptionField')>
	WHERE OptionID = <cfqueryparam value="#ThisOptionField#" cfsqltype="cf_sql_integer">
</cfif>
ORDER BY OrderID asc
</cfquery>





