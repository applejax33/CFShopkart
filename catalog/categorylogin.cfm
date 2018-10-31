<div align="center"> 
  <p><strong>To access this area you will <br>
    need a username and CustPassword</strong></p>
<cfoutput>
  <form name="form1" method="post" action="index.cfm?carttoken=#carttoken#&action=ViewCategory&Category=#url.Category#">
    <table width="250" border="0" cellspacing="0" cellpadding="1">
      <tr> 
        <td>Username:</td>
        <td><input name="CategoryUsername" type="text" id="CategoryUsername"></td>
      </tr>
      <tr> 
        <td>CustPassword:</td>
        <td><input name="CategoryPassword" type="CustPassword" id="CategoryPassword"></td>
      </tr>
      <tr> 
        <td colspan="2"><div align="center">
            <input type="submit" name="Submit" value="Login">
          </div></td>
      </tr>
    </table>
  </form>
</cfoutput>
  <p><strong></strong></p>
  <p><strong></strong></p>
  <p>&nbsp;</p>
</div>




