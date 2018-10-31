<cfinclude template = "actchecklogin.cfm">
<cfset TheState = form.deststate>

<cfif form.deststate IS 'Other'>
	<cfset TheState = form.OtherState>
<cfelse>
	<cfset TheState = form.deststate>
</cfif>

<cfset TheShipState = form.shipstate>

<cfif form.shipstate IS 'Other'>
	<cfset TheShipState = form.OtherShipState>
<cfelse>
	<cfset TheShipState = form.shipstate>
</cfif>

<CFQUERY Name = "UpdateACustomer" Datasource = #request.dsn#>
UPDATE customerhistory
SET FirstName= <cfqueryparam value="#Form.FirstName#" cfsqltype="cf_sql_varchar">, 
LastName=<cfqueryparam value="#form.LastName#" cfsqltype="cf_sql_varchar">, 
BusinessName=<cfqueryparam value="#form.BusinessName#" cfsqltype="cf_sql_varchar">, 
Address=<cfqueryparam value="#Form.destaddress#" cfsqltype="cf_sql_varchar">, 
Address2=<cfqueryparam value="#form.destaddress2#" cfsqltype="cf_sql_varchar">,
City=<cfqueryparam value="#Form.destcity#" cfsqltype="cf_sql_varchar">, 
State=<cfqueryparam value="#TheState#" cfsqltype="cf_sql_varchar">, 
ZipCode=<cfqueryparam value="#Form.destpostal#" cfsqltype="cf_sql_varchar">, 
Country=<cfqueryparam value="#Form.destcountry#" cfsqltype="cf_sql_varchar">, 
PhoneNumber=<cfqueryparam value="#Form.PhoneNumber#" cfsqltype="cf_sql_varchar">, 
EmailAddress=<cfqueryparam value="#form.Email#" cfsqltype="cf_sql_varchar">, 
ShipFirstName=<cfqueryparam value="#form.ShipFirstName#" cfsqltype="cf_sql_varchar">, 
ShipLastName=<cfqueryparam value="#form.ShipLastName#" cfsqltype="cf_sql_varchar">, 
ShipBusinessName=<cfqueryparam value="#form.ShipBusinessName#" cfsqltype="cf_sql_varchar">, 
ShipAddress=<cfqueryparam value="#form.ShipAddress#" cfsqltype="cf_sql_varchar">, 
ShipAddress2=<cfqueryparam value="#form.ShipAddress2#" cfsqltype="cf_sql_varchar">,
ShipCity=<cfqueryparam value="#form.ShipCity#" cfsqltype="cf_sql_varchar">, 
ShipState=<cfqueryparam value="#TheShipState#" cfsqltype="cf_sql_varchar">, 
ShipZip=<cfqueryparam value="#form.ShipZip#" cfsqltype="cf_sql_varchar">, 
ShipCountry=<cfqueryparam value="#form.ShipCountry#" cfsqltype="cf_sql_varchar">
WHERE CustomerID = <cfqueryparam value="#form.CustomerID#" cfsqltype="cf_sql_integer">
</cfquery>

<!---If their email address has changed and they still want to receive emails, then update
their email address in the email list table--->
<cfif isdefined('form.ProductUpdates') AND NOT form.Email IS form.OldEmailAddress>
<cfquery name = "Updateemaillist" Datasource="#Request.DSN#">
UPDATE nl_members
SET emailaddress = <cfqueryparam value="#form.Email#" cfsqltype="cf_sql_varchar">
WHERE emailaddress = <cfqueryparam value="#form.OldEmailAddress#" cfsqltype="cf_sql_varchar">
</cfquery>
</cfif>
<!---If they don't want to be on the list then just remove the "oldemailaddress" from the database.
The reason for the hidden field is they can change their email if they want and select no.  If they 
changed their email address at the same time, then their new email address won't be added and the
old one will just get removed--->

<cfif NOT isdefined('form.ProductUpdates') AND NOT form.Email IS form.OldEmailAddress>
<cfquery name = "Updateemaillist" Datasource="#Request.DSN#">
DELETE * FROM nl_members
WHERE emailaddress = <cfqueryparam value="#form.OldEmailAddress#" cfsqltype="cf_sql_varchar">
</cfquery>
</cfif>

<!---Now if the email address has not changed and they want to be on the list then add them to it
if they are NOT already on it--->
<cfif isdefined('form.ProductUpdates') AND form.Email IS form.OldEmailAddress>
<cfquery name = "CheckDuplicate" datasource="#Request.dsn#">
SELECT * FROM nl_members
WHERE emailaddress = <cfqueryparam value="#form.OldEmailAddress#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfif CheckDuplicate.RecordCount IS 0>
<cfset FullName = '#form.FirstName# #Form.LastName#'>
<cfquery name = "Updateemaillist" Datasource="#Request.DSN#">
INSERT INTO nl_members
(name, emailaddress, active)
VALUES
(<cfqueryparam value="#FullName#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#form.Email#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="active" cfsqltype="cf_sql_varchar">)
</cfquery>
</cfif>
</cfif>

<!---Now if the email address has changed set the session variable and cookie so they don't get logged out --->
<cfif NOT form.Email IS form.OldEmailAddress>
<cflock scope="Session" type="Exclusive" Timeout="10">
<CFSET session.UserName = #form.Email#>
</cflock>
<CFCOOKIE name="CustEmail" expires="1" value="#form.Email#">
</cfif>

<!---Now see if they want to update their CustPassword.  If so then change the CustPassword to what they entered.  ActValidate.cfm has already checked for form field validation (checked old CustPassword, check pword and confirm pword, etc.).  So update it here--->

<cfif isdefined('form.ChangePassword')>
<CFQUERY Name = "UpdateACustomer" Datasource = #request.dsn#>
UPDATE customerhistory
SET CustPassword = <cfqueryparam value="#form.pword#" cfsqltype="cf_sql_varchar">
WHERE CustomerID = <cfqueryparam value="#form.CustomerID#" cfsqltype="cf_sql_integer">
</cfquery>
	<cflock scope="Session" type="Exclusive" Timeout="10">
		<CFSET session.CustPassword = #form.pword#>
	</cflock>
	<CFCOOKIE name="CustPassword" expires="1" value="#Form.pword#">
</cfif>
<cflocation url = "index.cfm?action=customers_settings&wasupdated=yes">








