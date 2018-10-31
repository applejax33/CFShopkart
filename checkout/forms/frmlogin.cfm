<cfform action = "index.cfm?action=myaccount&carttoken=#CartToken#" method="POST" target="_top">
<table width="100%" border="0" cellpadding="4" cellspacing="0" class="checkout_logintable">
  <tr> 
    <td colspan="2" class="checkout_loginerror"><cfif ErrorCode IS 'WrongUser'>Invalid Username or Password.</cfif></td>
  </tr>
  <!---Email Address--->
  <tr>
    <td colspan="2" class="checkout_logincell">Returning customer, enter you email address and password below.  If you are a new password or want to setup a new accoun.
      <div align="left"></div></td>
  </tr>
  <tr> 
    <td width="25%" align="right" class="checkout_logincell">Email Address:</td>
    <td  align="left" class="checkout_logincell"><cfinput name="Login_EmailAddress" type="text" id="Login_EmailAddress" size="25"></td>
  </tr>
  <!---Password--->
  <tr> 
    <td align="right" class="checkout_logincell">Password: </td>               
    <td  align="left" class="checkout_logincell"><cfinput name="Login_Password" type="password" id="Login_Password" size="25"></td>
  </tr>
  <tr>
    <td align="right" class="checkout_logincell">&nbsp;</td>
    <td  align="left" class="checkout_logincell"><cfoutput><input type="image" src="#request.LoginButton#" name="LoginButton" Class="LoginButton" value="Login" id="LoginButton" alt="Login" title="Login" align="absmiddle">&nbsp;&nbsp;&nbsp;&nbsp;<a class="forgot_password_link" href="index.cfm?action=ForgotPassword&carttoken=#carttoken#&lastaction=checkout">Forgot your password?</a></cfoutput></td>
  </tr>
  <tr>
    <td align="right" class="checkout_logincell">&nbsp;</td>
    <td  align="left" class="checkout_logincell">                      
	<cfif ErrorCode IS 'WrongUser'>
    Invalid Username or Password. If you are a new customer fill in the form below.
     </cfif></td>
  </tr>
</table>
<input type = "hidden" value="Yes" name="ischeckingout" id="ischeckingout" />
<div align="center"></div>
</cfform>








