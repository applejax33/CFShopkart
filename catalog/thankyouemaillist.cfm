<!---if the custom message is found show it, otherwise show the default--->
<cfif fileexists('#request.catalogpath#docs/email_signup.cfm')>
	<cfinclude template = "../docs/email_signup.cfm">
<cfelse>
<h3>Welcome to our mailing list!</h3>
Thank you for subscribing to our email list!.<br />
We have added your email address to our mailing list.  You will now begin receiving information from us.<br />
If you decide to unsubscribe you can do so by clicking the link at the bottom of the email.  Thank you.
</cfif>



