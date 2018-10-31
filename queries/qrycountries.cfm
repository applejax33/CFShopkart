<cfquery name = "qryCountries" datasource="#request.dsn#">
SELECT * FROM countries WHERE showthis = <cfqueryparam value="yes" cfsqltype="cf_sql_varchar">
ORDER BY country ASC
</cfquery>



