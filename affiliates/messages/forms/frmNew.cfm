<h3>Send a Message</h3>
<p>You can use this to send a message to the system administrator<!--- or to any sub affiliates you have. The next time they login they will be notified on their welcome screen that they have a new message.---> </p>
<form name="form1" method="post" action="index.cfm?action=messages.send">
  <table width="100%" border="0" cellspacing="0" cellpadding="4">
    <tr> 
      <td width="19%" height="25" valign="top"><strong>To:</strong><br>
        Note: Hold down the CTRL key to select more than one.</td>
      <td width="81%" height="25">
	  	<select name="ToField" size="6" id="ToField" multiple="multiple">
	  		<option value = "Admin" selected>Send Message To Admin</option>
				<!---
				<cfoutput query = "qrySubAffiliates">
				<option value = "#affiliateID#">#FirstName# #LastName#</option>
			</cfoutput>--->
        </select></td>
    </tr>
    <tr> 
      <td height="26"><strong>Subject:</strong></td>
      <td height="26"><input name="Subject" type="text" id="Subject" size="30" maxlength="250"></td>
    </tr>
    <tr> 
      <td height="25" valign="top"><strong>Message:</strong></td>
      <td height="25"><textarea name="body" cols="40" rows="15" id="body"></textarea></td>
    </tr>
    <tr> 
      <td height="25">&nbsp;</td>
      <td height="25"><input type="submit" name="Submit" value="Send"></td>
    </tr>
    <tr> 
      <td height="25">&nbsp;</td>
      <td height="25">&nbsp;</td>
    </tr>
  </table>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
</form>








