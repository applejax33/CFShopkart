<cfif isdefined('cookie.custemail')>
    <CFCOOKIE name="CustEmail" expires="NOW" Value="None">
    <CFCOOKIE name="CustPassword" expires="NOW" Value="None">
    <CFCOOKIE name="CustomerID" expires="NOW" Value="None">
	<cflocation url = "index.cfm?action=logout">    
<cfelse>
    <center><b>You have successfully Logged Out</b></center>
</cfif>



