<script>
function viewterms()
{
	var a = window.open('','','width=640,height=480,scrollbars=1');
	a.document.open("text/html");
	a.document.write(document.getElementById('printpart').innerHTML);
}
</script>

<script>
<!--
function validate_form ()
{
  var valmsg;
	valid = true;
	valmsg = '';

    if ( !(document.affilform.password.value == document.affilform.confirmpassword.value) )
    {
        valmsg = valmsg+'--> The password and confirmation password field do not match!  Please retype your password. #request.bslash#n';
        valid = false;
    }

    if ( !(document.affilform.email.value == document.affilform.confirm_email.value) )
    {
        valmsg = valmsg+'--> The email and confirmation email field do not match!  Please retype your email address. #request.bslash#n';
        valid = false;
    }

    if ( valid == true )
    {
		valid = true;
		return true;
    }

    if ( valid == false )
    {
    valmsg = 'You have some errors! #request.bslash#n' + valmsg;
		alert ( valmsg );
    valid = false;
	return false;
    }
}

//-->
</script>

<cfinclude template = "../queries/qrycountries.cfm">
<cfinclude template = "../queries/qrystates.cfm">

<cfif NOT isdefined('session.aid')>
	<cfset referrer = '0'>
</cfif>

<cfif isdefined('session.aid')>
	<!---Get the referring affiliate (for use if we expand to a multi-level affiliate system--->
	<cfquery name="getreferrer" datasource="#request.dsn#">
	SELECT * From afl_affiliates
	Where Affiliateid = '#session.aid#'
	</cfquery>
	
	<cflock scope="session" timeout="10" type="readonly">
		<cfset referrer = session.aid>
	</cflock>
</cfif>

<TABLE width=100% border=0 align="center" cellPadding=4 cellSpacing=0>
  <TR>
    <TD height=24 align="center" class="AffiliateSignupTitle"><div align="left">
      <h2 align="left">Affiliate Signup</h2>
    </div></TD>
  </TR>
  
  <TR>
    <TD height=16>
	</TD>
  </TR>
  <TR>
    <TD width="100%" valign="top" height="112">
	
<cfform name="affilform" action="index.cfm?action=signupaffiliate" method="post">
<cfoutput><input type = "hidden" name = "REFERREDBY" value = "#session.aid#"></cfoutput>
<div align="center">
<table width="96%" cellpadding="4" cellspacing="0">

<tr>
  <td width="25%" align="right" valign="middle"><div align="left"><strong>Company Name: </strong></div></td>
  <td align="left" valign="top">
  <cfinput type="text" name="Company" size="30" id="company" required="No"></td>
</tr>

<tr>
  <td align="right" valign="middle" class="bluetxtCF11" >
    <div align="left"><strong>First Name:</strong></div></td>
  <td width="64%" align="left" valign="top">
<cfinput type="text" name="firstName" size="30" id="firstName" required="Yes" message="First Name is required!">
<font color="red" size="4">*</font></td></tr>
<tr>
  <td align="right" valign="middle" class="bluetxtCF11" >
    <div align="left"><strong>Last Name:</strong></div></td>
  <td align="left" valign="top">
<cfinput type="text" name="lastName" size="30" required="yes" message="Last Name is Required!">
<font color="red" size="4">*</font></td></tr>

<tr>
  <td align="right" valign="middle" class="bluetxtCF11" >
    <div align="left"><strong>Email Address: </strong></div></td>
  <td align="left" valign="top">
<cfinput type="text" name="email" size="30" required="yes" message="Email address is required.">
<font color="red" size="4">*</font>
<br>
All correspondence will be sent to this email. </td>
</tr>
<tr>
  <td align="right" valign="middle" class="bluetxtCF11" ><div align="left"><strong>Retype Email Address:</strong></div></td>
  <td align="left" valign="top"><cfinput type="text" name="confirm_email" size="30" required="yes" message="Please retype your email address in the email confirmation box.">
    <font color="red" size="4">* </font></td>
</tr>
<tr>
  <td align="right" valign="middle" class="bluetxtCF11" >
    <div align="left"><strong>Phone Number:</strong></div></td>
  <td align="left" valign="top">
<cfinput type="text" name="phone" message="You must enter a phone number" size="25" require="yes">
<font color="red" size="4">*</font></td></tr>
<tr>
  <td align="right" valign="top" class="bluetxtCF11" >
    <div align="left"><strong>Mailing Address: </strong></div></td>
  <td align="left" valign="top">
<cfinput type="text" name="address1" size="30" required="yes" message="You must enter an address!">
<font color="red" size="4">*</font><br>
<cfinput type="text" name="address2" size="30" required="no"></td></tr>
<tr>
  <td align="right" valign="middle" class="bluetxtCF11" >
    <div align="left"><strong>City: </strong></div></td>
  <td align="left" valign="top"><cfinput type="text" name="city" size="25" required="yes" message="Please enter a city.">
<font color="red" size="4">*</font></td></tr>
<tr>
  <td align="right" valign="middle" class="bluetxtCF11" >
    <div align="left"><strong>State:</strong></div></td>
  <td align="left" valign="top"><font color="red" size="4">
  <select name = "State">
      <option value="Other" selected="selected">Other</option>
	<cfoutput query = "qrystates">
      <option>#state#</option>
    </cfoutput>
  </select>
  *</font></td>
</tr>

<tr>
  <td align="right" valign="middle" class="bluetxtCF11" > <div align="left"><strong>Zip Code:
  </strong></div></td>
  <td align="left" valign="top">
<cfinput type="text" name="zip" size="15" required="yes" message="Please enter a zipcode">
<font color="red" size="4">*</font></td></tr>
<tr>
  <td align="right" valign="middle" class="bluetxtCF11">
    <div align="left"><strong>Country:</strong></div></td>
  <td align="left" valign="top">
  <select name = "Country">
    <cfoutput query = "qryCountries">
      <option <cfif countrycode IS request.country>selected="selected"</cfif>>#country#</option>
    </cfoutput>
  </select>  </td></tr>

<tr>
  <td align="right" valign="middle" ><div align="left"><b>Choose a  password:</b> </div></td>
  <td valign="top"><div align="left">
    <cfinput type="password" name="password" size="25" required="yes" message="Please enter a password.">
    <font color="red" size="4">*</font></div></td>
</tr>
<tr>
  <td align="right" valign="middle" ><div align="left"><b>Retype your password</b>: </div></td>
  <td valign="top"><div align="left">
    <cfinput name="confirmpassword" size="25" required="yes" message="Please retype your password to confirm it." type="password" onchange=""> 
    <font color="red" size="4">*</font></div></td>
</tr>
<tr>
  <td align="right" valign="middle" ><div align="left"><strong>Make Checks Payable To:</strong> </div></td>
  <td valign="top"><div align="left">
    <cfinput type="text" name="checkname" size="30" id="checkname" required="Yes" Message="Please specify the who we should make the check out to when a payment is due to you.">
  </div></td>
</tr>
<tr>
  <td align="right" valign="middle" ><cfinput type="checkbox" name="checkbox" value="checkbox" required="Yes" message="You must read and agree to the terms and conditions before proceeding!"></td>
  <td valign="top"><div align="left">I have read and agree to the <a href = "##" onclick="javascript:viewterms();">terms and conditions</a>. </div></td>
</tr>
<tr><td valign="middle" ></td>
<td valign="top">
  <div align="left">
	<cfoutput> <input type = "hidden" name="referredby" value="#referrer#" /></cfoutput>
    <input type="submit" name="SubmitButton" value="Sign Up" onclick="javascript: validate_form();" class="AffiliateSignupButton">
  </div></td></tr>
<tr>
  <td colspan="2" align="center">&nbsp;</td>
</tr>
<tr><td colspan="2">
<font color="red" size="2">* Required Fields</font>
</td></tr></table>
</div>
</cfform></td>
  </tr>
</table>

<script language="javascript">
	document.affilform.firstName.focus();		
</script>

<div id = "printpart" style="display:none;">
	<cfinclude template = "affiliateterms.cfm">
</div>




