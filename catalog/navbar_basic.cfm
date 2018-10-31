<cfinclude template = "../queries/qryNavTop.cfm">
<table width="100%" cellspacing="0" cellpadding="0">
<tr>
	<td width="1%"><cfoutput><img src = "images/spacer.gif" class="spacer" width="1" /></cfoutput></td>
    <td valign="middle">
    <cfset rowcount = 0>
	 <cfoutput query = "qryNavTop"><cfset rowcount = rowcount + 1>
     <cfif request.use_urlrewrite IS 'Yes'><a href="#request.absolutepath##linkurl#">#LinkTitle#</a><cfelse><a href="#linkurl#">#LinkTitle#</a></cfif> <cfif NOT rowcount IS qryNavTop.recordcount> | </cfif> </cfoutput>
      </td>
</tr>
</form>
</table>



