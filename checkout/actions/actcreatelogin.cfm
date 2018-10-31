<!---This file creates a username (email address) and login for checkout--->

<!---Error check--->

<cfif form.EmailAddress IS ''>
	 <cflocation url="index.cfm?errorcode=EmailBlank">	  
</cfif>

<cfif form.CustPassword IS ''>
 	<cflocation url="index.cfm?errorcode=PasswordBlank">	  
</cfif>

<cfif form.ConfirmPassword IS ''>
	 <cflocation url="index.cfm?errorcode=ConfirmBlank">	  
</cfif>


<!---Check the CustPassword and confirmation CustPassword fields to make sure they are the same--->
<cfif NOT form.CustPassword IS form.ConfirmPassword>
 		 <cflocation url="index.cfm?errorcode=ConfirmPassNoMatch">	  
</cfif>

<!---Check to make sure a duplicate is not being entered--->
<cfquery name="CheckDuplicate" Datasource="#request.dsn#">
SELECT * FROM customerhistory
WHERE EmailAddress = '#form.EmailAddress#'
</cfquery>

<cfif CheckDuplicate.RecordCount IS 0>
	<!---If NOT a duplicate then insert the new email address and CustPassword into the database--->
	<CFQUERY Name = "AddACustomer" Datasource = "#request.dsn#">
	INSERT INTO customerhistory
	(EmailAddress, CustPassword)
	VALUES
	('#form.EmailAddress#', '#form.CustPassword#')
	</cfquery>

		<cfoutput>
			<cfset CustEmailAddress = #Form.EmailAddress#>
			<cfset CustPassword = #form.CustPassword#>
		</cfoutput>
</cfif>

<cfif NOT CheckDuplicate.RecordCount IS 0>
 		 <cflocation url="index.cfm?errorcode=EmailInUse">	  
</cfif>

<!---Now get the unique database ID Number for this customer to use when processing the order--->
<cfquery name = "GetCustomerID" Datasource = "#Request.dsn#">
SELECT * FROM customerhistory
WHERE EmailAddress = '#form.EmailAddress#'
</cfquery>

<cfoutput query = "GetCustomerID">
<cfset Cart.CustomerID = #CustomerID#>
</cfoutput>

<cfoutput>
<CFCOOKIE name="CustEmail" expires="1" value="#Form.EmailAddress#">
<CFCOOKIE name="CustPassword" expires="1" value="#Form.CustPassword#">
</cfoutput>







