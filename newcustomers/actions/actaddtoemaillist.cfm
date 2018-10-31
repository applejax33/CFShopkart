<!---Add a customers email to the email list if they chose to have it added
during checkout--->

<cfset FullName = '#form.FirstName# #Form.LastName#'>

<cfif isdefined('Form.ProductUpdates')>
<cfquery name = "CheckForDuplicateEmail" Datasource = "#request.dsn#">
SELECT *
FROM nl_members
WHERE emailaddress = <cfqueryparam value="#form.EmailAddress#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfif #CheckForDuplicateEmail.RecordCount# IS 0>
<CFQUERY Name = "AddtoMailingList" Datasource = "#request.dsn#">
INSERT INTO nl_members
(name, emailaddress)
VALUES
(<cfqueryparam value="#FullName#" cfsqltype="cf_sql_varchar">, <cfqueryparam value="#form.EmailAddress#" cfsqltype="cf_sql_varchar">)
</CFQUERY>	 
</cfif>
</cfif>




