<cfinclude template = "../queries/qrycompanyinfo.cfm">
<cfparam name = "lastaction" default="home">

<cfquery name="GetPassword" datasource="#Request.dsn#">
SELECT * 
FROM customerhistory 
WHERE EmailAddress = '#form.EmailAddress#'
</cfquery>

<cfif GetPassword.RecordCount IS 0>
  <p align = "center"><strong>Sorry, that email address was not found in our records. 
    Please check the email address and try again.</strong></p>
  <p align = "center"><strong><cfoutput><a href="index.cfm?action=#lastaction#&carttoken=#carttoken#">Click here to go back</a></cfoutput></strong></p>
<cfabort>
</cfif>

<cfoutput query = "GetPassword">
	<cfset YourPassword = '#CustPassword#'>
</cfoutput>

<cfoutput query="qryCompanyInfo">    
    <cfset TheCompanyEmail = '#EmailAddress#'>
    <cfset TheMailServer = '#MailServer#'>
	<cfset PasswordSubject = '#PassRetrvlSubj#'>
</cfoutput>  

<cfoutput>
<cfsavecontent variable="messagebody">
You have requested that your password be emailed to you from #request.CompanyName# website.
Your password is:  #YourPassword#
</cfsavecontent>
</cfoutput>

<cfif request.UseMailServer IS 'Yes'>

	<cfif request.UseMailLogin IS 'Yes'>
        <cfmail server="#request.MailServer#"
        username="#request.mailuser#"
        password="#request.mailpassword#"
        From="#request.EmailAddress#"
        TO="#form.emailaddress#"
        SUBJECT="#PasswordSubject#"
        type="html">
        #messagebody#
        </cfmail>
      <cfelse>
        <cfmail server="#request.MailServer#"
        From="#request.EmailAddress#"
        TO="#form.emailaddress#"
        SUBJECT="#PasswordSubject#"
        type="html">
        #messagebody#
        </cfmail>       
    </cfif>

<cfelse>

	<cfif request.UseMailLogin IS 'Yes'>
        <cfmail username="#request.mailuser#"
        password="#request.mailpassword#"
        From="#request.EmailAddress#"
        TO="#form.emailaddress#"
        SUBJECT="#PasswordSubject#"
        type="html">
        #messagebody#
        </cfmail>
      <cfelse>
        <cfmail From="#request.EmailAddress#"
        TO="#form.emailaddress#"
        SUBJECT="#PasswordSubject#"
        type="html">
        #messagebody#
        </cfmail>       
    </cfif>

</cfif>

<p align="center"><strong>Your password was emailed to you.  You should recieve it in a few moments.
If you do not receive your password, please contact us.</strong></p>
<p align="center"><strong><cfoutput><a href="index.cfm?action=#lastaction#&carttoken=#carttoken#">Click here to continue</a></cfoutput></strong></p>








