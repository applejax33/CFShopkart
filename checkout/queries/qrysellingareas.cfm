<cfquery name = "qryStates" datasource="#request.dsn#">
SELECT * FROM states
WHERE showthis = <cfqueryparam value="Yes" cfsqltype="cf_sql_varchar">
</cfquery>

<cfquery name = "qryCountries" datasource="#request.dsn#">
SELECT * FROM countries
WHERE showthis = <cfqueryparam value="Yes" cfsqltype="cf_sql_varchar">
</cfquery>







