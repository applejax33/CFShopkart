<!---Affiliates Widget--->
<div class="aff_login_widget">
<form name="form1" method="post" <cfoutput>action="affiliates/index.cfm?carttoken=#carttoken#"</cfoutput> target="_blank">
  <table width="100%" border="0" cellspacing="0" cellpadding="2" class="aff_login_table">
    <tr>
      <td width="40%" class="aff_username_label">Email:</td>
      <td><input name="affiliateid" type="text" class="aff_username_field"></td>
    </tr>
    <tr>
      <td class="aff_password_label">Password:</td>
      <td><input name="affiliatepw" type="Password" class="aff_password_field"></td>
    </tr>
    <tr>
      <td colspan="2" align="center"><input type="submit" name="Submit" value="Login" class="aff_login_button"></td>
    </tr>
    <tr>
    	<td colspan="2" align="center" class="aff_signup_cell"><cfoutput><a href="index.cfm?action=BecomeAffiliate&carttoken=#carttoken#" class="aff_signup_link">Become an Affiliate</a></cfoutput></td>
  </table>
</div>
</form>




