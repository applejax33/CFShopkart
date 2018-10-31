<!---access code entry form--->
<cfparam name = "badlogin" default="false">
<style type="text/css">
<!--

.style2 {
	color: #000066;
	font-weight: bold;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 16px;
}
.style3 {color: #000066; font-weight: bold; font-family: Arial, Helvetica, sans-serif; font-size: 12px; }
-->
</style>

<cfif fileexists('#request.catalogpath#docs#request.bslash#accesslogin_top.cfm')>
	<cfinclude template = "docs/accesslogin_top.cfm">
</cfif>
<table width="792" height="354" border="0" cellpadding="0" cellspacing="0" background="images/KidzIdzGames Login.jpg" style="background-position: center top;">
  
  <tr>
    <td width="505" height="164">
	<form name="form1" method="post" action="index.cfm">
<table width="433" border="0" align="center" cellpadding="4" cellspacing="0">
  <tr>
    <td><table width="204" height="57" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td><div align="center" class="style2">Access Code</div></td>
      </tr>
      <tr>
        <td valign="middle"><p align="center">
          <input type="text" name="access_code" id="access_code" value="">
        </p>            </td>
      </tr>
    </table></td>
    <td><table width="213" height="57" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td><div align="center" class="style2">Pin</div></td>
      </tr>
      <tr>
        <td valign="middle"><p align="center">
          <input type="text" name="access_pin" id="access_pin" value="">
        </p>          </td>
      </tr>
    </table></td>
  </tr>
  <cfif badlogin IS 'true'>
  <tr>
    <td colspan="2" bgcolor="#FFCCCC"><div align="center" class="style1">Invalid or Expired Certificate Number and Pin.<br>
    </div></td>
  </tr>
  </cfif>
  <tr>
    <td colspan="2"><div align="center">
      <input type="submit" name="button" id="button" value="Start Shopping!" />
    </div></td>
  </tr>
</table>
</form>
<cfif fileexists('#request.catalogpath#docs#request.bslash#accesslogin_bottom.cfm')>
	<cfinclude template = "docs/accesslogin_bottom.cfm">
</cfif>

