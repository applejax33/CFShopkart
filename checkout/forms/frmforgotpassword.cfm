<cfparam name = "lastaction" default="home">

<div align="center">
  <form name="form1" method="post" <cfoutput>action="index.cfm?lastaction=#lastaction#"</cfoutput>>
	<table width="460" border="0" cellspacing="0" cellpadding="4" class="forgotpassword_table">
            <tr> 
              <td colspan="2" class="TableTitles"><strong>Retrieve Password</strong></td>
            </tr>
            <tr>
              <td height="27" colspan="2">Enter your email address 
                in the box provided below. Your password will be sent to your 
              email address.</td>
            </tr>
            <tr> 
              <td width="34%" height="27"><strong>Email Address</strong></td>
              <td width="66%"><input name="EmailAddress" type="text" id="EmailAddress" size="35"></td>
            </tr>
            <tr> 
              <td colspan="2"><div align="center">
			      <input type="hidden" Name="Action" Value="GetPasswordChkOut">
                  <input type="submit" name="Submit" value="Send Password" class="forgotpassword_button">
                </div></td>
            </tr>
       </table>
</form>
</div>









