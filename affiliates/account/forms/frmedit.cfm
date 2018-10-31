<cfinclude template = '../queries/qryAccountInfo.cfm'>
<cfinclude template = "../queries/qrycountries.cfm">
<cfinclude template = "../queries/qrystates.cfm">

<cfset SubAffiliateID = qryAccount.SubAffiliateOf>
<cfinclude template = "../queries/qrySubAffiliate.cfm">

<cfoutput query = "qryAccount">

<!---decrypt social security number and then only show the last 4 or show the message that they need to enter their ssn--->
<cfif len(trim(taxid)) IS 0 AND len(trim(pnumber)) IS 0>
	<div style="border: 1px solid ##000000; padding:6px; background: ##FFFFCC;"><font color="##FF0000"><strong>You have not provided a tax identification number yet:</strong></font><br />
    You will not receive payment until you have provided a tax identification number (Social Security Number or EIN for U.S. Residents).  This information is necessary before we can pay out any commissions.<br /></div>
<cfset the_taxid = ''>
    <cfelse>

    <cfset the_taxid = #replace(taxid, "//", "/", "ALL")#>
    <cfset the_taxid = #replace(the_taxid, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")#>
	<cfset the_taxid = #decrypt(the_taxid, request.seedstring)#>
	<cfset the_taxid = "***-**-#right(the_taxid, 4)#">
        	    
</cfif>

<cfif has1099 IS 'No'>
<br />
<div style="border: 1px solid ##000000; padding:6px; background: ##FFFFCC;">
<font color="##FF0000"><strong>You have not sent in your 1099 Form yet</strong></font>
A 1099 form is an IRS tax form used for the purposes of reporting income.  Our records indicate that you have not yet filled out and sent us a 1099 form. 
We require all affiliates to send us a completed 1099 before we can pay out any commissions.  You can find a link to the 1099 form on the menu.
</div>
</cfif>

<TABLE width=100% border=0 align="center" cellPadding=0 cellSpacing=0> 
  <TR>
    <TD width="100%" valign="top" height="112">
<cfform name="form1" action="index.cfm?action=account.update" method="post" enctype="multipart/form-data">
<div align="center">
<table width="96%" cellpadding="5" cellspacing="0">
<tr>
  <td colspan="2" align="left">
    <h3><b>Edit your Account Information below </b>    </h3></td>
</tr>
<tr>
  <td align="right" valign="middle" ><strong>Your Affiliate ID:</strong></td>
  <td align="left" valign="top">#affiliateid#</td>
</tr>
<tr><td width="35%" align="right" valign="middle" >
  <div align="right"><strong>First Name</strong></div></td>
<td width="65%" align="left" valign="top">
  <div align="left">
    <cfinput type="text" name="firstName" size="25" id="firstName" value="#firstname#" required="Yes" message="First name is required">
    <font color="red" size="4">*</font></div></td></tr>
<tr><td align="right" valign="middle" >
  <div align="right"><strong>Last Name</strong></div></td>
<td align="left" valign="top">
  <div align="left">
    <cfinput type="text" name="lastName" value="#lastName#" size="30" required="yes" message="You must enter your last name.">
    <font color="red" size="4">*</font></div></td></tr>

<tr><td align="right" valign="middle" >
  <div align="right"><strong>Email Address </strong></div></td>
<td align="left" valign="top">
  <div align="left">
    <cfinput type="text" name="email" size="30" value="#email#" required="yes" message="Email address is required.">
    <font color="red" size="4">*</font>
    <br>
    All correspondence will be sent to this email. </div></td>
</tr>
<tr><td align="right" valign="middle" >
  <div align="right"><strong>Phone Number</strong></div></td>
<td align="left" valign="top">
  <div align="left">
    <cfinput type="text" name="phone" message="You must enter a phone number" value="#phone#" size="25" require="yes">
    <font color="red" size="4">*</font></div></td></tr>

<tr><td align="right" valign="top" >
  <div align="right"><strong>Mailing Address </strong></div></td>
<td align="left" valign="top">
  <div align="left">
    <cfinput type="text" name="address1" size="30" value="#address1#" required="yes" message="You must enter your address!">
    <font color="red" size="4">*</font><br>
    <cfinput type="text" name="address2" size="30" value="#address2#" required="no">
  </div></td></tr>
<tr><td align="right" valign="middle" >
  <div align="right"><strong>City </strong></div></td>
<td align="left" valign="top">
  <div align="left">
    <cfinput type="text" name="city" size="25" value="#city#" required="yes" message="Please enter a city.">
    <font color="red" size="4">*</font>
    <input type="hidden" name="City_required" value="Missing 'City'">
  </div></td></tr>
<tr><td align="right" valign="middle" >
  <div align="right"><strong>State</strong></div></td>
<td align="left" valign="top">
  <div align="left">
    <select name = "state">
      <option <cfif qryAccount.State IS 'None'>SELECTED</cfif>>None</option>
      <cfloop query = "qryStates">
        <option <cfif qryStates.State IS qryAccount.State>SELECTED</cfif>>#state#</option>
      </cfloop>
    </select>
    <font color="red" size="4">*</font></div></td></tr>
<tr>
  <td align="right" valign="middle" > <div align="right"><strong>Zip  Code
  </strong></div></td>
<td align="left" valign="top">
  <div align="left">
    <cfinput type="text" name="zip" size="15" value="#zip#" required="yes" message="Please enter your zipcode">
    <font color="red" size="4">*</font></div></td></tr>
<tr><td align="right" valign="middle">
  <div align="right"><strong>Country</strong></div></td>
<td align="left" valign="top">
  <div align="left">
    United States</td></tr>
<tr>
  <td align="right" valign="middle" style="font-weight: bold" > <div align="right">SSN / EIN</div></td>
  <td align="left" valign="top">
    <div align="left">
      #the_taxid#
       Change: <cfinput type="text" name="taxId" size="25" value="" mask="999-99-9999">
       <br>
      <em>Required of all U.S. residents for tax reporting purposes.</em></div></td>
</tr>
<tr>
  <td valign="top" ><div align="right" style="font-weight: bold">Contact Hours (Enter hours you can be contacted):</div></td>
  <td valign="top">
      <cfinput type="text" name="contacthours" size="55" value="#contacthours#" required="No" message="Please provide your contact hours."> Example: Mon-Fri 9AM-5PM EST, Sat: 9AM-12PM, Sun: Closed
  </td>
</tr>
<tr>
  <td valign="top" ><div align="right"><strong>Photo:</strong></div></td>
  <td valign="top"><cfif len(trim(photo)) IS 0><img src = "/affiliates/photos/bio_nopic.png" width="80" /><cfelse><img src = "/affiliates/photos/#photo#" width="80" /></cfif><br />
    <input type="file" name="photo" id="photo" /> 
    <input type = "hidden" name="currentphoto" id="currentphoto" value="#photo#" />
    (select a file from your computer to change it)</td>
</tr>
<tr><td valign="top" ></td>
<td valign="top"><div align="left">
  <input type="submit" name="Submit" value="Update Information">
</div></td></tr>
<tr><td colspan="2">
<font color="red" size="2">* Required Fields</font>
</td></tr></table>
</div>
</cfform></td>
  </tr>
</table>
</cfoutput>







