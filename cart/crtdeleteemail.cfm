<!---check that it's in there--->
<cfquery name = "CheckExists" Datasource = "#request.dsn#">
SELECT *
FROM nl_members
WHERE EmailAddress = <cfqueryparam value="#form.EmailAddress#" cfsqltype="cf_sql_varchar">
AND Name = <cfqueryparam value="#form.visitorname#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfif #CheckExists.RecordCount# IS 0>
	Sorry, we could not find an email address and name matching what you have entered.  You have NOT been removed from email list.
<cfelse>
<cfquery name = "actDeleteEmail" datasource ="#request.dsn#">
DELETE FROM nl_members
<cfif isdefined('url.EmailID')>
	WHERE CustomerEmail = <cfqueryparam value="#url.EmailID#" cfsqltype="cf_sql_varchar">
</cfif>
<cfif isdefined('form.emailaddress')>
	WHERE CustomerEmail = <cfqueryparam value="#form.emailaddress#" cfsqltype="cf_sql_varchar"> 
	</cfif>
</cfquery>
<cflocation url="index.cfm?action=EmailRemoved">
</cfif>



