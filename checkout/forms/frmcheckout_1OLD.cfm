<!---Display the order form and payment options--->
<cfset ckd = "false">
<cfset ckd1 = "false">
<cfset ckd2 = "false">
<cfset ckd3 = "false">
<h2>Welcome to Checkout</h2>

<cfinclude template = "frmorder.cfm">

<cfparam name = "TotalErrors" default = "0">
<cfparam name = "ErrorList" default="">
<cfparam name = "ErrorCode" default="0">

<cfif isdefined('url.TotalErrors')>
	<cfset TotalErrors = url.TotalErrors>
	<cfset ErrorMessage = url.ErrorMessage>
	<cfset ErrorList = url.ErrorList>
</cfif>

<!---Mark fields that were found to have errors--->

<cfif TotalErrors GT 0>
	<cfloop from = "1" To = "#ListLen(ErrorList)#" index="errorcount">
		<cfset ThisErrorForm = ListGetAt(ErrorList, errorcount)>
		<cfset ThisErrorForm = "msg#ThisErrorForm#">
		<cfset "#ThisErrorForm#" = "true">
	</cfloop>
</cfif>

<cfif processpage IS 'Yes'>

<cfif qryCustomers.recordcount IS 0>
<cfparam name = "EmailAddress" default="">
<cfparam name = "FirstName" default="">
<cfparam name = "LastName" default="">
<cfparam name = "BusinessName" default="">
<cfparam name = "address" default="">
<cfparam name = "address2" default="">
<cfparam name = "City" default="">
<cfparam name = "Country" default="">
<cfparam name = "ZipCode" default="">
<cfparam name = "State" default="">
<cfparam name = "ShipFirstName" default="">
<cfparam name = "shipLastName" default="">
<cfparam name = "PhoneNumber" default="">
<cfparam name = "ShipBusinessName" default="">
<cfparam name = "ShipAddress" default="">
<cfparam name = "ShipAddress2" default="">
<cfparam name = "ShipCity" default="">
<cfparam name = "ShipState" default="">
<cfparam name = "ShipZip" default="">
<cfparam name = "ShipCountry" default="">
<cfparam name = "PaymentMethod" default="CreditCard">
<cfparam name = "CreditCardType" default = "Visa">
<cfparam name = "creditcardnumber" default = "">
<cfparam name = "memo" default = "">
<cfparam name = "ExpMonth" default = "01">
<cfparam name = "ExpYear" default = "">
<cfparam name = "CardCode" default = "">
<cfparam name = "TotalErrors" default = "0">
<cfparam name = "ErrorList" default="">
<cfparam name = "ErrorCode" default="0">
<cfparam name = "PONumber" default="">
<cfset CustState = "Other">
<cfset CustCountry = "United States">
<cfset ShipCustState = "Other">
<cfset ShipCustCountry = "United States">
</cfif>

<cfinclude template = "../queries/qrysellingareas.cfm">

<cfif qryCustomers.recordcount GT 0>
<cfparam name = "EmailAddress" default="#qryCustomers.EmailAddress#">
<cfparam name = "FirstName" default="#qryCustomers.FirstName#">
<cfparam name = "LastName" default="#qryCustomers.LastName#">
<cfparam name = "BusinessName" default="#qryCustomers.BusinessName#">
<cfparam name = "address" default="#qryCustomers.address#">
<cfparam name = "address2" default="#qryCustomers.address2#">
<cfparam name = "City" default="#qryCustomers.city#">
<cfparam name = "Country" default="#qryCustomers.country#">
<cfparam name = "ZipCode" default="#qryCustomers.zipcode#">
<cfparam name = "State" default="#qryCustomers.state#">
<cfparam name = "ShipFirstName" default="#qryCustomers.ShipFirstName#">
<cfparam name = "shipLastName" default="#qryCustomers.ShipLastName#">
<cfparam name = "PhoneNumber" default="#qryCustomers.PhoneNumber#">
<cfparam name = "ShipBusinessName" default="#qryCustomers.ShipbusinessName#">
<cfparam name = "ShipAddress" default="#qryCustomers.ShipAddress#">
<cfparam name = "ShipAddress2" default="#qryCustomers.ShipAddress2#">
<cfparam name = "ShipCity" default="#qryCustomers.ShipCity#">
<cfparam name = "ShipState" default="#qryCustomers.ShipState#">
<cfparam name = "ShipZip" default="#qryCustomers.ShipZip#">
<cfparam name = "ShipCountry" default="#qryCustomers.ShipCountry#">
<cfparam name = "PaymentMethod" default="creditcard">
<cfparam name = "CreditCardType" default = "Visa">
<cfparam name = "creditcardnumber" default = "">
<cfparam name = "memo" default = "">
<cfparam name = "ExpMonth" default = "01">
<cfparam name = "ExpYear" default = "">
<cfparam name = "CardCode" default = "">
<cfparam name = "TotalErrors" default = "0">
<cfparam name = "ErrorList" default="">
<cfparam name = "ErrorCode" default="0">
<cfparam name = "PONumber" default="">
</cfif>
<!---figure out how many payment options are available.  If just one then don't bother displaying it below.	Just set the payment to the default method--->

<cfset CustState = #State#>
<cfset CustCountry = #Country#>
<cfset ShipCustState = #ShipState#>
<cfset ShipCustCountry = #ShipCountry#>	
  
<cfset paymentmethods = 0>
<cfoutput query = "qryCompanyInfo">
	<cfif AcceptCredit IS 'Yes'><cfset paymentmethods = paymentmethods + 1></cfif>
	<cfif AcceptChecks IS 'Yes'><cfset paymentmethods = paymentmethods + 1></cfif>
	<cfif EnablePayPalCheckout IS 'Yes'><cfset paymentmethods = paymentmethods + 1></cfif>
</cfoutput>

<cfif paymentmethods Is 1>
<cfoutput query = "qryCompanyInfo">
	<cfif AcceptCredit IS 'Yes'><cfset PaymentMethod = 'CreditCard'></cfif>
	<cfif AcceptChecks IS 'Yes'><cfset PaymentMethod = 'CheckorMoneyOrder'></cfif>
	<cfif EnablePayPalCheckout IS 'Yes'><cfset PaymentMethod = 'PayPalCheckout'></cfif>
</cfoutput>
</cfif>

<cfoutput query = "qryCompanyInfo">
<cfset ShipType = '#ShippingType#'>
</cfoutput>

<cfoutput query = "qryCustomers" maxrows="1">
<cfset CustState = #State#>
<cfset CustCountry = #Country#>
<cfset ShipCustState = #ShipState#>
<cfset ShipCustCountry = #ShipCountry#>
</cfoutput>


<!---check that state is not abbreviated...if it is, then we need to query the states table and get the abbreviation--->
<cfquery name = "qState" datasource="#request.dsn#">
SELECT * FROM states
WHERE state = '#CustState#'
</cfquery>

<cfif qState.recordcount GT 0>
	<cfset CustState = qState.statecode>
</cfif>

  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="checkout_toptable">
	<cfif TotalErrors GT 0>
	<!--- Errors were found so mark them with javascript then show the errors--->
	
      <tr>
        <td height="25" colspan="2" class="checkout_errorsection"><strong><font color="#FF0000">Please 
          correct the following before proceeding with your order:</font></strong></td>
      </tr>
      <tr> 
        <td height="35" colspan="2" class="checkout_errormessage"><cfoutput><b>#ErrorMessage#</b></cfoutput></td>
      </tr>
      <tr> 
        <td colspan="2" class="checkout_errorfooter"><font color="#FF0000"><b> 
          Fields needing attention are marked with *</b></font></td>
      </tr>
    </cfif>
		<cfif NOT isdefined('cookie.CustEmail')>
		<cfif qryCustomers.recordcount IS 0>
            <tr>
              <td colspan="2" class="checkout_loginformcell">
               <cfform action = "index.cfm?carttoken=#CartToken#" method="POST">
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="checkout_login_outtertable">
                <tr>
                <td>
                <table width="100%" border="0" cellpadding="4" cellspacing="0" class="checkout_logintable">
                  <tr>
                    <td colspan="3" align="left" class="TableTitles">
                    	<strong><em>Quick Checkout for returning customers</em></strong>
                    </td>
                  </tr>
                  <tr> 
                    <td colspan="3" align="left" class="checkout_loginmsg">Login for a faster checkout.</td>
                  </tr>
                  <tr> 
                    <td colspan="3" class="checkout_loginerror">
                      <cfif ErrorCode IS 'WrongUser'>
                        Invalid Username or Password. If you are a new customer fill in 
                        the form below.
                      </cfif>
                      </td>
                  </tr>
                  <tr> 
                    <td width="31%" align="right" class="checkout_logincell">
                    	<b>Email Address:</b></div>
                    </td>
                    <td colspan="2" align="left" class="checkout_logincell"> 
                    <div align="left"> 
                        <cfinput name="Login_EmailAddress" type="text" id="Login_EmailAddress" size="25">
                      </div></td>
                  </tr>
                  <tr> 
                    <td align="right" class="checkout_logincell"><div align="right"><b>Password:</b></div></td>
                    <cfinput type="Hidden" Name="action" value="Login">
                    <td colspan="2" align="left" class="checkout_logincell"> 
                    <div align="left"> 
                        <cfinput name="Login_Password" type="password" id="Login_Password" size="25">
                     </div>
                    </td>
                  </tr>
                </table>
                <div align="center"> 
                   <cfoutput><input type="image" src="#request.LoginButton#" name="LoginButton" Class="LoginButton" value="Login" id="LoginButton" alt="Login" title="Login"></cfoutput>
                </div>
              </cfform>
              <p align="center"><cfoutput><a href="index.cfm?action=ForgotPassword&carttoken=#carttoken#&lastaction=checkout">
              <strong> Forgot your password?</strong></a></font></p></cfoutput></td>
                </td>
                </tr>
                </table>
            </tr>
		</cfif>
        </cfif>
        
		<cfif qryCustomers.recordcount GT 0>
		<tr>
		<td colspan="2" class="checkout_login_welcomemsg">
		<p>
        <center><b>Welcome back, <cfoutput>#qryCustomers.firstname#!</cfoutput></b></center>
        <p>
		</td>
		</tr>
		</cfif>
</table>
<cfform name="CheckoutForm" id="CheckoutForm" action="index.cfm" method="POST">	
  <cfoutput><input type = "hidden" name="carttoken" value="#carttoken#" />
  <input type = "hidden" name="action" value="review" /></cfoutput>
  <table align="center" width="100%" cellpadding="0" cellspacing="0" class="checkout_infotable">
    <tr> 
      <td colspan=2 bordercolor="#000000"><table width="100%" border="0" cellpadding="4" cellspacing="0">
          <tr class="TableTitles"> 
            <td colspan="2" align="left" class="TableTitles"><div align="left"> 
               <strong><em>Login Information</em></strong>
              </div></td>
          </tr>
          <tr>
            <td align="left">&nbsp;</td>
            <td align="left">&nbsp;</td>
          </tr>
          <tr>
            <td align="left"><b>Email Address:</b></td>
            <td align="left"><cfoutput>
              <cfif NOT isdefined('form.login_password') AND NOT ISDEFINED('cookie.custemail')>
              <input name="EmailAddress" type="text" id="EmailAddress"  value="#EmailAddress#" size="35" />
              <cfelse>
              <input name="EmailAddress" type="hidden" id="EmailAddress"  value="#EmailAddress#" size="35" />#emailaddress#
              </cfif>
			  <cfif isdefined('msgEmailAddress')><span class="requiredfields">*</span></cfif>
            </cfoutput></td>
          </tr>
          <cfif NOT isdefined('form.login_password') AND NOT ISDEFINED('cookie.custemail')>
          <tr>
            <td colspan="2" align="left">Please create a password below so that you can login to check the status of your order and, if you ever return to your website again, you can use your email address and password to automatically fill in the information below.</td>
          </tr>
					<tr>
            <td align="left"><b>Password:</b></td>
            <td align="left"><cfoutput>
              <cfinput name="CustPassword" type="password" id="CustPassword"  value="" size="35" /></cfoutput><cfif isdefined('msgPassword')><span class="requiredfields">*</span></cfif></td>
          </tr>
          <tr>
            <td align="left"><b>Confirm Password: </b></td>
            <td align="left"><cfoutput>
              <cfinput name="ConfirmPassword" type="password" id="ConfirmPassword"  value="" size="35" />            </cfoutput></td>
          </tr>
          <tr>
            <td align="left">&nbsp;</td>
            <td align="left">&nbsp;</td>
          </tr>
			</cfif>
					<cfif isdefined('form.login_password')>
						<cfoutput>
						<input type = "hidden" name = "CustPassword" value = "#form.login_password#">
						<input type = "hidden" name = "confirmpassword" value = "#form.login_password#">
						</cfoutput>
					</cfif>
					<cfif NOT ISDEFINED('form.login_password') AND isdefined('cookie.CustPassword')>
						<cfoutput>
						<input type = "hidden" name = "CustPassword" value = "#cookie.CustPassword#">
						<input type = "hidden" name = "confirmpassword" value = "#cookie.CustPassword#">
						</cfoutput>
					</cfif>			
                    <tr>
                      <td align="left" class="TableTitles"><strong><em>Billing Information</em></strong></td>
                      <td align="left" class="TableTitles">&nbsp;</td>
                    </tr>
                    <tr>
                      <td colspan="2" align="left">The name and address entered here must match what is on your credit card or we will be unable to process your order.</td>
                    </tr>
          <tr> 
            <td width="30%" align="left"><b>First Name:</b></td>
            <td width="55%" align="left"><b><cfoutput><cfinput name="FirstName" type="text" id="FirstName" value="#FirstName#" size="35"></cfoutput><cfif isdefined('msgFirstName')><span class="requiredfields">*</span></cfif></td>
          </tr>
          <tr> 
            <td align="left"><strong>Last Name:</strong></td>
            <td align="left"><b> <cfoutput>
                <cfinput name="LastName" type="text" id="LastName" value="#LastName#" size="35">
              </cfoutput> </b><cfif isdefined('msgLastName')><span class="requiredfields">*</span></cfif></td>
          </tr>
          <tr> 
            <td align="left"><strong>Business Name (If any):</strong></td>
            <td align="left"><b> 
              <cfoutput>
                <cfinput name="BusinessName" type="text" id="BusinessName2" value="#BusinessName#" size="35"></cfoutput> 
              </b></td>
          </tr>
          <tr> 
            <td align="left"><b>Address:</b></td>
            <td align="left"><cfoutput> 
              <cfinput type="text" size="35" name="destaddress" value="#Address#">
              </cfoutput> <cfif isdefined('msgdestaddress')><span class="requiredfields">*</span></cfif></td>
          </tr>
          <tr>
            <td align="left"><strong>Address Line 2:</strong></td>
            <td align="left"><cfoutput>
              <cfinput type="text" size="35" name="destaddress2" value="#Address2#"></cfoutput></td>
          </tr>
          <tr> 
            <td align="left"><b>City:</b></td>
            <td align="left"><cfoutput>
              <cfinput name="destcity" type="text" value="#City#" size="36">
              </cfoutput> <cfif isdefined('msgdestcity')><span class="requiredfields">*</span></cfif></td>
          </tr>
          <tr> 
            <td align="left"><b>State/Province</b></td>
            <td align="left"> 
			 <cfif qryStates.recordcount IS 0>
				<cfoutput><input type = "hidden" value="#custstate#" name="otherstate" />
                <input Name= "deststate" type = "Text" id="desttate" size="25" value="#custstate#"></cfoutput>
			 <cfelse>
			 <select name="deststate" onChange="this.form.ShipState.value = this.value">
			 <cfloop query = "qryCountries">
				<cfquery name = "qryGetStates" dbtype="query">
				SELECT * FROM qryStates WHERE country = '#qryCountries.id#'
				</cfquery>
				
				<cfif NOT qryGetStates.recordcount IS 0>
					<cfoutput>
					<cfif qryCountries.recordcount GT 1>
						<option value="N-A"></option>
						<cfoutput><option value="N-A" style="background:##FFFFCC;">#Ucase(qryCountries.Country)#</option></cfoutput>
					</cfif>
					</cfoutput>
					<cfoutput query = "qryGetStates">
						<option value="#qryGetStates.statecode#" <cfif #qryGetStates.statecode# IS #custstate#>SELECTED</cfif>>#State#</option>
					</cfoutput> 
				</cfif>
			</cfloop>
			</select>
			<cfoutput><input type="hidden" name="OtherState" Value="#custstate#"></cfoutput>
			<cfif isdefined('msgdeststate')><span class="requiredfields">*</span></cfif>
            </cfif>			</td>
          </tr>
          <tr> 
            <td align="left"><strong>Country</strong></td>
            <td align="left"> 
			<cfif qryCountries.recordcount IS 0>
				<cfoutput><input type = "hidden" name = "othercountry" value="#custcountry#" />
				<input type = "text" name = "destcountry" value="#custcountry#"></cfoutput>
			<cfelse>
			<select name="destcountry" onchange="this.form.ShipCountry.value = this.value">
			<cfloop query = "qrycountries">
			  <cfif qrycountries.showthis IS 'Yes'>
				<cfoutput><option value="#qrycountries.countrycode#" <cfif qryCompanyInfo.DefaultCountry IS #qrycountries.countrycode# OR #custcountry# IS #qryCountries.countrycode#>SELECTED</cfif>>#qrycountries.country#</option></cfoutput>
			  </cfif>
			</cfloop>
			</select>
			<cfoutput><input type="hidden" name="OtherCountry" Value="#custcountry#"></cfoutput>
			</cfif>			</td>
          </tr>
          <tr> 
            <td align="left"><b>Postal Code:</b></td>
            <td align="left"><cfoutput>
                <cfinput type="text" name="destpostal" size="35" Value="#ZipCode#">
              </cfoutput></td>
          </tr>
          <tr> 
            <td align="left"><b>Phone Number</b></td>
            <td align="left"><cfoutput>
                <cfinput name="PhoneNumber" type="text" value="#PhoneNumber#" size="35">
              </cfoutput></td>
          </tr>
          <tr> 
            <td align="left"><b>Additional Comments <br>
              or Special Instructions:</b></td>
            <td align="left"><cfoutput>
              <textarea rows="5" name="Memo" cols="35">#memo#</textarea></cfoutput></td>
          </tr>
      </table></td>
    </tr>
<!---Shipping Info--->
<cfif askforshipping IS 'Yes'>
	<tr>
		<td valign="top" bordercolor="#000000">
	  	<table width="100%" border="0" cellpadding="4" cellspacing="0">
          <tr> 
            <td colspan="2" align="left" valign="middle" class="TableTitles"><div align="left"> 
                <strong><em>Shipping Information</em></strong>(Where 
            your order will be shipped)</div></td>
		  </tr>
			<tr>
			<td colspan="2" align="center" valign="Middle">
                <div align="center"> 
                  <cfinput name="SameAsBillingInfo" type="checkbox" id="SameAsBillingInfo" value="SameAsBillingInfo" onClick="this.form.ShipFirstName.value = this.form.FirstName.value;this.form.ShipLastName.value = this.form.LastName.value;this.form.ShipBusinessName.value = this.form.BusinessName.value;this.form.ShipAddress.value = this.form.destaddress.value;this.form.ShipState.value = this.form.deststate.value;this.form.ShipZip.value = this.form.destpostal.value;this.form.ShipCity.value = this.form.destcity.value; this.form.ShipCountry.value = this.form.destcountry.value; this.form.ShipAddress2.value = this.form.destaddress2.value;this.form.OtherShipState.value = this.form.OtherState.value;">
                  <strong>Check here if same as billing information</strong>
              </div></td>
          </tr>
          <tr> 
            <td width="30%" align="left"><strong>First Name:</strong></td>
            <td align="left"><cfoutput><b>
                <cfinput name="ShipFirstName" type="text" id="ShipFirstName" size="35" value="#ShipFirstName#">
              </b></cfoutput> <cfif isdefined('msgShipFirstName')><span class="requiredfields">*</span></cfif> </td>
          </tr>
          <tr> 
            <td align="left"><strong>Last Name:</strong></td>
            <td align="left"><cfoutput><b>
                <cfinput name="ShipLastName" type="text" id="ShipLastName" size="35" value="#ShipLastName#">
              </b></cfoutput><cfif isdefined('msgShipLastName')><span class="requiredfields">*</span></cfif></td>
          </tr>
          <tr> 
            <td align="left"><strong>Business Name (If any):</strong></td>
            <td align="left"><cfoutput><b>
                <cfinput name="ShipBusinessName" type="text" id="ShipBusinessName2" size="35" value="#ShipBusinessName#">
              </b></cfoutput></td>
          </tr>
          <tr> 
            <td align="left"><b>Shipping Address:</b></td>
            <td width="68%" align="left"><cfoutput>
                <cfinput Type="Text" name="ShipAddress" Size="35"id="ShipAddress" value="#ShipAddress#">
              </cfoutput><cfif isdefined('msgShipAddress')><span class="requiredfields">*</span></cfif></td>
          </tr>
          <tr>
            <td align="left"><strong>Shipping Address Line 2:</strong></td>
            <td align="left"><cfoutput>
                <cfinput Type="Text" name="ShipAddress2" Size="35"id="ShipAddress2" value="#ShipAddress2#">
              </cfoutput></td>
          </tr>
          <tr> 
            <td align="left"><b>City:</b></td>
            <td align="left"><cfoutput>
                <cfinput name="ShipCity" type="text" id="ShipCity" size="35" value="#ShipCity#"></cfoutput>
				<cfif isdefined('msgShipCity')><span class="requiredfields">*</span></cfif>
            </td>
          </tr>
          <tr> 
            <td align="left"><b>State/Province</b></td>
            <td align="left"> 
			<cfif qryStates.recordcount IS 0>
	               <cfoutput><input type="hidden" name="OtherShipState" Value="#ShipState#">
				   <input type="text" name="ShipState" value="#ShipState#"></cfoutput>
			<cfelse>
			<select name="ShipState" id="ShipState">
			 <cfloop query = "qryCountries">
				<cfquery name = "qryGetStates" dbtype="query">
				SELECT * FROM qryStates WHERE country = '#qryCountries.id#'
				</cfquery>
				
				<cfif NOT qryGetStates.recordcount IS 0>
					<cfif qryCountries.recordcount GT 1>
						<option value="N-A"></option>
						<cfoutput><option value="N-A">#Ucase(qryCountries.Country)#</option></cfoutput>
					</cfif>
					<cfoutput query = "qryGetStates">
						<option value="#qryGetStates.statecode#" <cfif #qryGetStates.statecode# IS #shipstate#>SELECTED</cfif>>#State#</option>
					</cfoutput> 
				</cfif>
			</cfloop>
			</select>
			<cfoutput><input type="hidden" name="OtherShipState" Value="#ShipState#"></cfoutput>
			</cfif> 
			<cfif isdefined('msgShipState')><span class="requiredfields">*</span></cfif>
			</td>
          </tr>
          <tr> 
            <td align="left"><strong>Country</strong></td>
            <td align="left">  
			<cfif qryCountries.recordcount LT 1>
				<cfoutput><input type="hidden" name = "OtherShipCountry" value="#ShipCountry#" />
				<input type="text" name="ShipCountry" value="#ShipCountry#" size="25"/></cfoutput>
			<cfelse>
			<select name="ShipCountry" id="ShipCountry">
			<cfloop query = "qrycountries">
			  <cfif qrycountries.showthis IS 'Yes'>
				<cfoutput><option value="#qrycountries.countrycode#" <cfif qryCompanyInfo.DefaultCountry IS #qrycountries.countrycode# OR #shipcountry# IS #qryCountries.countrycode#>SELECTED</cfif>>#qrycountries.country#</option></cfoutput>
			  </cfif>
			</cfloop>		
			</select> 
			<cfoutput><input type="hidden" name="OtherShipCountry" Value="#ShipCountry#"></cfoutput>
			</cfif>
			</td>
          </tr>
          <tr> 
            <td align="left"><b>Postal Code:</b></td>
            <td align="left"><cfoutput>
                <input name="ShipZip" type="text" id="ShipZip" size="35" value="#Shipzip#"><cfif isdefined('msgShipZip')><span class="requiredfields">*</span></cfif>
              </cfoutput></td>
          </tr>
		</table>
		</td>
	</tr>
</cfif>	
<!---Payment Methods--->
    <tr>
      <td valign="top" colspan=2 bordercolor="#000000">
	  	<table width="100%" border="0" cellpadding="4" cellspacing="0">
          <tr class="TableTitles"> 
            <td colspan="2" align="left" class="TableTitles"><div align="left"> 
                <strong><em>Please select how you will pay for
                  your order</em></strong><span name="msgPaymentMethod" id = "msgPaymentMethod" style="display: None"><span class="requiredfields">*</span></span>
              </div></td>
          </tr>
          <tr> 
            <td colspan="2"> 
			
            <cfif GrandTotal GT 0>
			<cfif #qryCompanyInfo.AcceptCredit# IS 'Yes'>
            <table width="100%" cellpadding="4" cellspacing="0">
            <tr>
            <td width="5%">
			<cfif #PaymentMethod# IS "CreditCard"><cfset ckd="true"><cfelse><cfset ckd="false"></cfif>
                <cfinput type="radio" name="PaymentMethod"  value="CreditCard" checked="#ckd#">
            </td>
            <td align="left">
                  <cfif qrycompanyinfo.paymentgateway is '2checkout'>
                  	<img src="images/checkout/2checkout.gif">
                  </cfif>
                  <cfif qrycompanyinfo.paymentgateway is 'paypal'>
                  	<img src="images/checkout/paypal.gif">
                  </cfif>
                  <cfif NOT qrycompanyinfo.paymentgateway is '2checkout' AND NOT qrycompanyinfo.paymentgateway is 'paypal'>
                  	<img src="images/checkout/majorcccard.gif">
                      <!---if using paypal payments pro they have the options of using their account so display that here
					  so they don't think paypal is not accepted.--->
                      <cfif qryCompanyinfo.paymentgateway IS 'PayPalPaymentsPro'> or <img src="images/checkout/paypal.gif"></cfif>
                  </cfif>
				  <cfif NOT #qryCompanyInfo.PaymentGateway# IS 'PayPal'>
             </td>
             </tr>
             </table>
          </cfif>
			  </cfif>
		    </td>
          </tr>
          <cfif #qryCompanyinfo.AcceptChecks# IS 'Yes'>
          <tr> 
            <td colspan="2" align="left">             
	            <table width="100%" cellpadding="4" cellspacing="0">
	            <tr>
	            <td width="5%">
			  <cfif PaymentMethod IS 'CheckOrMoneyOrder'><cfset ckd1="true"><cfelse><cfset ckd1="false"></cfif>
                <cfinput type="radio" name="PaymentMethod" value="CheckOrMoneyOrder" checked="#ckd1#">
                </td>
                <td>
                <img src="images/checkout/checkmoneyorder.gif">
                </td>
                </tr>
                </table>
              </td>
          </tr>
           </cfif>
		  <cfif NOT #qryCompanyInfo.PaymentGateway# IS 'PayPal' AND NOT qryCompanyinfo.paymentgateway IS 'PayPalIPN'
				  AND NOT qryCompanyinfo.paymentgateway IS 'PayPalPaymentsPro'>
          <cfif #qryCompanyinfo.EnablePayPalCheckout# IS 'Yes'>
          <tr> 
            <td colspan="2" align="left"> 		
            <table width="100%" cellpadding="4" cellspacing="0">
            <tr>
            <td width="5%" align="left">
			<cfif PaymentMethod IS 'PayPalCheckout'><cfset ckd2="true"><cfelse><cfset ckd2="false"></cfif>
                <cfinput type="radio" name="PaymentMethod" value="PayPalCheckout" checked="#ckd2#">
            </td>
            <td align="left">
                <img src="images/checkout/paypal.gif">
            </td>
            </tr>
			</table>
            </td>
          </tr>
          </cfif>
		  </cfif>
          <cfif #qryCompanyinfo.accept_po# IS 'Yes'>
          <tr> 
            <td colspan="2" align="left">             
	            <table width="100%" cellpadding="4" cellspacing="0">
	            <tr>
	            <td width="5%">
                <cfif PaymentMethod IS 'PONumber'><cfset ckd3="true"><cfelse><cfset ckd3="false"></cfif>
                <cfinput type="radio" name="PaymentMethod" value="PONumber" checked="#ckd3#">
                </td>
                <td>PO Number: 
                  <cfoutput><input type = "text" size="20" name="PONumber" value="#ponumber#" /></cfoutput><cfif isdefined('msgPONumber')><span class="requiredfields">*</span></cfif>
                </td>
                </tr>
                </table>
              </td>
          </tr>
            <cfelse>
            <input type = "hidden" name = "PONumber" value="">
           </cfif>          
	    </table>
        
        <cfelse>
         You do not need to select a payment method because your order total is 0.00.
         <input type = "hidden" name="PaymentMethod" value="creditcard" />
         <input type = "hidden" name = "PONumber" value="">
        </cfif>
	</tr>
	<!---Product Updates--->
    <tr>
      <td valign="top" bordercolor="#000000">
        <table width="100%" border="0" cellpadding="4" cellspacing="0">
          <cfif NOT request.ShowGiftCardAtCheckout IS 'No'>
          <tr>
            <td colspan="2" align="left" valign="middle" class="TableTitles"><strong><em>Gift Certifcate or Gift Card </em></strong></td>
          </tr>
          <tr>
            <td height="21" colspan="2" align="left" valign="top"><p>If you have a Gift Card or a Gift Certificate, please enter the code in the box provided below:</p>
              <p>
                Gift Code:
                <input name="GiftCode" type="text" id="GiftCode" size="40" />
              </p>
              <p>&nbsp; </p></td>
          </tr>
          <cfelse>
          	<input name="GiftCode" type="hidden" id="GiftCode" size="40" value="" />
          </cfif>
          <tr> 
            <td colspan="2" align="left" valign="middle" class="TableTitles"><strong><em>Mailing List</em></strong></td>
          </tr>
          <tr> 
            <td height="37" colspan="2" align="left" valign="top"> <cfinput type="checkbox" name="ProductUpdates" value="ProductUpdates" checked> 
              <b> Check here if you would like to be added to our mailing list. Our members receive  announcements, special offers, and other valuable information. There is no extra charge for being on our mailing list.</b></td>
          </tr>
        </table>
		</td>
    </tr>
  </table>


    <p align="center">
	<cfoutput>

	<cfif askforshipping IS 'No'>
	<!---if no shipping address is needed then put some default fields in--->    
    <input type = "hidden" name="shipfirstname" value="#firstname#" />
    <input type = "hidden" name="shiplastname" value="#lastname#" />
    <input type = "hidden" name="shipcountry" value="#custcountry#" />
    <input type = "hidden" name="shipzip" value="#zipcode#"  />
    <input type = "hidden" name="OtherShipState" Value="#custstate#">
    <input type = "hidden" name="ShipState" Value="#state#">
    <input type = "hidden" name="ShipAddress" Value="#address#">        
    <input type = "hidden" name="ShipAddress2" Value="#address2#">            
    <input type = "hidden" name="ShipCity" Value="#city#">
    <input type = "hidden" name="ShipBusinessName" Value="#BusinessName#">
    </cfif>

	  <input type="hidden" name="give_mcomm" value="#give_mcomm#" />
	  <input type="hidden" name="askforshipping" value="#askforshipping#" />
	  <input type="hidden" value="#GrandTotal#" Name="OrderTotal">
	  <input type="hidden" value="#Cart.CustomerOrderNumber#" Name="OrderNumber">
	  <input type="hidden" value="#cart.TotalCartWeight#" Name="TotalCartWeight">
	  <br />
	  </cfoutput>
      <cfoutput><input type = "image" src="#request.ReviewOrder#" name="ReviewOrder" class="ReviewOrderButton" value="Review Order" alt="Review Order" title="Review Order" /></cfoutput>
    </p>
    <p>&nbsp;</p>
</cfform>
</cfif>








