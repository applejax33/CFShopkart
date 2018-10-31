<cfset cartcount = 0>
<cfif isdefined('session.crtItemID')>
	 <cflock scope="session" timeout="10" type="readonly">
		<cfset cartcount = listlen(session.crtItemID, "^")>
	 </cflock>
</cfif>

<table width="100%" cellspacing="0" cellpadding="0">
<form method="POST" <cfoutput>action="index.cfm?CartToken=#CartToken#"</cfoutput>>
<tr>
	<td width="1%"><cfoutput><img src = "images/spacer.gif" class="spacer" width="1" /></cfoutput></td>
    <td valign="middle">
	 <cfoutput>
	    <cfif request.use_urlrewrite IS 'Yes'>
        <a href="/home">Home</a> | 
      <a href="/viewcart">Cart (Items: #cartcount#)</a> | <cfif NOT isdefined('cookie.CustEmail')><a href="/myaccount">Login</a><cfelse>
      <a href="/myaccount">Your Account</a>
      </cfif><cfif ISDEFINED('cookie.CustEmail')> | <a href = "/logout">Log Out</a></cfif>
	  <cfelse>
        <a href="index.cfm?carttoken=#carttoken#">Home</a> | 
      <a href="index.cfm?action=view&carttoken=#carttoken#">Cart (Items: #cartcount#)</a> | <cfif NOT isdefined('cookie.CustEmail')><a href="index.cfm?action=myAccount&amp;carttoken=#carttoken#">Login</a><cfelse>
      <a href="index.cfm?action=myAccount&amp;carttoken=#carttoken#">Your Account</a>
      </cfif><cfif ISDEFINED('cookie.CustEmail')> | <a href = "index.cfm?action=LogOut&carttoken=#carttoken#">Log Out</a></cfif>
      </cfif>
       </cfoutput>
      </td>
  <td valign="middle" nowrap="nowrap" class="searchbox">
       <div align="right">
		   <cfif request.ShowSearchOnNavBar IS 'Yes'>
		   <input type="text" name="SearchBox" class="searchbox" value="Search Site" onclick="this.value = '';">
		   <input type="hidden" name="Action" value="Search">
		    <cfoutput><input name="SearchCatalog" type="image" src="#request.SearchButton#" align="absmiddle" class="SearchButton"></cfoutput>
           </cfif>
	    </div></td>
</tr>
</form>
</table>



