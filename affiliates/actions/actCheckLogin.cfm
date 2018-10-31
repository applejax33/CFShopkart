<!---check to see if the form variables were passed and 
		 if so load them into the session variables--->

<cfif isdefined('form.affiliateid')>
	<cflock scope="session" timeout="10" type="exclusive">
		<cfset session.affiliateid = form.affiliateid>
		<cfset session.affiliatepw = form.affiliatepw>
	</cflock>
</cfif>

<!---Check to see if the user is logged in.  If not, then show the login screen--->
<cfif NOT isdefined('session.affiliateid')>
		<cflocation url = "index.cfm?action=login">
</cfif>

<!---Check the username and password--->	
<cfif isdefined('session.affiliateid')>
	<cflock scope="session" type="readonly" timeout="10">
		<cfset request.affiliateid = session.affiliateid>
		<cfset request.affiliatepw = session.affiliatepw>
	</cflock>
	
	<cfinclude template = "../queries/qrylogincheck.cfm">
	
	<!---If the login check fails send them to login.htm--->
	<cfif qryLogin.recordcount IS 0>
		<cflocation url = "index.cfm?action=login">
	</cfif>
	
    <cfset qAffiliate = qryLogin>
    
	<!---In case they logged in with email address then set the session to the affiliateid
	not their email address--->
	<cfset request.affiliateid = qryLogin.affiliateid>
	
</cfif>



