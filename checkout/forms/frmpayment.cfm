<cfparam name = "card_type" default="">
<cfparam name = "card_number" default="">
<cfparam name = "card_expmonth" default="01">
<cfparam name = "card_expyear" default="#dateformat(now(), 'yyyy')#">
<cfparam name = "card_cvs" default="">
<cfparam name = "card_nameoncard" default="">

<cfif GrandTotal GT 0>
	<table border="0" width="100%" cellspacing="0" cellpadding="4" class="payment_innertable">
        <tr> 
          <td colspan="2" Class="TableTitles"><strong>Payment Information:</strong></td>
        </tr>
        <tr> 
          <td width="27%" height="37" align="right" >Credit Card Type:</td>
          <td width="73%" align="left" > <select size="1" name="card_type">
              <cfoutput query = "qryCompanyInfo"> 
                <cfif #VISA# IS 'Yes'>
                  <OPTION VALUE = "VI" <cfif card_type IS 'VISA'>selected</cfif>>Visa</OPTION>
                </cfif>
                <cfif #MASTERCARD# IS 'Yes'>
                  <OPTION VALUE = "MC" <cfif card_type IS 'MASTERCARD'>selected</cfif>>Master Card</OPTION>
                </cfif>
                <cfif #DISCOVER# IS 'Yes'>
                  <Option Value = "DI" <cfif card_type IS 'DISCOVER'>selected</cfif>>Discover Card</Option>
                </cfif>
                <cfif #AMEX# IS 'Yes'>
                  <Option Value = "AM" <cfif card_type IS 'AMEX'>selected</cfif>>American Express</Option>
                </cfif>
                <cfif #JCB# IS 'Yes'>
                  <Option Value = "JC" <cfif card_type IS 'JCB'>selected</cfif>>JCB</Option>
                </cfif>
              </cfoutput> 
          </select></td>
        </tr>
        <tr> 
          <td width="27%" height="38" align="left"><div align="right">Credit Card Number:</div></td>
          <td width="73%" align="left"><cfoutput>
          <input type="text" name="card_number" id="card_number" size="32" VALUE = "#card_number#">
          </cfoutput>
          <cfif isdefined('msgcard_number')>
            <span class="requiredfields">*</span>
          </cfif>
          (Do not enter spaces)
          </td>
        </tr>
        <tr> 
          <td width="27%" height="35" align="left"><div align="right">Credit Card Expiration 
          Date</div></td>
          <td width="73%" align="left">
          <cfoutput>
          <select name="card_expmonth">
              <option value="01" <CFIF card_expmonth IS '01'>SELECTED</cfif>>January</option>
              <option value="02" <CFIF card_expmonth IS '02'>SELECTED</cfif>>February</option>
              <option value="03" <CFIF card_expmonth IS '03'>SELECTED</cfif>>March</option>
              <option value="04" <CFIF card_expmonth IS '04'>SELECTED</cfif>>April</option>
              <option value="05" <CFIF card_expmonth IS '05'>SELECTED</cfif>>May</option>
              <option value="06" <CFIF card_expmonth IS '06'>SELECTED</cfif>>June</option>
              <option value="07" <CFIF card_expmonth IS '07'>SELECTED</cfif>>July</option>
              <option value="08" <CFIF card_expmonth IS '08'>SELECTED</cfif>>August</option>
              <option value="09" <CFIF card_expmonth IS '09'>SELECTED</cfif>>September</option>
              <option value="10" <CFIF card_expmonth IS '10'>SELECTED</cfif>>October</option>
              <option value="11" <CFIF card_expmonth IS '11'>SELECTED</cfif>>November</option>
              <option value="12" <CFIF card_expmonth IS '12'>SELECTED</cfif>>December</option>
            </select>
            </cfoutput>
            <!--_Now build expiration year box based on the current year--->
            <cfoutput> 
              <cfset TodaysDate= Now()>
              <cfset CurrentYear = #DatePart("YYYY", TodaysDate)#>
              <cfset CurrentYearAbr = #DatePart("YYYY", TodaysDate)#>
              <select name="card_expyear">
                <option value="#CurrentYearAbr#" SELECTED>#CurrentYear#</option>
                <cfloop Index="MyCount" From="1" To="20">
                  <cfset YearValue = CurrentYearAbr + MyCount>
                  <cfset YearDisplay = CurrentYear + MyCount>
                  <option value="#YearValue#" <cfif card_expyear IS #YearValue#>SELECTED</cfif>>#YearDisplay#</option>
                </cfloop>
              </select>
          </cfoutput>
          <cfif isdefined('msgExpiresOn')>
            <span class="requiredfields">*</span>
          </cfif>
           </td>
        </tr>
        <tr> 
          <td width="27%" align="left" valign="top"><div align="right">CVS<sup>*</sup></div></td>
          <td width="73%" height="32" align="left"> <cfoutput>
            <input type="text" size="9" name="card_cvs" value = "#card_cvs#"></cfoutput> <cfif isdefined('msgcard_cvs')><span class="requiredfields">*</span>
          </cfif>
            <br> <img src="images/checkout/visa_ccid.jpg" width="154" height="100"> <cfif #request.AMEX# IS 'Yes'>
              <img src="images/checkout/amex_ccid.jpg" width="154" height="100">
            </cfif>
            </td>
        </tr>
        <tr> 
          <td colspan="2" align="left"> <p>*As an added security measure, we ask that you enter 
              an extra 3-4 digit number located on the back of your credit card, 
              on or near the signature panel, called the CVS. 
              <cfif #request.AMEX# IS 'Yes'>
                (American Express customers have a 4 digit CVS located on the 
                front of the card.) 
              </cfif>
          </p></td>
        </tr>
      </table>
	<!---
	<cfif request.AcceptEChecks IS 'Yes'>
	<p>&nbsp;</p>
    <table border="0" width="67%" height="150" cellspacing="0" cellpadding="1">
      <tr> 
        <td height="37" colspan="2" align="left" ><strong>E-Check Payment:</strong></td>
      </tr>
      <tr> 
        <td width="35%" height="37" align="left" ><div align="right">Account Type:</div></td>
        <td width="65%" align="left" > <select name="account_type" size="1" id="select">
            <option value = "NONE" selected>---SELECT ONE---</option>
            <option>Checking</option>
            <option>Savings</option>
          </select></td>
      </tr>
      <tr> 
        <td width="35%" height="38" align="left"><div align="right">Routing Number</div></td>
        <td width="65%" align="left"><input name="account_routing" type="text" id="account_routing2" size="32"></td>
      </tr>
      <tr> 
        <td width="35%" height="35" align="left"><div align="right">Account Number</div></td>
        <td width="65%" align="left"> <cfoutput> 
            <input name="account_number" type="text" id="account_number" size="32">
            <cfset TodaysDate= Now()>
            <cfset CurrentYear = #DatePart("YYYY", TodaysDate)#>
            <cfset CurrentYearAbr = #DatePart("YYYY", TodaysDate)#>
          </cfoutput> </td>
      </tr>
      <tr> 
        <td width="35%" align="left" valign="top"><div align="right">Bank Name</div></td>
        <td width="65%" align="left" valign="top"> <input name="account_bankname" type="text" id="account_bankname" size="32"></td>
      </tr>
      <tr> 
        <td align="left"><div align="right">Name on Account:</div></td>
        <td align="left"><input name="account_name" type="text" id="account_name" size="32"></td>
      </tr>
    </table>
	</cfif> 
	--->
</cfif>
<div>