<table width="100%" cellpadding="1" cellspacing="0">
<form method="POST" action="index.cfm" name="nl_signupform" class="nl_signup">
<tr>
<td colspan="2" class="NewsLetterSignupTitle">
Signup For Our Newsletter</td>
</tr>
<tr>
  <td class="NewsLetterSignupLabels">First Name:</td>
  <td class="NewsLetterSignupFieldsCell">
  	<input type="text" name="firstname" id="firstname" class="nl_signup_firstname" />
  </td>
</tr>
<tr>
<td class="NewsLetterSignupLabels">Last Name:
</td>
<td class="NewsLetterSignupFieldsCell">
<input type="text" name="lastname" id="lastname" class="nl_signup_lastname">
<br></td>
</tr>
<tr>
<td class="NewsLetterSignupLabels">
Email:</td>
<td class="NewsLetterSignupFieldsCell">
  <input type="text" name="EmailAddress" class="nl_signup_emailaddress"></td>
</tr>
<tr>
<td colspan="2" class="NewsLetterSignupButtonsCell">
<input type="hidden" name="action" value="EmailList">
<input type="submit" value="Join Now" name="EmailListAction" class="NewsLetterSignupAddMeButton">
<!---<input type="submit" value="Remove" name="EmailListAction" class="NewLetterSignupRemoveMeButton">---></td>
</tr>
</form>
</table>