<!---Validates the information entered into the checkout form--->
<cfset URLString = '?'>
<cfset URLString = #UrlString# & '&LastName=#form.Lastname#'>
<cfset URLString = #UrlString# & '&FirstName=#form.FirstName#'>
<cfset URLString = #UrlString# & '&BusinessName=#form.BusinessName#'>
<cfset URLString = #UrlString# & '&Address=#Form.destaddress#'>
<cfset URLString = #UrlString# & '&Address2=#Form.destaddress2#'>
<cfset URLString = #UrlString# & '&City=#Form.destcity#'>
<cfif NOT form.deststate IS 'Other'>
	<cfset URLString = #UrlString# & '&State=#Form.deststate#'>
</cfif>
<cfif form.deststate IS 'Other'>
	<cfset URLString = #UrlString# & '&State=#Form.otherstate#'>
</cfif>
<cfset URLString = #UrlString# & '&OtherState=#Form.otherstate#'>
<cfset URLString = #UrlString# & '&Country=#Form.destCountry#'>
<cfset URLString = #UrlString# & '&ZipCode=#Form.destpostal#'>
<cfset URLString = #UrlString# & '&PhoneNumber=#Form.PhoneNumber#'>
<cfset URLString = #UrlString# & '&memo=#form.memo#'>
<cfset URLString = #UrlString# & '&ShipFirstName=#form.ShipFirstName#'>
<cfset URLString = #UrlString# & '&ShipLastName=#form.ShipLastName#'>
<cfset URLString = #UrlString# & '&ShipBusinessName=#form.ShipBusinessName#'>
<cfset URLString = #UrlString# & '&ShipAddress=#form.ShipAddress#'>
<cfset URLString = #UrlString# & '&ShipAddress2=#form.ShipAddress2#'>
<cfset URLString = #UrlString# & '&ShipCity=#form.ShipCity#'>
<cfif NOT form.ShipState IS 'Other'>
	<cfset URLString = #UrlString# & '&ShipState=#form.ShipState#'>
</cfif>
<cfif form.ShipState IS 'Other'>
	<cfset URLString = #UrlString# & '&ShipState=#form.OtherShipState#'>
</cfif>
<cfset URLString = #UrlString# & '&OtherShipState=#Form.othershipstate#'>
<cfset URLString = #UrlString# & '&ShipZip=#form.ShipZip#'>
<cfset URLString = #UrlString# & '&ShipCountry=#form.ShipCountry#'>
<cfset URLString = #UrlString# & '&EmailAddress=#form.EmailAddress#'>

<cfset ErrorMessage = ''>
<cfset TotalErrors = 0>
<cfset ErrorList = ''>

<!---Billing fields--->
<cfif Len(form.lastname) IS 0>
	<cfset TotalErrors = TotalErrors + 1>
	<cfset ErrorList = ListAppend(ErrorList,'LastName')>
	<cfset ErrorMessage = ErrorMessage & '-> Please enter a last name for the billing address<br>'>
</cfif>

<cfif Len(form.firstname) IS 0>
	<cfset TotalErrors = TotalErrors + 1>
	<cfset ErrorList = ListAppend(ErrorList,'FirstName')>
	<cfset ErrorMessage = ErrorMessage & '-> Please enter a first name for the billing address<br>'>
</cfif>

<cfif Len(form.destaddress) IS 0>
	<cfset TotalErrors = TotalErrors + 1>
	<cfset ErrorList = ListAppend(ErrorList,'destaddress')>
	<cfset ErrorMessage = ErrorMessage & '-> Please enter a billing address<br>'>
</cfif>

<cfif Len(form.destaddress) IS 0>
	<cfset TotalErrors = TotalErrors + 1>
	<cfset ErrorList = ListAppend(ErrorList,'destcity')>
	<cfset ErrorMessage = ErrorMessage & '-> Please enter a city for the billing address<br>'>
</cfif>

<cfif Len(form.destaddress) GT 0 AND Len(form.destaddress) LT 5>
	<cfset TotalErrors = TotalErrors + 1>
	<cfset ErrorList = ListAppend(ErrorList,'destaddress')>
	<cfset ErrorMessage = ErrorMessage & '-> Billing Address must be at least 5 characters<br>'>
</cfif>

<!---Shipping Fields--->
<cfif Len(form.shiplastname) IS 0>
	<cfset TotalErrors = TotalErrors + 1>
	<cfset ErrorList = ListAppend(ErrorList,'ShipLastName')>
	<cfset ErrorMessage = ErrorMessage & '-> Please enter a last name for the shipping address<br>'>
</cfif>

<cfif Len(form.shipfirstname) IS 0>
	<cfset TotalErrors = TotalErrors + 1>
	<cfset ErrorList = ListAppend(ErrorList,'ShipFirstName')>
	<cfset ErrorMessage = ErrorMessage & '-> Please enter a first name for the shipping address<br>'>
</cfif>

<cfif Len(form.shipaddress) IS 0>
	<cfset TotalErrors = TotalErrors + 1>
	<cfset ErrorList = ListAppend(ErrorList,'ShipAddress')>
	<cfset ErrorMessage = ErrorMessage & '-> Please enter an address to ship this order to<br>'>
</cfif>

<cfif Len(form.shipaddress) GT 0 AND Len(form.shipaddress) LT 5>
	<cfset TotalErrors = TotalErrors + 1>
	<cfset ErrorList = ListAppend(ErrorList,'ShipAddress')>
	<cfset ErrorMessage = ErrorMessage & '-> Shipping Address must be at least 5 characters<br>'>
</cfif>

<cfif Len(form.shipcity) IS 0>
	<cfset TotalErrors = TotalErrors + 1>
	<cfset ErrorList = ListAppend(ErrorList,'ShipCity')>
	<cfset ErrorMessage = ErrorMessage & '-> Please enter a city for the shipping address<br>'>
</cfif>

<cfif Len(form.emailaddress) IS 0>
	<cfset TotalErrors = TotalErrors + 1>
	<cfset ErrorList = ListAppend(ErrorList,'EmailAddress')>
	<cfset ErrorMessage = ErrorMessage & '-> Please enter an email address<br>'>
</cfif>

<!---CustPassword and confirm CustPassword--->
<cfif isdefined('form.ChangePassword')>

	<cfif NOT form.oldpwordchk IS form.oldpword>
		<cfset TotalErrors = TotalErrors + 1>
		<cfset ErrorList = ListAppend(ErrorList,'OldPword')>
		<cfset ErrorMessage = ErrorMessage & '-> The CustPassword you entered is not the CustPassword for your account.  Enter your current CustPassword to change it.<br>'>
	</cfif>

	<cfif Len(form.pword) IS 0>
		<cfset TotalErrors = TotalErrors + 1>
		<cfset ErrorList = ListAppend(ErrorList,'pword')>
		<cfset ErrorMessage = ErrorMessage & '-> Please enter a CustPassword<br>'>
	</cfif>
	
	<cfif Len(form.pword) GT 0 AND Len(form.pword) LT 3>
		<cfset TotalErrors = TotalErrors + 1>
		<cfset ErrorList = ListAppend(ErrorList,'pword')>
		<cfset ErrorMessage = ErrorMessage & '-> CustPassword field must be more than 3 characters<br>'>	
	</cfif>
	
	<cfif Len(form.PasswordConfirm) IS 0>
		<cfset TotalErrors = TotalErrors + 1>
		<cfset ErrorList = ListAppend(ErrorList,'PasswordConfirm')>
		<cfset ErrorMessage = ErrorMessage & '-> You must reenter your CustPassword in the confirmation field in order to confirm you entered it correctly<br>'>	
	</cfif>
	
	<cfif NOT form.PasswordConfirm IS form.pword>
		<cfset TotalErrors = TotalErrors + 1>
		<cfset ErrorList = ListAppend(ErrorList,'pword')>
		<cfset ErrorList = ListAppend(ErrorList,'PasswordConfirm')>
		<cfset ErrorMessage = ErrorMessage & '-> The CustPassword field and confirmation CustPassword field do not match<br>'>
	</cfif>
</cfif>	




<cfset URLString = URLString & '&ErrorMessage=#ErrorMessage#&TotalErrors=#TotalErrors#&ErrorList=#ErrorList#&action=CustomerLogin'>

<cfif TotalErrors GT 0>
	<cflocation URL = "index.cfm#URLString#">
</cfif>







