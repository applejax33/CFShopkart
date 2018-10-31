<!---Display the order form and payment options--->
<cfinclude template = "../actions/actchecklogin.cfm">
<cfquery name="qryemaillist" Datasource="#Request.dsn#">
SELECT * FROM nl_members WHERE EmailAddress = '#cookie.custemail#' 
</cfquery>

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
<cfinclude template = "../queries/qrycustomers.cfm">
<cfinclude template = "../queries/qrycompanyinfo.cfm">

<cfloop query = "qryCustomers">
<cfoutput>
<cfset CustState = #State#>
<cfset CustCountry = #Country#>
<cfset ShipCustState = #ShipState#>
<cfset ShipCustCountry = #ShipCountry#>
<cfset TheCustomerID = #CustomerID#>
</cfoutput>


<form name = "EditCustomerForm" <cfoutput>action="index.cfm?carttoken=#carttoken#&action=customers_updateaccount" </cfoutput>method="POST">
<table width="95%" border="0" align="center" cellpadding="4" cellspacing="0">
<tr>
  <td width="50%"><h2>Account Settings</h2></td>
  <td><div align="right"><cfoutput><a href="index.cfm?action=myaccount&carttoken=#carttoken#">Back to Menu</a></cfoutput></div></td>
</tr>
</table>
<p><cfif isdefined('url.WasUpdated')><font color="#990000">Your account information was saved.</font></cfif></p>

<table width="95%" border="0" align="center" cellpadding="2" cellspacing="0">
<cfif TotalErrors GT 0>
<!--- Errors were found so mark them with javascript then show the errors--->

  <tr bgcolor="#FF0000">
	<td height="25" bgcolor="#FFFFCC" colspan="2"><strong><font color="#990000">Please 
	  correct the following before proceeding with your order:</font></strong></td>
  </tr>
  <tr> 
	<td bgcolor="#FFFFCC" height="35" colspan="2"><cfoutput><b><font size="1">#ErrorMessage#</font></b></cfoutput></td>
  </tr>
  <tr> 
	<td bgcolor="#FFFFCC" colspan="2"><font color="#FF0000" size="1"><b> 
	  Fields needing attention are marked with *</b></font></td>
  </tr>
  </cfif>
</table>
<table align="center" width="95%" border="3" cellpadding="0" cellspacing="0" bordercolor="#000000">
<tr> 
  <td colspan=2 bordercolor="#000000"><table width="100%" border="0" cellpadding="4" cellspacing="0">
	  <tr class="TableTitles"> 
		<td colspan="2" class="TableTitles"><div align="left"> 
			<strong><em>Billing Information</em></strong>
		  </div></td>
	  </tr>
	  <tr> 
		<td width="30%"><b>First Name:</b></td>
		<td width="55%"><b><cfoutput><input name="FirstName" type="text" id="FirstName"  value="#FirstName#" size="35">
		  </cfoutput><span name="msgFirstName" id = "msgFirstName" style="display: None"><font color="#FF0000" size="3"><strong>*</strong></font></span>            </td>
	  </tr>
	  <tr> 
		<td><strong>Last Name:</strong></td>
		<td><b> <cfoutput>
			<input name="LastName" type="text" id="LastName" value="#LastName#" size="35">
		  </cfoutput> </b><span name="msgLastName" id = "msgLastName" style="display: None"><font color="#FF0000" size="3"><strong>*</strong></font></span>            </td>
	  </tr>
	  <tr> 
		<td><strong>Business Name (If any):</strong></td>
		<td><b> 
		  <cfoutput><input name="BusinessName" type="text" id="BusinessName2" value="#BusinessName#" size="35"></cfoutput> 
		  </b></td>
	  </tr>
	  <tr> 
		<td><b>Address:</b></td>
		<td><cfoutput> <input type="text" size="35" name="destaddress" value="#Address#">
		  </cfoutput> <span name="msgdestaddress" id = "msgdestaddress" style="display: None"><font color="#FF0000" size="3"><strong>*</strong></font></span></td>
	  </tr>
	  <tr>
		<td><strong>Address Line 2:</strong></td>
		<td><cfoutput><input type="text" size="35" name="destaddress2" value="#Address2#"></cfoutput></td>
	  </tr>
	  <tr> 
		<td><b>City:</b></td>
		<td><cfoutput><input name="destcity" type="text" value="#City#" size="36">
		  </cfoutput> <span name="msgdestcity" id = "msgdestcity" style="display: None"><font color="#FF0000" size="3"><strong>*</strong></font></span></td>
	  </tr>
	  <tr> 
		<td><b>State/Province</b></td>
		<td>
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
		</cfif></td>
	  </tr>
	  <tr> 
		<td><strong>Country</strong></td>
		<td><cfif qryCountries.recordcount IS 0>
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
			</cfif></td>
	  </tr>
	  <tr> 
		<td><b>Postal Code:</b></td>
		<td><cfoutput>
			<input type="text" name="destpostal" size="35" Value="#ZipCode#">
		  </cfoutput></td>
	  </tr>
	  <tr> 
		<td><b>Phone Number</b></td>
		<td><cfoutput>
			<input name="PhoneNumber" type="text" value="#PhoneNumber#" size="35">
		  </cfoutput></td>
	  </tr>
	  <tr> 
		<td><b>Additional Comments <br>
		  or Special Instructions:</b></td>
		<td><textarea rows="5" name="Memo" cols="35"></textarea></td>
	  </tr>
	</table></td>
</tr>
<!---Shipping Info--->
<tr>
	<td valign="top" bordercolor="#000000">
	<table width="100%" border="0" cellpadding="4" cellspacing="0">
	  <tr> 
		<td colspan="2" valign="top" class="TableTitles"><div align="left"> 
			<strong><em>Default Shipping Information</em></strong></div></td>
	  </tr>
		<tr>
		<td colspan="2" valign="Middle">
			<div align="center"> 
			  <input name="SameAsBillingInfo" type="checkbox" id="SameAsBillingInfo" value="SameAsBillingInfo" onClick="this.form.ShipFirstName.value = this.form.FirstName.value;this.form.ShipLastName.value = this.form.LastName.value;this.form.ShipBusinessName.value = this.form.BusinessName.value;this.form.ShipAddress.value = this.form.destaddress.value;this.form.ShipState.value = this.form.deststate.value;this.form.ShipZip.value = this.form.destpostal.value;this.form.ShipCity.value = this.form.destcity.value; this.form.ShipCountry.value = this.form.destcountry.value; this.form.ShipAddress2.value = this.form.destaddress2.value;this.form.OtherShipState.value = this.form.OtherState.value;">
		  <strong>Check here to copy billing information</strong>              </div></td>
	  </tr>
	  <tr> 
		<td width="30%"><strong>First Name:</strong></td>
		<td><b> <cfoutput><b>
			<input name="ShipFirstName" type="text" id="ShipFirstName" size="35" value="#ShipFirstName#">
			</b></cfoutput> <span name="msgShipFirstName" id = "msgShipFirstName" style="display: None"><font color="#FF0000" size="3"><strong>*</strong></font></span> </td>
	  </tr>
	  <tr> 
		<td><strong>Last Name:</strong></td>
		<td><b> <cfoutput><b>
			<input name="ShipLastName" type="text" id="ShipLastName" size="35" value="#ShipLastName#">
			</b></cfoutput><span name="msgShipLastName" id = "msgShipLastName" style="display: None"><font color="#FF0000" size="3"><strong>*</strong></font></span> </td>
	  </tr>
	  <tr> 
		<td><strong>Business Name (If any):</strong></td>
		<td><b> <cfoutput><b>
			<input name="ShipBusinessName" type="text" id="ShipBusinessName2" size="35" value="#ShipBusinessName#">
			</b></cfoutput></td>
	  </tr>
	  <tr> 
		<td><b>Shipping Address:</b></td>
		<td width="68%"><cfoutput>
			<Input Type="Text" name="ShipAddress" Size="35"id="ShipAddress" value="#ShipAddress#">
		  </cfoutput><span name="msgShipAddress" id = "msgShipAddress" style="display: None"><font color="#FF0000" size="3"><strong>*</strong></font></span></td>
	  </tr>
	  <tr>
		<td><strong>Shipping Address Line 2:</strong></td>
		<td><cfoutput>
			<Input Type="Text" name="ShipAddress2" Size="35"id="ShipAddress2" value="#ShipAddress2#">
		  </cfoutput></td>
	  </tr>
	  <tr> 
		<td><b>City:</b></td>
		<td><cfoutput>
			<input name="ShipCity" type="text" id="ShipCity" size="35" value="#ShipCity#"></cfoutput>
			<span name="msgShipCity" id = "msgShipCity" style="display: None"><font color="#FF0000" size="3"><strong>*</strong></font></span>            </td>
	  </tr>
	  <tr> 
		<td><b>State/Province</b></td>
		<td><cfif qryStates.recordcount IS 0>
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
						<option value="#qryGetStates.statecode#" <cfif #qryGetStates.statecode# IS #shipcuststate#>SELECTED</cfif>>#State#</option>
					</cfoutput> 
				</cfif>
			</cfloop>
			</select>
			<cfoutput><input type="hidden" name="OtherShipState" Value="#ShipState#"></cfoutput>
			</cfif> 
			<cfif isdefined('msgShipState')><span class="requiredfields">*</span></cfif></td>
	  </tr>
	  <tr> 
		<td><strong>Country</strong></td>
		<td><cfif qryCountries.recordcount LT 1>
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
			</cfif></td>
	  </tr>
	  <tr> 
		<td><b>Postal Code:</b></td>
		<td><cfoutput>
			<input name="ShipZip" type="text" id="ShipZip2" size="35" value="#Shipzip#">
		  </cfoutput></td>
	  </tr>
	</table>		</td>
</tr>	

<!---Product Updates--->
<tr>
  <td valign="top" bordercolor="#000000">
	<table width="100%" border="0" cellpadding="4" cellspacing="0">
	  <tr> 
		<td class="tabletitles" height="21" colspan="2" valign="top"><strong><em>Product 
		  Updates</em></strong></td>
	  </tr>
	  <tr>
		<td height="37" colspan="2" valign="top"><table width="100%" border="0" cellpadding="1" cellspacing="0">
		  <tr>
			<td colspan="2"><input type="checkbox" name="ProductUpdates" value="ProductUpdates" <cfif NOT qryemaillist.RecordCount IS 0>checked</cfif> />
			  <b> Check here if you would like to receive future product updates 
		and other valuable information.</b></td>
			</tr>
		  <tr>
			<td width="28%"><strong>Email Address : </strong> <cfoutput>
			  <input name="OldEmailAddress" type="hidden" id="OldEmailAddress" value="#EmailAddress#" />
			</cfoutput><span name="msgEmailAddress" id = "msgEmailAddress" style="display: None"><font color="#FF0000" size="3"><strong>*</strong></font></span> <span name="msgpassword" id = "msgpassword" style="display: None"><font color="#FF0000" size="3"><strong>*</strong></font></span></td>
			<td width="72%"><cfoutput>
			  <input name="Email" type="text" id="Email" value="#EmailAddress#" size="35" />
			</cfoutput></td>
		  </tr>
		</table></td>
	  </tr>        
	  <tr> 
		<td height="21" colspan="2" class="tabletitles"><strong><em>Password Change </em></strong></td>
		</tr>
		  <tr>
			<td colspan="2"><input name="ChangePassword" type="checkbox" id="ChangePassword" value="Yes" />
			  <strong>Check here if you want to change your password. </strong></td>
		</tr>
		  <tr>
			<td width="30%"><cfoutput>
			  <strong>Enter your old Password:</strong> <span name="msgOldPword" id = "msgOldPword" style="display: None"><font color="##FF0000" size="3"><strong>*</strong></font></span>
			  <input name="OldPwordchk" type="hidden" id="OldPwordchk" value="#CustPassword#"/>
			</cfoutput></td>
			<td width="70%"><input name="OldPword" type="CustPassword" id="OldPword" value=""/></td>
		  </tr>
		  <tr>
			<td><strong>Change  Password: </strong><span name="msgpword" id = "msgpword" style="display: None"><font color="#FF0000" size="3"><strong>*</strong></font></span></td>
			<td><input name="pword" type="CustPassword" id="pword" /></td>
		  </tr>
		  <tr>
			<td><strong>Confirm newPassword:</strong><span name="msgPasswordConfirm" id = "msgPasswordConfirm" style="display: None"><font color="#FF0000" size="3"><strong>*</strong></font></span></td>
			<td><input name="PasswordConfirm" type="CustPassword" /></td>
		  </tr>
		  <tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		  </tr>
	</table></td>
</tr>
</table>
<p>
  <cfoutput><input type="hidden" value="#customerid#" Name="CustomerID"></cfoutput>
  <center><input type="submit" name="Submit" value="Update Account Information"></center>
</p>
<p>&nbsp;</p>
</form>
</cfloop>


<!---Mark fields that were found to have errors--->

<cfif TotalErrors GT 0>
<cfloop from = "1" To = "#ListLen(ErrorList)#" index="errorcount">
	<cfset ThisErrorForm = ListGetAt(ErrorList, errorcount)>
	<cfset ThisErrorForm = "msg" & ThisErrorForm>
	  <cfoutput>
		<script language="javascript">
			#ThisErrorForm#.style.display = "inline";
		</script>
	  </cfoutput>	
</cfloop>
</cfif>







