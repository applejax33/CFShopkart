<cfset URLString = '?action=checkout'>
<cfset URLString = #UrlString# & '&LastName=#form.Lastname#'>
<cfset URLString = #UrlString# & '&FirstName=#form.FirstName#'>
<cfset URLString = #UrlString# & '&BusinessName=#form.BusinessName#'>
<cfset URLString = #UrlString# & '&Address=#Form.destaddress#'>
<cfset URLString = #UrlString# & '&Address2=#Form.destaddress2#'>
<cfset URLString = #UrlString# & '&City=#Form.destcity#'>
<cfset URLString = #UrlString# & '&State=#Form.deststate#'>
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
<cfset URLString = #UrlString# & '&PONumber=#form.PONumber#'>
<cfif NOT form.ship_state IS 'Other'>
	<cfset URLString = #UrlString# & '&ShipState=#form.ship_state#'>
</cfif>
<cfif form.ship_state IS 'Other'>
	<cfset URLString = #UrlString# & '&ShipState=#form.OtherShipState#'>
</cfif>
<cfset URLString = #UrlString# & '&OtherShipState=#Form.othershipstate#'>
<cfset URLString = #UrlString# & '&ShipZip=#form.ship_zip#'>
<cfset URLString = #UrlString# & '&ShipCountry=#form.ship_country#'>
<cfif isdefined('form.PaymentMethod')>
	<cfset URLString = #UrlString# & '&PaymentMethod=#form.PaymentMethod#'>
</cfif>
<cfset URLString = #UrlString# & '&EmailAddress=#form.EmailAddress#'>
<cfset URLString = #UrlString# & '&OrderNumber=#form.OrderNumber#'>

<cfif ISDEFINED('form.CreditCardType')>
<cfset URLString = #UrlString# & '&CreditCardType=#form.CreditCardType#'>
</cfif>


<cfset ErrorMessage = ''>
<cfset TotalErrors = 0>
<cfset ErrorList = ''>

<cfif isdefined('FedexErrorDesc')>
	<cfif FedexErrorDesc IS 'Invalid recipient postal format.'>
		<!---Wrong Format--->
		<cfset TotalErrors = TotalErrors + 1>
		<cfset ErrorList = ListAppend(ErrorList,'ShipZip')>
		<cfset ErrorMessage = ErrorMessage & 'ERROR: It appears that your Postal Code is invalid.  Please try removing any spaces, and check to make sure it is correct.  For US Zip Codes, please make sure it is 5 digits.  Also check to make sure you selected the correct country in the country drop down box.<br>'>
	</cfif>
	<!---Invalid zip or postal code--->
	<cfif FedexErrorDesc IS 'Invalid Destination/Address/PostalCode.'>
		<cfset TotalErrors = TotalErrors + 1>
		<cfset ErrorList = ListAppend(ErrorList,'ShipZip')>
		<cfset ErrorMessage = ErrorMessage & 'ERROR: The postal code or zip code you entered is not valid for the country you selected.  Please make sure you have typed your postal code or zip code correctly, and that you have selected the correct country.'>
	</cfif>	
	<!---Invalid zip or postal code--->
	<cfif FedexErrorDesc IS 'Recipient postal code does not match recipient state/province code.'>
		<cfset TotalErrors = TotalErrors + 1>
		<cfset ErrorList = ListAppend(ErrorList,'ShipZip')>
		<cfset ErrorMessage = ErrorMessage & 'ERROR: The zip/postal code you entered is not valid for the state/province you entered.  Check to make sure you have selected the correct state or province and that the zip/postal code is correct.'>
	</cfif>		
</cfif>

<cfset URLString = URLString & '&ErrorMessage=#ErrorMessage#&TotalErrors=#TotalErrors#&ErrorList=#ErrorList#'>

<cfif TotalErrors GT 0>
	<cflocation URL = "index.cfm#URLString#">
</cfif>


<cfoutput>
ERROR for FEDEX SHIPPING: (#fedexerror#) #FedexErrorDesc# <br />We are sorry, but shipping could not been calculated for this order.  <br />The website owner	will contact you with a shipping quote after the order has been placed.
</cfoutput>







