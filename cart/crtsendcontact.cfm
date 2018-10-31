<!---send a message from the contact form based on settings--->
<cfparam name = "email_address" default="">
<cfparam name = "your_name" default="">
<cfparam name = "Phone_Number_optional" default="">
<cfparam name = "Your_Message_to_Me" default="">
<cfparam name = "Type_of_Message" default="Comment">
<cfparam name = "carttoken" default="null">
<cfparam name = "blnIsBot" default="True">

<cfif isdefined('form.Your_Name')>
<cfinclude template = "../queries/qrycontactsettings.cfm">

<cfoutput query = "qryContactSettings">
	
	<!---if using their default settings, then load those into the vars--->
	<cfif len(trim(qryContactSettings.subject_line)) IS '0'>
    	<cfset send_subject = 'Contact Form Response #request.homeURL#'>
    <cfelse>
    	<cfset send_subject = qryContactSettings.subject_line>
    </cfif>

	<cfif qryContactSettings.UseDefaultServer IS 'No'>
   		<cfset send_UseMailServer = qryContactSettings.UseMailServer>
		<cfset send_UseMailLogin = qryContactSettings.UseMailLogin>
        <cfset send_mailuser = qryContactSettings.mailuser>
        <cfset send_mailpassword = qryContactSettings.mailpassword>
        <cfset send_mailserver = qryContactSettings.mailserver>
        <cfset send_toemail = qryContactSettings.emails_goto>
        <cfset send_fromemail = form.email_address>
    <cfelse>
   		<cfset send_UseMailServer = request.UseMailServer>
		<cfset send_UseMailLogin = request.UseMailLogin>
        <cfset send_mailserver = request.MailServer>
        <cfset send_mailuser = request.mailuser>
        <cfset send_mailpassword = request.mailpassword>
        <cfset send_toemail = request.EmailAddress>
        <cfset send_fromemail = form.email_address>
	</cfif>
</cfoutput>

	<cfset waserror = 'No'>
    
	<cfif len(trim(form.email_address)) IS 0>
    	<cfset errortype = 'emailaddress'>
        <cfset waserror = 'Yes'>
    </cfif>
    
	<cfif NOT form.email_address CONTAINS '@'>
    	<cfset errortype = 'emailaddress'>
        <cfset waserror = 'Yes'>
    </cfif>

	<!---If no errors then check for bot--->
	<cfif waserror IS 'No'>
		<!---strip out html--->
    	<cfset visitormsg = ReReplaceNoCase(#form.Your_Message_To_Me#,"<[^>]*>","","ALL")>
        
        <!---if captcha is enabled set blnIsBot to true and test--->
       <cfif qryContactSettings.usecaptcha IS 'No'>
			<cfset blnIsBot = false />
       <cfelse>
       		<cfset blnIsBot = true />
               
			<!--- Decrypt the check value. --->
            <cfset strCaptcha = Decrypt(FORM.captcha_check, "bots-aint-sexy", "CFMX_COMPAT","HEX") />
            
            <cfif (strCaptcha EQ FORM.captcha)>
                <cfset blnIsBot = false />
            <cfelse>
                <cfset blnIsBot = true />
            </cfif>
      	
        </cfif><!---end if using captcha--->
   </cfif>

<cfif blnIsBot IS true>
	<cfset waserror = 'Yes'>
    <cfset errortype = 'captchaerror'>
</cfif>


<cfif waserror IS 'No'>   
	<cfif blnIsBot IS false>

<cfoutput>
<cfsavecontent variable="messagebody">
#visitormsg#
<p>&nbsp;</p>  
#form.Your_Name#<br />
#form.Email_Address#<br />
#form.Phone_Number_optional#<br />
</cfsavecontent>
</cfoutput>

	<cfif send_UseMailServer IS 'Yes'>
        <cfif send_UseMailLogin IS 'Yes'>
            <cfmail server="#send_MailServer#"
            username="#send_mailuser#"
            Password="#send_mailpassword#"
            From="#send_fromemail#"
            TO="#send_toemail#"
            SUBJECT="#send_subject#"
            type="html">
            #messagebody#
            </cfmail>
          <cfelse>
            <cfmail server="#send_MailServer#"
            From="#send_fromemail#"
            TO="#send_toemail#"
            SUBJECT="#send_subject#"
            type="html">
            #messagebody#
            </cfmail>       
        </cfif>
    <cfelse>
        <cfif send_UseMailLogin IS 'Yes'>
            <cfmail username="#send_mailuser#"
            Password="#send_mailpassword#"
            From="#send.fromemail#"
            TO="#send_toemail#"
            SUBJECT="#send_subject#"
            type="html">
            #messagebody#
            </cfmail>
          <cfelse>
            <cfmail From="#send_fromemail#"
            TO="#send_toemail#"
            SUBJECT="#send_subject#"
            type="html">
            #messagebody#
            </cfmail>       
        </cfif>
    </cfif>
</cfif>
</cfif>

<cfif waserror IS 'Yes'>
	<!---if error include contact form again--->
	<cfinclude template = "../catalog/ContactForm.cfm">
</cfif>

<cfif waserror IS 'No'>

	<cfif len(trim(qryContactSettings.thanks_page)) GT 0>
    	<cfif fileexists('#request.catalogpath#docs#request.bslash##qryContactSettings.thanks_page#')>
        	<cflocation url = "index.cfm?page=#qryContactSettings.thanks_page#">       
        </cfif>
   </cfif>
	
   <div class="contactform_thankyou"><center><strong>Your contact information was submitted.  Thank you!</strong></center></div>
</cfif>

</cfif><!---end if form is defined--->



