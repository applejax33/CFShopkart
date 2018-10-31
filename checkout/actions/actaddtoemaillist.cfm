<!---Add a customers email to the email list if they chose to have it added
during checkout--->

<cfset FullName = '#form.bill_firstname# #Form.bill_lastname#'>

<cfif isdefined('Form.ProductUpdates')>
<cfquery name = "CheckForDuplicateEmail" Datasource = "#request.dsn#">
SELECT *
FROM nl_members
WHERE EmailAddress = <cfqueryparam  value="#form.EmailAddress#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfif #CheckForDuplicateEmail.RecordCount# IS 0>
<CFQUERY Name = "AddtoMailingList" Datasource = "#request.dsn#">
INSERT INTO nl_members
(name, emailaddress, active, firstname, lastname)
VALUES
('#FullName#', '#form.EmailAddress#', 'active', '#form.bill_firstname#', '#form.bill_lastname#')
</CFQUERY>	 
</cfif>
</cfif>








