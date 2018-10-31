<!---site login form--->
<p>
<form name="form1" method="post" action="index.cfm">
<cfif isdefined('url.invalid')>
<p align="center"><font color="#FF0000">Invalid Login</font></p></cfif>
<p align="center">This website requires the use of a password before you can enter</p>
<table width="300" border="1" align="center" cellpadding="4" cellspacing="0">
  <tr>
    <td class="navbar"><div align="center"><strong>Please Enter The Password</strong></div></td>
  </tr>
  <tr>
    <td><p>Password:    
      <input type="text" name="sitepassword" id="sitepassword" value="">
    </p>
      <p align="center">
        <input type="submit" name="button" id="button" value="Login" />      
          </p></td>
  </tr>
</table>
</form>

