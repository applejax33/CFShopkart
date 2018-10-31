<STYLE>
  .unread {font-weight: bold; cursor: pointer;}
  .selecttr { background-color: ; cursor: pointer;}
  .initial { background-color: ; color: ; cursor: pointer; }
  .normal { background-color: ; cursor: pointer; }
  .normalbold {font-weight: bold; cursor: pointer;}
  .highlight { background-color: #FFFF99; cursor: pointer; }
  .highlightbold { background-color: #FFFF99; cursor: pointer; font-weight: bold; }
</style>

<script language="JavaScript">
 function ViewSent(messageid){
	window.location.href = 'index.cfm?action=messages.viewsentmessage&msgid=' + messageid;
 }
</script>

<cfinclude template = "../queries/qrySent.cfm">

<p><strong><font size="3">Sent Messages</font></strong></p>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td colspan="3"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="25">&nbsp;</td>
        </tr>
      </table></td>
  </tr>
  <tr bgcolor="#000099"> 
    <td width="21%" height="25"><strong><font color="#FFFFFF" size="2">To</font></strong></td>
    <td width="43%"><strong><font color="#FFFFFF" size="2">Subject</font></strong></td>
    <td width="33%"><strong><font color="#FFFFFF" size="2">Date</font></strong></td>
  </tr>
  <cfoutput query = "qrySent">
    <tr onMouseOver="this.className='highlightbold'" onMouseOut="this.className='normalbold'" class="unread"> 
      <td onclick="ViewSent(#msgid#);"> 
         #SentTo#</td>
        <td height="25" onclick="ViewSent(#msgid#);">#subject#</td>
        <td onclick="ViewSent(#msgid#);">#datesent#</td>
     </tr>
  </cfoutput>
</table>
<p align="center"><strong></strong></p>









