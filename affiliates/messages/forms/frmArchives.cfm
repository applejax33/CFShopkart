<STYLE>
<!--
  .unread {font-style: bold;}
  .read {font-style: ;}
  .selecttr { background-color: ; cursor: pointer;}
  .initial { background-color: ; color: ; cursor: pointer; }
  .normal { background-color: ; cursor: pointer; }
 .highlight { background-color: #CC9900; cursor: pointer; }

//-->
</style>

<cfinclude template = "../queries/qryArchives.cfm">
<p><strong><font size="3">Archived Messages</font></strong></p>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr bgcolor="#000099"> 
    <td width="3%"><font color="#FFFFFF">&nbsp;</font></td>
    <td width="29%"><strong><font color="#FFFFFF" size="2">From</font></strong></td>
    <td width="49%"><strong><font color="#FFFFFF" size="2">Subject</font></strong></td>
    <td width="19%"><strong><font color="#FFFFFF" size="2">Date</font></strong></td>
  </tr>
  <cfoutput query = "qryMessages">
  <tr> 
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  </cfoutput>
</table>
<p><strong></strong></p>









