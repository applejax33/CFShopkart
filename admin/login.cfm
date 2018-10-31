<cfparam name = "login_failed" default="false">
<cfparam name = "error_msg" default="Incorrect Username or Password">

<cfinclude template = "queries/qryversion.cfm">

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Store Control Panel Login</title>

<!---captcha function--->
<cfinvoke component="functions.captcha" method="create" returnvariable="strCaptcha"></cfinvoke>
<cfset captcha_check = Encrypt(strCaptcha, request.seedstring, "CFMX_COMPAT", "HEX") />

<!---If they are not coming from a mobile device relocate to the /mini folder--->

<cfif CGI.HTTP_USER_AGENT CONTAINS 'iphone' OR CGI.HTTP_USER_AGENT CONTAINS 'Windows CE' OR CGI.HTTP_USER_AGENT CONTAINS 'NetFront' OR CGI.HTTP_USER_AGENT CONTAINS 'Palm OS' OR CGI.HTTP_USER_AGENT CONTAINS 'Blazer' OR CGI.HTTP_USER_AGENT CONTAINS 'Elaine' OR CGI.HTTP_USER_AGENT CONTAINS 'WAP' OR CGI.HTTP_USER_AGENT CONTAINS 'Plucker' OR CGI.HTTP_USER_AGENT CONTAINS 'Avantgo'>
	<cflocation url = "#request.homeURL#/mini_admin/">
</cfif>
<script language="JavaScript"  type="text/javascript">
	function BreakOutOfFrame() {
		if (top.location != location) {
			top.location.href = document.location.href ;
		}
	}
</script>

<style type="text/css">
<!--
.login_title {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 16px;
	font-weight: bold;
	color: #006699;
}
.login_labels {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	font-weight: bold;
	color: #000000;
}
.login_input {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	font-weight: bold;
	color: #666666;
	background-image: url(images/input_bg.gif);
	background-repeat: no-repeat;
	background-position: left top;
}
.login_dropdown {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	font-weight: normal;
	color: #333333;
}
.login_button {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: bold;
	height: 25px;
	color: #000000;
	background-image: url(images/input_bg.gif);
	background-repeat: no-repeat;
	background-position: left top;
	cursor: pointer;
}
.bottom_info {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	color: #FFFFFF;
}
.login_failure {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	font-weight: bold;
	color: #FF0000;
}
-->
</style>
<link href="controlpanel.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#d2ddf1" background="images/login_bg.jpg" style="background-repeat: repeat-x" text="#000000" onLoad="BreakOutOfFrame();" marginheight="0"
topmargin="0">
<form target="_top" method="POST" action="admin.cfm" name="loginform">
  <p><br>
  &nbsp;</p>
  <p><br>
  </p>
  <table width="422" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td height="262" valign="top" style="background:#FFFFFF; border: #000000 solid 2px;"><table width="350" border="0" align="center" cellpadding="4" cellspacing="0">
        <tr>
          <td height="30" colspan="2" valign="top"><div align="center" class="login_title">Please  Login</div></td>
          </tr>
        <tr>
          <td width="100" height="25"><div align="right">Username:</div></td>
          <td><font color="#000000" face="Verdana"><cfoutput>
            <input name="admin_username" type="text" class="login_input" id="admin_username" size="20">
          </cfoutput></font></td>
        </tr>
        <tr>
          <td height="25"><div align="right">Password:</div></td>
          <td><font color="#000000" face="Verdana">
            <input name="admin_password" type="Password" class="login_input" size="20">
          </font></td>
        </tr>
        <tr>
          <td height="25" colspan="2"><div align="center">Enter the text in the image into the box provided</div></td>
          </tr>
        <tr>
          <td height="25"><div align="right">
            <cfoutput><cfimage action="captcha" width="106" height="38" text="#strCaptcha#" fontsize="26" difficulty="low" fonts="verdana,arial,times new roman,courier" color="captcha_image"><input type="hidden" name="captcha_check" value="#captcha_check#"></cfoutput></div>
            </td>
            <td>
           <input name="vcode" type="text" value="" size="8" />&nbsp;<cfoutput><a href = "#request.AdminPath#helpdocs/Captcha_Check.htm" onClick="NewWindow(this.href,'Help','375','450','yes');return false;")>What is this?</a></cfoutput>
           </td>
          </tr>
        <tr>
          <td height="25"><div align="right">
            <input type="checkbox" name="keep_loggedin" id="keep_loggedin">
          </div></td>
          <td><select name="login_remember" class="login_dropdown" id="login_remember">
            <option value="1">Remember For 1 Day</option>
            <option value="2">Remember For 3 Days</option>
            <option value="7">Remember For 1 Week</option>
            <option value="NEVER">Remember Always</option>
          </select>          </td>
        </tr>
        <tr>
          <td height="30" colspan="2" valign="top"><div align="center">
            <input name="EnterButton" type="submit" class="login_button" style="color: #000080; font-family: Verdana; background-color: #FFFFFF; font-size: 10pt; font-weight: bold" value="Login">
          <cfif login_failed IS 'true'>
          	<br><span class="login_failure"><cfoutput>#error_msg#</cfoutput></span>
          </cfif>
          
          </div></td>
          </tr>
      </table></td>
    </tr>
  </table>
  </center>
  </div>
  <table width="300" border="0" align="center" cellpadding="4" cellspacing="0">
    <tr>
      <td>
          <div align="center"></div>
          <div align="right" class="bottom_info"><div align="center"><br>
              <cfoutput>
                      <a href = "#request.AdminPath#helpdocs/Forgotten_Admin_Password.htm" onClick="NewWindow(this.href,'Help','375','450','yes');return false;" style="color:##FFFFFF;"><b>Forgot your password?</b></a></cfoutput>
                  <strong>
                  </strong>
            </div>
            <div align="center"><br>
            </div>
        </div>
      </td>
    </tr>
  </table>
  <cfquery name = "qVersion" datasource="#request.dsn#">
  SELECT * FROM versioninfo
  </cfquery>
  <p align="center"><font color="#FFFFFF"><cfoutput query = "qVersion">Version #version# Build #build#</cfoutput></font></p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
</form>

<cfabort><!---stops any other processing until they have logged in--->

</body>
</html>