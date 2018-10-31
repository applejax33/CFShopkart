<cfparam name = "email_address" default="">
<cfparam name = "your_name" default="">
<cfparam name = "Phone_Number_optional" default="">
<cfparam name = "Your_Message_to_Me" default="">
<cfparam name = "Type_of_Message" default="Comment">
<cfparam name = "carttoken" default="null">
<cfparam name = "ErrorType" default="0">

<cfinclude template = "../queries/qrycontactsettings.cfm">

<cfform name="Post_Form" method="post" action="index.cfm?action=contactform_post&carttoken-#carttoken#">
    <span style="display: none;" id="errormsg"><font size="2" color="#ff0000">Please fill in required fields</font></span>
    <table width="100%" cellspacing="0" cellpadding="6" border="0">
        <tbody class="style1">
            <tr>
              <td colspan="2"><font size="4"><strong>Contact Form</strong></font></td>
            <tr>
                <td>Your Name:</td>
                <td><cfinput size="30" type="text" name="Your_Name" required="yes" message="You must provide your name." value="#Your_Name#" />
               <cfoutput><input type="hidden" name="Type_of_Message" id="Type_of_Message" size="30" value="#qryContactSettings.subject_line#"></cfoutput></td>
            </tr>
            <tr>
                <td>Email Address:</td>
                <td><cfinput width="30" type="text" name="Email_Address" required="yes" message="You must at least provide your email address" value="#Email_Address#" /> <cfif errortype IS 'emailaddress'><font color="#FF0000">You must provide a valid email address.</font></cfif></td>
            </tr>
            <tr>
                <td>Phone Number (optional):</td>
                <td><cfinput width="30" type="text" name="Phone_Number_optional" value="#Phone_Number_optional#" /><span id="msgPhone_Number_optional" style="display: none;"><em><font color="#ff0000">*</font></em></span></td>
            </tr>
            <tr>
                <td valign="top">Your Message:</td>
                <td>
                <cfoutput>
                <cftextarea cols="40" rows="10" name="Your_Message_to_Me" required="Yes" message="Please type a message, otherwise what is the point? ;-)">#Your_Message_to_Me#</cftextarea>
                </cfoutput> <p>
                (HTML will be stripped from your message so please enter text only)</td>
            </tr>
          <!---if running coldfusion server 8 or higher and they have captcha enabled, show captcha image and input box--->
          <cfif #left(server.ColdFusion.ProductVersion, 1)# GT 7>
            <cfif qryContactSettings.usecaptcha IS 'yes'>
            <tr>
              <td>&nbsp;</td>
              <td colspan="2">
                    <cfinclude template = 'captcha.cfm'>
              </td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td colspan="2"><label for="captcha">Please enter text in image:</label> <cfinput type="text" name="captcha" id="captcha" value="" required="yes" message="Please enter the characters in the image" /> <cfif errortype IS 'captchaerror'><font color="#FF0000">* Incorrect text was entered.  Please try again.</font></cfif><cfoutput><input type = "hidden" name = "captcha_check" value = "#captcha_check#" /></cfoutput></td>
            </tr>
            </cfif>
           </cfif>
            <tr>
                <td>&nbsp;</td>
                <td colspan="2">
                <input type="submit" value="Send Message" name="SubmitBtn" /></td>
            </tr>
        </tbody>
</table>
</cfform>



