<cfquery name = "qryTickets" datasource="#request.dsn#">
SELECT * FROM support_tickets
<cfif isdefined('url.ticketid')>
	WHERE ticketid = <cfqueryparam value="#url.ticketid#" cfsqltype="cf_sql_varchar">
</cfif>
<cfif NOT isdefined('url.ticketid')>
	WHERE customerid = <cfqueryparam value="#cookie.customerid#" cfsqltype="cf_sql_varchar">
	ORDER BY datesubmitted DESC
</cfif>
</cfquery>








