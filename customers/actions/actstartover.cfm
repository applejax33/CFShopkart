<cfoutput>
<CFCOOKIE name="CustomerID" expires="NOW" value="None">
<CFCOOKIE name="CustEmail" expires="NOW" value="None">
<CFCOOKIE name="CustPassword" expires="NOW" value="None">
</cfoutput>

<cfoutput>
<center><b>You are not logged in.</b></center>
<br><center>To login to your account <a href = "index.cfm?action=MyAccount&carttoken=#carttoken#">click here</a>.</center>
</cfoutput>








