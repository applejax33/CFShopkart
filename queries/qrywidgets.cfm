<cfquery name = "qryWidgetsLeft" datasource="#request.dsn#">
SELECT * FROM widgets WHERE isvisible = <cfqueryparam value="Yes" cfsqltype="cf_sql_varchar"> 
AND widgetposition = <cfqueryparam value="left" cfsqltype="cf_sql_varchar">
AND enabled = <cfqueryparam value="Yes" cfsqltype="cf_sql_varchar">
ORDER BY ordervalue ASC
</cfquery>

<cfquery name = "qryWidgetsRight" datasource="#request.dsn#">
SELECT * FROM widgets WHERE isvisible = <cfqueryparam value="Yes" cfsqltype="cf_sql_varchar"> 
AND widgetposition = <cfqueryparam value="right" cfsqltype="cf_sql_varchar">
AND enabled = <cfqueryparam value="Yes" cfsqltype="cf_sql_varchar">
ORDER BY ordervalue ASC
</cfquery>




