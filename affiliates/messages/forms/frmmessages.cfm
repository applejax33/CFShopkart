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
 function ViewMessage(messageid){
	window.location.href = 'index.cfm?action=messages.view&msgid=' + messageid;
 }
</script>

<cfinclude template = "../queries/qrymessages.cfm">

<p><strong><font size="3">Messages</font></strong></p>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr> 
    <td colspan="4"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="25">&nbsp;</td>
        </tr>
      </table></td>
  </tr>
  <tr bgcolor="#000099"> 
    <td width="15%" height="25"><strong><font color="#FFFFFF" size="2">From</font></strong></td>
    <td width="40%"><strong><font color="#FFFFFF" size="2">Subject</font></strong></td>
    <td width="40%"><strong><font color="#FFFFFF" size="2">Date</font></strong></td>
    <td width="5%" align="center"><strong><font color="#FFFFFF" size="2">Del</font></strong></td>
  </tr>
  <cfloop query = "qryMessages"> 
    <tr <cfif qryMessages.wasread IS 'No'>onMouseOver="this.className='highlightbold'"<cfelse>onMouseOver="this.className='highlight'"</cfif><cfif qryMessages.wasread IS 'No'>onMouseOut="this.className='normalbold'"<cfelse>onMouseOut="this.className='normal'"</cfif><cfif qryMessages.wasread IS 'No'>class="unread" <cfelse>class="selecttr"</cfif>> 
      <td <cfoutput>onclick="ViewMessage(#msgid#);"</cfoutput>>
	  <cfoutput>#qryMessages.sender#</cfoutput></td>
	  <cfoutput>
      <td height="25" onclick="ViewMessage(#msgid#);">#subject#</td>
      <td onclick="ViewMessage(#msgid#);">#datesent#</td>
      <td align="center"><a href = "index.cfm?action=messages.delete&msgid=#msgid#"><img src="icons/del_16.gif" width="16" height="16" border="0"></a></td>
	  </cfoutput>
    </tr>
  </cfloop> 
</table>
<cfif qryMessages.recordcount IS 0>You have no messages!</cfif>
<p align="center"><strong></strong></p>









