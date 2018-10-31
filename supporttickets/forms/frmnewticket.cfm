<cfinclude template = "../queries/qrytypes.cfm">

<form name = "SupportTicket" <cfoutput>action="index.cfm?action=tickets.send&carttoken=#carttoken#"</cfoutput> method="post">
<table width="98%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td colspan="2"><span style="font-weight: bold">New Support Ticket</span> </td>
  </tr>
  <tr>
    <td width="10%"><span style="font-weight: bold; font-size: 10px">Related to: </span></td>
    <td><select name="title">
	<cfoutput query = "qryTypes">
	<option>#TypeName#</option>
	</cfoutput>
    </select>
    </td>
  </tr>
  <tr>
    <td colspan="2"><span style="font-size: 10px; font-weight: bold">Please desribe the problem you are having with as much detail as possible. Copy and paste any error messages you are receiving here. (Tip: Use CTL+C and CTL+P to copy and paste highlighted text) </span></td>
  </tr>
  <tr>
    <td colspan="2"><textarea name="message" cols="45" rows="8"></textarea></td>
  </tr>
  
  <tr>
    <td colspan="2" align="left"><input type="submit" name="Submit" value="Submit" onclick="this.value='Submitting ticket...'; this.disabled=true; this.form.submit();"></td>
  </tr>
</table>
</form>








