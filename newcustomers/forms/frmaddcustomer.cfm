<!---Display the order form and payment options--->

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
<cfparam name = "EmailAddress" default="">
<cfparam name = "TotalErrors" default = "0">
<cfparam name = "ErrorList" default="">

<cfinclude template = "../queries/qrysellingareas.cfm">

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

<cfset CustState = #State#>
<cfset CustCountry = #Country#>
<cfset ShipCustState = #ShipState#>
<cfset ShipCustCountry = #ShipCountry#>

<cfform name="form1" action="index.cfm?action=addcustomer&carttoken=#carttoken#" method="post">
<table width="700" border="0" align="center" cellpadding="2" cellspacing="0">
<tr>
	<td>
	  <h2>Use The Form Below To Create a New Account</h2>
    </td>
</tr>
</table>
<table width="700" border="0" align="center" cellpadding="2" cellspacing="0">
  <cfif TotalErrors GT 0>
	<!--- Errors were found so mark them with javascript then show the errors--->
	
      <tr bgcolor="#FF0000">
        <td height="25" bgcolor="#FFFFCC" colspan="2"><strong><font color="#990000">Please 
          correct the following before proceeding with your order:</font></strong></td>
      </tr>
      <tr> 
        <td bgcolor="#FFFFCC" height="35" colspan="2"><cfoutput><b>#ErrorMessage#</b></cfoutput></td>
      </tr>
      <tr> 
        <td bgcolor="#FFFFCC" colspan="2"><font color="#FF0000"><b> 
          Fields needing attention are marked with *</b></font></td>
      </tr>
	  </cfif>
  </table>
  <table align="center" width="700" cellpadding="0" cellspacing="0">
    <tr> 
      <td colspan=2 bordercolor="#000000">
      <table width="100%" border="0" cellpadding="4" cellspacing="0">
          <tr> 
            <td class="TableTitles" colspan="2" align="left"><div align="left"> 
               <strong><em>Billing Information</em></strong>
              </div></td>
          </tr>
          <tr>
            <td align="left"><b>Email Address:</b></td>
            <td align="left"><cfoutput>
              <cfinput name="EmailAddress" type="text" id="EmailAddress"  value="#EmailAddress#" size="35" /><cfif isdefined('msgEmailAddress')><span class="requiredfields">*</span></cfif>
            </cfoutput></td>
          </tr>
          <cfif NOT isdefined('form.login_password') AND NOT ISDEFINED('cookie.custemail')>
          <tr>
            <td colspan="2" align="left">Please create a CustPassword below. You wil use your email address and CustPassword to login to your account.</td>
          </tr>
					<tr>
            <td align="left"><b>Password:</b></td>
            <td align="left">
              <cfinput name="pword" type="password" id="pword" value="" size="35" /><cfif isdefined('msgPassword')><span class="requiredfields">*</span></cfif></td>
          </tr>
          <tr>
            <td align="left"><b>Confirm Password: </b></td>
            <td align="left"><cfoutput>
              <cfinput name="PasswordConfirm" type="password" id="PasswordConfirm" value="" size="35" />
			  </cfoutput></td>
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
            <td width="30%" align="left"><b>First Name:</b></td>
            <td width="55%" align="left"><b><cfoutput>
              <cfinput name="FirstName" type="text" id="FirstName"  value="#FirstName#" size="35"></cfoutput><cfif isdefined('msgFirstName')><span class="requiredfields">*</span></cfif></td>
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
				<cfoutput><option value="#qrycountries.countrycode#" <cfif #custcountry# IS #qryCountries.countrycode#>SELECTED</cfif>>#qrycountries.country#</option></cfoutput>
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
          
        </table></td>
    </tr>
<!---Shipping Info--->
	<tr>
		<td valign="top" bordercolor="#000000">
	  	<table width="100%" border="0" cellpadding="4" cellspacing="0">
          <tr> 
            <td colspan="2" align="left" valign="middle" class="TableTitles"><div align="left"> 
                <strong><em>Shipping Information</em></strong>(Where 
            your orders will be shipped if you order anything)</div></td>
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
				<cfoutput><option value="#qrycountries.countrycode#" <cfif #shipcountry# IS #qryCountries.countrycode#>SELECTED</cfif>>#qrycountries.country#</option></cfoutput>
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
<!---Product Updates--->
    <tr>
      <td valign="top" bordercolor="#000000">
	  	<table width="100%" border="0" cellpadding="4" cellspacing="0">
          <tr> 
            <td class="tabletitles" height="21" colspan="2" valign="top"><em><strong>Product Updates</strong></em></td>
          </tr>
          <tr>
            <td height="37" colspan="2" valign="top"><input type="checkbox" name="ProductUpdates" value="ProductUpdates" checked />
              <b> Check here  to automatically subscribe to the newsletter.</b></td>
          </tr>
      </table></td>
    </tr>
  </table>
</div>
<div align="center">
    <p>
      <input type="hidden" value="AddCustomer" Name="Action">
      <input type="submit" name="Submit" value="Create Account">
    </p>
    <p>&nbsp;</p>
  </div>
</cfform>



