<form name="CheckoutForm" id="CheckoutForm" action="index.cfm?action=review" method="POST">	
<table width="100%" border="0" cellpadding="4" cellspacing="0">
     <cfif NOT isdefined('form.login_password') AND NOT ISDEFINED('cookie.custemail')>
      <tr>
        <td align="left" colspan="2"><strong><em>New customers, please enter your email and create a password</em></strong></td>
      </tr>
	 </cfif>
      <tr>
        <td align="left"><b>Email Address:</b></td>
        <td align="left"><cfoutput>
          <cfif qryCustomers.recordcount IS 0>
            <input name="EmailAddress" type="text" id="EmailAddress"  value="#EmailAddress#" size="35" />
            <cfelse>
            <input name="EmailAddress" type="hidden" id="EmailAddress"  value="#EmailAddress#" size="35" />
            #emailaddress#
          </cfif>
          <cfif isdefined('msgEmailAddress')>
            <span class="requiredfields">*</span>
          </cfif>
        </cfoutput></td>
      </tr>
	 <cfif qryCustomers.recordcount IS 0>
        <tr>
          <td colspan="2" align="left">Please create a password below so that you can login to check the status of your order and, if you ever return to our website again, you can use your email address and password to automatically fill in the information below.</td>
        </tr>
        <tr>
          <td align="left"><b>Password:</b></td>
          <td align="left"><cfoutput>
            <input name="CustPassword" type="password" id="CustPassword"  value="" size="35" />
          </cfoutput>
                <cfif isdefined('msgPassword')>
                  <span class="requiredfields">*</span>
                </cfif></td>
        </tr>
        <tr>
          <td align="left"><b>Confirm Password: </b></td>
          <td align="left"><cfoutput>
            <input name="ConfirmPassword" type="password" id="ConfirmPassword"  value="" size="35" />
          </cfoutput></td>
        </tr>
        <tr>
          <td align="left">&nbsp;</td>
          <td align="left">&nbsp;</td>
        </tr>
	  <cfelse>
      <cfoutput>
      
      <input type = "hidden" name = "CustPassword" value = "#custpassword#">
      <input type = "hidden" name = "confirmpassword" value = "#custpassword#">
      </cfoutput>
 	  </cfif>
      <tr>
        <td align="left" colspan="2"><div align="left" style="border-bottom: 1px solid #CCCCCC;">
        <strong><em>Billing Information</em></strong>
        </div></td>
        <td align="left">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2" align="left">The name and address entered here must match what is on your credit card or we will be unable to process your order.</td>
      </tr>
      <tr>
        <td width="30%" align="left"><b>First Name:</b></td>
        <td width="55%" align="left"><b><cfoutput>
          <input name="bill_firstname" type="text" id="bill_firstname" value="#bill_firstname#" size="35">
        </cfoutput>
              <cfif isdefined('msgbill_firstname')>
                <span class="requiredfields">*</span>
              </cfif></td>
      </tr>
      <tr>
        <td align="left"><strong>Last Name:</strong></td>
        <td align="left"><b> <cfoutput>
          <input name="bill_lastname" type="text" id="LastName" value="#bill_lastname#" size="35">
        </cfoutput> </b>
              <cfif isdefined('msgbill_lastname')>
                <span class="requiredfields">*</span>
              </cfif></td>
      </tr>
      <tr>
        <td align="left"><strong>Business Name (If any):</strong></td>
        <td align="left"><b> <cfoutput>
          <input name="bill_company" type="text" id="bill_company" value="#bill_company#" size="35">
        </cfoutput> </b></td>
      </tr>
      <tr>
        <td align="left"><b>Address:</b></td>
        <td align="left"><cfoutput>
          <input type="text" size="35" name="bill_address" value="#bill_address#">
        </cfoutput>
              <cfif isdefined('msgbill_address')>
                <span class="requiredfields">*</span>
              </cfif></td>
      </tr>
      <tr>
        <td align="left"><strong>Address Line 2:</strong></td>
        <td align="left"><cfoutput>
          <input type="text" size="35" name="bill_address2" value="#bill_address2#">
        </cfoutput></td>
      </tr>
      <tr>
        <td align="left"><b>City:</b></td>
        <td align="left"><cfoutput>
          <input name="bill_city" type="text" value="#bill_city#" size="36">
        </cfoutput>
              <cfif isdefined('msgbill_city')>
                <span class="requiredfields">*</span>
              </cfif></td>
      </tr>
      <tr>
        <td align="left"><b>State/Province</b></td>
        <td align="left"><cfif qryStates.recordcount IS 0>
          <cfoutput>
            <input type = "hidden" value="#cust_state#" name="otherstate" />
            <input Name= "bill_state" type = "Text" id="desttate" size="25" value="#cust_state#">
          </cfoutput>
          <cfelse>
          <select name="bill_state" onChange="this.form.ship_state.value = this.value">
            <cfloop query = "qryCountries">
              <cfquery name = "qryGetStates" dbtype="query">
				SELECT * FROM qryStates WHERE country = '#qryCountries.id#'
				</cfquery>
              <cfif NOT qryGetStates.recordcount IS 0>
                <cfoutput>
                  <cfif qryCountries.recordcount GT 1>
                    <option value="N-A"></option>
                    <cfoutput>
                      <option value="N-A" style="background:##FFFFCC;">#Ucase(qryCountries.Country)#</option>
                    </cfoutput>
                  </cfif>
                </cfoutput> <cfoutput query = "qryGetStates">
                  <option value="#qryGetStates.statecode#" <cfif #qryGetStates.statecode# IS #cust_state#>SELECTED</cfif>>#State#</option>
                </cfoutput>
              </cfif>
            </cfloop>
          </select>
          <cfoutput>
            <input type="hidden" name="bill_otherstate" Value="#cust_state#">
          </cfoutput>
          <cfif isdefined('msgbill_state')>
            <span class="requiredfields">*</span>
          </cfif>
        </cfif>
        </td>
      </tr>
      <tr>
        <td align="left"><strong>Country</strong></td>
        <td align="left"><cfif qryCountries.recordcount IS 0>
          <cfoutput>
            <input type = "hidden" name = "bill_othercountry" value="#cust_country#" />
            <input type = "text" name = "bill_country" value="#cust_country#">
          </cfoutput>
          <cfelse>
          <select name="bill_country" onchange="this.form.ship_country.value = this.value">
            <cfloop query = "qrycountries">
              <cfif qrycountries.showthis IS 'Yes'>
                <cfoutput>
                  <option value="#qrycountries.countrycode#" <cfif qryCompanyInfo.DefaultCountry IS #qrycountries.countrycode# OR #cust_country# IS #qryCountries.countrycode#>SELECTED</cfif>>#qrycountries.country#</option>
                </cfoutput>
              </cfif>
            </cfloop>
          </select>
          <cfoutput>
            <input type="hidden" name="bill_othercountry" Value="#cust_country#">
          </cfoutput>
        </cfif>
        </td>
      </tr>
      <tr>
        <td align="left"><b>Postal Code:</b></td>
        <td align="left"><cfoutput>
          <input type="text" name="bill_zip" size="35" Value="#bill_zip#">
        </cfoutput></td>
      </tr>
      <tr>
        <td align="left"><b>Phone Number</b></td>
        <td align="left"><cfoutput>
          <input name="bill_phone" type="text" value="#bill_phone#" size="35">
        </cfoutput></td>
      </tr>
      <tr>
        <td align="left"><b>Additional Comments <br>
          or Special Instructions:</b></td>
        <td align="left"><cfoutput>
          <textarea rows="5" name="Memo" cols="35">#memo#</textarea>
        </cfoutput>
        </td>
  </tr>
  <!---Shipping Info--->
  <cfif askforshipping IS 'Yes'>
    <tr>
     <td colspan="2" align="left" valign="middle"><div align="left" style="border-bottom: 1px solid #CCCCCC;"> 
     <strong><em>Shipping Information</em></strong> (Enter the address where you would like your order shipped)</div>
       </td>
        </tr>
        <tr>
          <td colspan="2" align="center" valign="Middle"><div align="center">
            <input name="SameAsBillingInfo" type="checkbox" id="SameAsBillingInfo" value="SameAsBillingInfo" onClick="this.form.ship_firstname.value = this.form.bill_firstname.value;this.form.ship_lastname.value = this.form.bill_lastname.value;this.form.ship_company.value = this.form.bill_company.value;this.form.ship_address.value = this.form.bill_address.value;this.form.ship_state.value = this.form.bill_state.value;this.form.ship_zip.value = this.form.bill_zip.value;this.form.ship_city.value = this.form.bill_city.value; this.form.ship_country.value = this.form.bill_country.value; this.form.ship_address2.value = this.form.bill_address2.value;this.form.ship_otherstate.value = this.form.bill_otherstate.value;">
            <strong>Check here if same as billing information</strong> </div></td>
        </tr>
        <tr>
          <td width="30%" align="left"><strong>First Name:</strong></td>
          <td align="left"><cfoutput><b>
            <input name="ship_firstname" type="text" id="ship_firstname" size="35" value="#ship_firstname#">
          </b></cfoutput>
                <cfif isdefined('msgship_firstname')>
                  <span class="requiredfields">*</span>
                </cfif>
          </td>
        </tr>
        <tr>
          <td align="left"><strong>Last Name:</strong></td>
          <td align="left"><cfoutput><b>
            <input name="ship_lastname" type="text" id="ship_lastname" size="35" value="#ship_lastname#">
          </b></cfoutput>
                <cfif isdefined('msgship_lastname')>
                  <span class="requiredfields">*</span>
                </cfif></td>
        </tr>
        <tr>
          <td align="left"><strong>Business Name (If any):</strong></td>
          <td align="left"><cfoutput><b>
            <input name="ship_company" type="text" id="ship_company2" size="35" value="#ship_company#">
          </b></cfoutput></td>
        </tr>
        <tr>
          <td align="left"><b>Shipping Address:</b></td>
          <td width="68%" align="left"><cfoutput>
            <input Type="Text" name="ship_address" Size="35"id="ship_address" value="#ship_address#">
          </cfoutput>
                <cfif isdefined('msgship_address')>
                  <span class="requiredfields">*</span>
                </cfif></td>
        </tr>
        <tr>
          <td align="left"><strong>Shipping Address Line 2:</strong></td>
          <td align="left"><cfoutput>
            <input Type="Text" name="ship_address2" Size="35"id="ship_address2" value="#ship_address2#">
          </cfoutput></td>
        </tr>
        <tr>
          <td align="left"><b>City:</b></td>
          <td align="left"><cfoutput>
            <input name="ship_city" type="text" id="ship_city" size="35" value="#ship_city#">
          </cfoutput>
                <cfif isdefined('msgship_city')>
                  <span class="requiredfields">*</span>
                </cfif>
          </td>
        </tr>
        <tr>
          <td align="left"><b>State/Province</b></td>
          <td align="left"><cfif qryStates.recordcount IS 0>
            <cfoutput>
              <input type="hidden" name="ship_otherstate" Value="#ShipState#">
              <input type="text" name="ShipState" value="#ShipState#">
            </cfoutput>
            <cfelse>
            <select name="ship_state" id="ship_state">
              <cfloop query = "qryCountries">
                <cfquery name = "qryGetStates" dbtype="query">
				SELECT * FROM qryStates WHERE country = '#qryCountries.id#'
				</cfquery>
                <cfif NOT qryGetStates.recordcount IS 0>
                  <cfif qryCountries.recordcount GT 1>
                    <option value="N-A"></option>
                    <cfoutput>
                      <option value="N-A">#Ucase(qryCountries.Country)#</option>
                    </cfoutput>
                  </cfif>
                  <cfoutput query = "qryGetStates">
                    <option value="#qryGetStates.statecode#" <cfif #qryGetStates.statecode# IS #cust_shipstate#>SELECTED</cfif>>#State#</option>
                  </cfoutput>
                </cfif>
              </cfloop>
            </select>
            <cfoutput>
              <input type="hidden" name="ship_otherstate" Value="#cust_shipstate#">
            </cfoutput>
          </cfif>
                <cfif isdefined('msgship_state')>
                  <span class="requiredfields">*</span>
                </cfif>
          </td>
        </tr>
        <tr>
          <td align="left"><strong>Country</strong></td>
          <td align="left"><cfif qryCountries.recordcount LT 1>
            <cfoutput>
              <input type="hidden" name = "ship_othercountry" value="#cust_shipcountry#" />
              <input type="text" name="ship_country" value="#cust_shipcountry#" size="25"/>
            </cfoutput>
            <cfelse>
            <select name="ship_country" id="ship_country">
              <cfloop query = "qrycountries">
                <cfif qrycountries.showthis IS 'Yes'>
                  <cfoutput>
                    <option value="#qrycountries.countrycode#" <cfif qryCompanyInfo.DefaultCountry IS #qrycountries.countrycode# OR #cust_shipcountry# IS #qryCountries.countrycode#>SELECTED</cfif>>#qrycountries.country#</option>
                  </cfoutput>
                </cfif>
              </cfloop>
            </select>
            <cfoutput>
              <input type="hidden" name="ship_othercountry" Value="#cust_shipcountry#">
            </cfoutput>
          </cfif>
          </td>
        </tr>
        <tr>
          <td align="left"><b>Postal Code:</b></td>
          <td align="left"><cfoutput>
            <input name="ship_zip" type="text" id="ship_zip" size="35" value="#ship_zip#">
            <cfif isdefined('msgship_zip')>
              <span class="requiredfields">*</span>
            </cfif>
          </cfoutput>
      </td>
    </tr>
  </cfif>
  <!---Payment Methods--->
  <tr>
    <td colspan="2" align="left">
    <div align="left" style="border-bottom: 1px solid #CCCCCC;"> 
    <strong><em>Choose How You Would Like To Pay For Your Order</em></strong>
    <cfif isdefined('msgpayment_method')><span class="requiredfields">*</span></cfif>
    </div>
    </td>
  </tr>
  <tr>
  <td colspan="2">

	<cfinclude template = "frmpaymentmethod.cfm">

  </td>
  </tr>
  <cfif request.checkout_terms IS 'Yes'>
  <tr>
  	<td colspan="2">
  	<input type="checkbox" name="terms" value="yes" /> By checking here you acknowledge that you have read and agree to the <a href="##" onclick="javascript:PopupWin('showterms.cfm');">terms and conditions</a><cfif isdefined('msgterms')><span class="requiredfields">*</span></cfif>
    </td>
 </tr>
 </cfif>
  <tr>
	<td colspan="2">
	<!---start of payment selection table---> 
  <cfoutput><input type = "hidden" name="carttoken" value="#carttoken#" /></cfoutput>
  
	<cfoutput>
	<cfif askforshipping IS 'No'>
	<!---if no shipping address is needed then put some default fields in--->    
    <input type = "hidden" name="ship_firstname" value="#ship_firstname#" />
    <input type = "hidden" name="ship_lastname" value="#ship_lastname#" />
    <input type = "hidden" name="ship_country" value="#cust_shipcountry#" />
    <input type = "hidden" name="ship_zip" value="#ship_zip#"  />
    <input type = "hidden" name="ship_otherstate" Value="#cust_state#">
    <input type = "hidden" name="ship_state" Value="#ship_state#">
    <input type = "hidden" name="ship_address" Value="#ship_address#">        
    <input type = "hidden" name="ship_address2" Value="#ship_address2#">            
    <input type = "hidden" name="ship_city" Value="#ship_city#">
    <input type = "hidden" name="ship_company" Value="#ship_company#">
    </cfif>

	  <input type="hidden" name="askforshipping" value="#askforshipping#" />
	  <input type="hidden" value="#Cart.CustomerOrderNumber#" Name="OrderNumber">
	  <input type="hidden" value="#cart.TotalCartWeight#" Name="TotalCartWeight">
	  <br />
	  </cfoutput>
      <div align="center">
	  <cfoutput><input type = "image" src="#request.ReviewOrder#" name="ReviewOrder" class="ReviewOrderButton" value="Review Order" alt="Review Order" title="Review Order" /></cfoutput>
      </div>
   </td>
  </tr>
  </table>   
</form>