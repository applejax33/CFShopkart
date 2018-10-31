<cfquery name="qryCustomer" datasource="#request.dsn#">
SELECT * FROM  customerhistory
<cfif ISDEFINED('form.CustomerPassword')>
WHERE CustPassword = <cfqueryparam value="#form.CustomerPassword#" cfsqltype="cf_sql_varchar">
</cfif>
<cfif ISDEFINED('form.CustomerEmail')>
WHERE EmailAddress = <cfqueryparam value="#form.CustomerEmail#" cfsqltype="cf_sql_varchar">
</cfif>
</cfquery>



