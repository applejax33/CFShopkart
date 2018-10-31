<cfquery name = "qryStates" datasource="#request.dsn#">
SELECT * FROM states WHERE showthis = <cfqueryparam value="yes" cfsqltype="cf_sql_varchar">
Order By State ASC
</cfquery>
