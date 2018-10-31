<p align="left"><font size="3"><strong>PASSWORD CHANGE</strong></font></p>
<i>change the password for your login here.</i> 
  <form method="POST" action="index.cfm?action=account.updatepassword">
  <table width="75%" border="0" cellspacing="0" cellpadding="4" align="left">
    <tr> 
      <td width="49%"></td>
	  <cfoutput>
	  <td width="51%"><input type = "hidden" value="#qryLogin.AffiliateID#" name="EditThisUser">	  </td></cfoutput></tr>
    <tr>
      <td><b>Affiliate ID:</b></td>
      <td><cfoutput>
	  #qryLogin.AffiliateID#
	  </cfoutput></td>
    </tr>
    <tr> 
      <td width="49%"><b>Old Password:</b></td>
      <td width="51%"><input type="password" name="ChangePasswordOld" size="20"></td>
    </tr>
    <tr> 
      <td width="49%"><b>New Password:</b></td>
      <td width="51%"> <input type="password" name="ChangePasswordNew" size="20"></td>
    </tr>
    <tr> 
      <td width="49%"><b>New Password Confirm:</b></td>
      <td width="51%"> <input type="password" name="ChangePasswordConfirm" size="20"></td>
    </tr>
  </table>
    <input type="hidden" name="action" value="ChangePassword">
    <input type="submit" value="Change Password" name="B1">
</form>
