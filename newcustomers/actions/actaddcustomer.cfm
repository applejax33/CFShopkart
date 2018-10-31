<!---Check for duplicate entries:  Keeps from duplicating if they hit refresh--->
<cfquery name = "CheckForDuplicates" datasource="#request.dsn#">
SELECT * FROM customerhistory WHERE EmailAddress = <cfqueryparam value="#form.EmailAddress#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfif CheckForDuplicates.RecordCount IS 0>

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

<CFQUERY Name = "AddACustomer" Datasource = "#request.dsn#">
INSERT INTO customerhistory
(CustPassword, 
FirstName, 
LastName, 
BusinessName, 
Address, 
Address2, 
City, 
State, 
ZipCode, 
Country, 
PhoneNumber, 
EmailAddress,
ShipFirstName, 
ShipLastName, 
ShipBusinessName, 
ShipAddress, 
ShipAddress2, 
ShipCity, 
ShipState, 
ShipZip, 
ShipCountry)
VALUES
(<cfqueryparam value="#form.pword#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#Form.FirstName#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#form.LastName#" cfsqltype="cf_sql_varchar">,
<cfqueryparam value="#form.BusinessName#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#Form.destaddress#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#form.destaddress2#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#Form.destcity#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#TheState#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#Form.destpostal#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#Form.destcountry#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#Form.PhoneNumber#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#form.EmailAddress#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#form.ShipFirstName#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#form.ShipLastName#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#form.ShipBusinessName#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#form.ShipAddress#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#form.ShipAddress2#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#form.ShipCity#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#TheShipState#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#form.ShipZip#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#form.ShipCountry#" cfsqltype="cf_sql_varchar">)
</CFQUERY>

<!---If this person wanted to be added to the mailing list, then add their email address to it--->
<cfinclude template = "actaddtoemaillist.cfm">
</cfif>

<cfsavecontent variable="messagebody">
<cfoutput>
Thank you for establishing an account with us!  Here is your username and Password.  Keep this for you records.
<p>
Username:  #form.EmailAddress#
Password:  #form.pword#
</cfoutput>
</cfsavecontent>

<cfif request.UseMailServer IS 'Yes'>

	<cfif request.UseMailLogin IS 'Yes'>
        <cfmail server="#request.MailServer#"
        username="#request.mailuser#"
        Password="#request.mailpassword#"
        From="#request.EmailAddress#"
        TO="#form.emailaddress#"
        SUBJECT="New Account"
        type="html">
        #messagebody#
        </cfmail>
      <cfelse>
        <cfmail server="#request.MailServer#"
        From="#request.EmailAddress#"
        TO="#form.emailaddress#"
        SUBJECT="New Account"
        type="html">
        #messagebody#
        </cfmail>       
    </cfif>

<cfelse>

	<cfif request.UseMailLogin IS 'Yes'>
        <cfmail username="#request.mailuser#"
        Password="#request.mailpassword#"
        From="#request.EmailAddress#"
        TO="#form.emailaddress#"
        SUBJECT="New Account"
        type="html">
        #messagebody#
        </cfmail>
      <cfelse>
        <cfmail From="#request.EmailAddress#"
        TO="#form.emailaddress#"
        SUBJECT="New Account"
        type="html">
        #messagebody#
        </cfmail>       
    </cfif>

</cfif>

<CFCOOKIE name="CustEmail" expires="1" value="#Form.EmailAddress#">
<CFCOOKIE name="CustPassword" expires="1" value="#Form.Pword#">

<p><b><center>
    You have succesfully created an account. <P>
    Your username and Password were emailed to you for your records. <br>
    <cfoutput><a href="index.cfm?CartToken=#CartToken#">Click here</a></cfoutput> to go back to our homepage to continue 
    shopping.
  </center></b></p>




