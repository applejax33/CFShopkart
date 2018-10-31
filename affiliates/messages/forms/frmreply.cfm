<cfparam name = "replyto" default="admin">

<cfset senderid = #replyto#> 

<font size="4"><strong>Replying to Message</strong></font> 
<cfinclude template = "../queries/qrySender.cfm">
<cfinclude template = "../queries/qryMessage.cfm">

<form name="form1" method="post" action="index.cfm?action=messages.send">
  <table width="100%" border="0" cellspacing="0" cellpadding="4">
    <tr> 
      <td width="19%" height="25" valign="top"><strong>To:</strong><br>
      </td>
      <td width="81%" height="25">
	  <cfoutput><input name="ToField" type = "hidden" size="6" id="ToField" value = "#senderid#">	</cfoutput>	
			<cfif NOT qrySender.RecordCount IS 0>
			<p><strong>To: </strong><cfoutput>#qrySender.firstname# #qrySender.LastName# (#senderid#)</cfoutput></p>	
    	<cfelse>
				<b>To:</b> <cfoutput>#SenderID#</cfoutput>
			</cfif>
      </select></td>
    </tr>
	<cfoutput>
    <tr> 
      <td height="26"><strong>Subject:</strong></td>
      <td height="26"><input name="Subject" type="text" id="Subject" size="30" maxlength="250" value = "RE: #qryMessage.subject#"></td>
    </tr>
    <tr> 
      <td height="25" valign="top"><strong>Message:</strong></td>
      <td height="25"><textarea name="body" cols="40" rows="15" id="body">




----REPONSE TO------
#qryMessage.body#
	  </textarea></td>
    </tr>
	</cfoutput>
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








