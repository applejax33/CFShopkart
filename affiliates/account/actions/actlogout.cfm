<cflock scope="session" timeout="10" type="exclusive">
	<cfset session.AffiliateID = "">
	<cfset session.AffiliatePW = "">
</cflock>

You are now logged out!