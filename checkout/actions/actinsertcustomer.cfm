<!---If the email address/CustPassword is found then skip the add (prevents duplicate entries)--->
<cfset enc_password = #encrypt(form.CustPassword, request.seedstring)#>
<cfset enc_password = #replace(enc_password, "/", "//", "ALL")#>
<cfset enc_password = #replace(enc_password, "\", "\\", "ALL")#>

<cfquery name = "CheckDuplicates" datasource="#request.dsn#">
SELECT * FROM customerhistory WHERE emailaddress = '#form.emailaddress#' AND CustPassword = '#enc_password#'
</cfquery>

<cfif CheckDuplicates.recordcount IS 0>
	<CFQUERY Name = "AddACustomer" Datasource = "#request.dsn#">
	INSERT INTO customerhistory
	(FirstName, LastName, BusinessName, Address, Address2, City, State, ZipCode, Country, PhoneNumber, EmailAddress, ShipFirstName, ShipLastName, ShipBusinessName, ShipAddress, ShipAddress2, ShipCity, ShipState, ShipZip, ShipCountry, CustPassword)
	VALUES
	('#form.bill_firstname#', '#form.bill_lastname#', '#form.bill_company#', '#form.bill_address#', '#form.bill_address2#', '#form.bill_city#',<cfif bill_state IS 'Other'>'#form.bill_otherstate#',
	<cfelse>'#form.bill_state#',</cfif>'#form.bill_zip#','#form.bill_country#','#form.bill_phone#',
	'#form.EmailAddress#','#form.ship_firstname#','#form.ship_lastname#','#form.ship_company#',
	'#form.ship_address#','#form.ship_address2#','#form.ship_city#',<cfif ship_state IS 'Other'>
	'#form.ship_otherstate#',<cfelse>'#form.ship_state#',</cfif>'#form.ship_zip#','#form.ship_country#', '#enc_password#')
	</CFQUERY>
</cfif>

<!---Get the customers ID number in the db based on email and CustPassword--->
<cfquery name = "qryCustomerID" datasource="#request.dsn#">
SELECT * FROM customerhistory WHERE emailaddress = '#form.emailaddress#' AND CustPassword = '#enc_password#'
</cfquery>

<cfset customerid = qryCustomerID.CustomerID>