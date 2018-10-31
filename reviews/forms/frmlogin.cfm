<CFCOOKIE name="CustEmail" expires="NOW" Value="None">
<CFCOOKIE name="CustPassword" expires="NOW" Value="None">
<CFCOOKIE name="CustomerID" expires="NOW" Value="None">

<link href="controlpanel.css" rel="stylesheet" type="text/css"><h3>Account Login</h3>
  <table width="85%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#000000">
    
    <tr> 
      <td valign="Top" width="50%" class="TableTitles"><strong>Login to your account</strong></td>
    </tr>
    <tr> 
      <td valign="top"> <form <cfoutput>action = "index.cfm?action=myaccount&carttoken=#carttoken#"</cfoutput> method="POST">
          
        <table width="100%" border="0" cellpadding="4" cellspacing="0">
          <tr> 
            <td colspan="3">Please login to your account.</td>
          </tr>
          <tr> 
            <td colspan="3"><font size="1"> 
              <cfif ISDEFINED('url.ErrorCode')>
                <cfif #url.ErrorCode# IS 'WrongUser'>
                </cfif>
              </cfif>
              </font> <cfif ISDEFINED('url.ErrorCode')>
                <cfif #url.ErrorCode# IS 'WrongUser'>
                  <div align="center"><font size="1"><strong><font color="#FF0000">Incorrect 
                    Username or Password.</font></strong></font></div>
                </cfif>
              </cfif> <font color="#FF0000" size="1"></div> </font><font size="1"> 
              <a href="index.cfm?action=ForgotPassword&lastaction=myaccount">Forgot 
            your Password?</a></font> <div align="center"></div></td>
          </tr>
          <tr> 
            <td width="31%"><div align="right">Email Address:</div></td>
            <td colspan="2"> <div align="left"> <font size="1"> 
                <input name="EmailAddress" type="text" id="EmailAddress" size="25">
                </font></div></td>
          </tr>
          <tr> 
            <td><div align="right">Password:</div></td>
            <td colspan="2"> <div align="left"> <font size="1"> 
                <input name="CustPassword" type="password" id="CustPassword" size="15">
                </font></div></td>
          </tr>
        </table>
          <p><strong> 
          <div align="center"> 
          <cfoutput><input type="image" src="#request.LoginButton#" name="LoginButton" Class="LoginButton" value="Login" id="LoginButton" alt="Login" title="Login"></cfoutput>
          </div>
        </form></td>
    </tr>
    <cfif NOT request.enablecreateaccount IS 'No'>
    <tr>
       <td width="50%" valign="Top" class="TableTitles"><strong>Don't have an account?</strong></td>
    </tr>
    <tr>
      <td valign="top"><a href="index.cfm?action=newcustomer">Click here to setup a new account</a></td>
    </tr>
    </cfif>
  </table>
  <p align="center">&nbsp;</p>
  







