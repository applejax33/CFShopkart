<cfquery name = "qGateway" datasource="#request.dsn#" maxrows="1">
SELECT * FROM cfsk_processors
WHERE use_this = 1
AND p_type = 'gateway'
ORDER BY ordervalue ASC
</cfquery>

<cfquery name = "q3rdParties" datasource="#request.dsn#">
SELECT * FROM cfsk_processors
WHERE use_this = 1
AND p_type = '3rdparty'
ORDER BY ordervalue ASC
</cfquery>
