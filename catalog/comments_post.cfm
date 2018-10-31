<cfparam name="show_error" default="no">
<h2>Post a Comment</h2>
<form name="form1" method="post" action="index.cfm?action=comments_post">
  <cfif show_error IS 'Yes'>
  <p><font color="#FF0000">Please fill in all required fields (*).  Your email address will not be published.</font></p>
  </cfif>
  <table width="566" border="0" cellspacing="0" cellpadding="6">
    <tr>
      <td width="188">Name:</td>
      <td width="354"><input type="text" name="poster_name" id="poster_name">
        *</td>
    </tr>
    <tr>
      <td>Email (will not be displayed)</td>
      <td><input type="text" name="poster_email" id="poster_email">
        *</td>
    </tr>
    <tr>
      <td colspan="2">Comment:* 255 Characters maximum</td>
    </tr>
    <tr>
      <td colspan="2"><textarea name="comment" id="comment" cols="25" rows="5" style="width: 500px;"></textarea></td>
    </tr>
    <tr>
      <td colspan="2"><p>
          <input type="submit" name="button" id="button" value="Post Comment"> 
        </p>
        <p>* Denotes a required field. <br>
        Note: Comments will appear immediately. All comments must be approved first.</p>
        </td>
    </tr>
  </table>
</form>



