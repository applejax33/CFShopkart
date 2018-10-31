	<cfparam name="msg" default="">
	<table width="350" border="0" align="center" cellpadding="2" cellspacing="0">
  <tr>
    <td><p align="center"><b><font face="Verdana" size="4" color="#000080"> Affiliate  
  Login </font></b><br />
    <cfoutput>#msg#</cfoutput></p></td>
  </tr>
  <tr>
    <td><form method="POST" action="index.cfm" name="loginform">

  <div align="center">
    <center>
      <table width="300" border="2" cellpadding="0" cellspacing="0" bordercolor="#000000">
        <tr>
          <td><table width="350" border="0" cellpadding="5" cellspacing="0">
              <tr bgcolor="#CCCCCC"> 
                <td width="55%"> <p align="right"><font color="#000000" size="2" face="Verdana"><b>Affiliate ID or Email:</b></font></p></td>
                <td width="45%"><font color="#000000" face="Verdana"> 
                  <input name="affiliateID" type="text" id="affiliateID" size="20" />
                  </font></td>
              </tr>
              <tr bgcolor="#CCCCCC"> 
                <td><div align="right"><font color="#000000" size="2" face="Verdana"><b>Password:</b></font></div></td>
                <td><font color="#000000" face="Verdana"> 
                  <input name="affiliatepw" type="password" id="affiliatepw" size="20" />
                  </font></td>
              </tr>
              <tr bgcolor="#CCCCCC"> 
                <td colspan="2"><div align="center"> 
                    <input type="submit" value="Login" name="EnterButton" style="color: #000080; font-family: Verdana; background-color: #FFFFFF; font-size: 10pt; font-weight: bold" />
                  </div></td>
              </tr>
              <tr bgcolor="#CCCCCC">
                <td colspan="2">Lost your Password / ID? <a href="index.cfm?action=lostpwd"><strong>Click Here</strong></a> </td>
              </tr>
            </table></td>
        </tr>
      </table>
    </center>
  </div>
  
</form>	
</td>
  </tr>
  <tr>
    <td><p><cfoutput></cfoutput></p>
    </td>
  </tr>
</table>

	



