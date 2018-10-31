<!---loads a page if url.page exists--->
<cfset url.page = replacenocase(url.page, "docs/", "", "ALL")>
<cfset GrantAccess = 'Yes'>

<!---check permissions on page--->
<cfquery name = "qryPermissions" datasource="#request.dsn#">
SELECT * FROM private_pages
WHERE page_filename = '#url.page#'
</cfquery>

<cfif qryPermissions.recordcount GT 0>
	<cfif qryPermissions.subscription_id GT 0>
    	<!---if not logged in send to login form--->
    	<cfif NOT isdefined('cookie.customerid')>
        	<cfset msgtxt = "You must be logged in to access this page.  Please login to your account first.">
			<cflocation url = "index.cfm?action=customers_login&message_txt=#msgtxt#">
        	<cfset GrandAccess = 'No'>
		<cfelse>
			<!---if the cookie exists check to see if this person is allowed to access this area--->
            <cfquery name = "qryCustomerSubscriptions" datasource="#request.dsn#">
            SELECT * FROM customers_subscriptions
            WHERE r_id = '#qryPermissions.subscription_id#' AND customerid = '#cookie.customerid#' AND status = 'Active'
            </cfquery>
        
            <cfif qryCustomerSubscriptions.recordcount IS 0>
                <p>&nbsp;</p>
                <div class="access_denied_msg">
                <center><b>You do not have permission to <br />
                enter this area of our website.</b></center>
                </div>
                <cfset GrantAccess = 'No'>
            
            </cfif>   
        </cfif>
    </cfif>

	<!---for page passwords--->    
    <cfif len(trim(qryPermissions.pword)) GT 0>
    	<cfset cookievarpart = "pword_#qryPermissions.id#">
        <cfset cookievar = 'cookie.#cookievarpart#'>
         <cfif NOT isdefined(cookievar) AND NOT isdefined('form.page_pword')>
        	<cfset GrantAccess = 'No'>
            <cfinclude template = "page_password.cfm">
         </cfif>
         
         <cfif isdefined('form.page_pword')>
			<cfif form.page_pword IS qryPermissions.pword>
	         	<cfcookie name="#cookievarpart#" value="#form.page_pword#" expires="1">
 				<cfset GrantAccess = 'Yes'>
			<cfelse>
				<cfset GrantAccess = 'No'>	
   				<cfcookie name="#cookievarpart#" value="" expires="NOW">
                <cfinclude template = "page_password.cfm">                               
            </cfif>   	
		 </cfif>

         <cfif isdefined(cookievar)>
         	<cfset cookie_pass = evaluate('#cookievar#')>
			<cfif cookie_pass IS qryPermissions.pword>
 				<cfset GrantAccess = 'Yes'>
			<cfelse>
				<cfset GrantAccess = 'No'>	
				<cfcookie name="#cookievarpart#" value="" expires="NOW">
                <cfinclude template = "page_password.cfm">                               
            </cfif>   	
		 </cfif>
    </cfif>

</cfif>

<cfif GrantAccess IS 'Yes'>

<!---Include Custom Store Header--->
<cfset filelocation = '#request.catalogpath#docs#request.bslash##url.page#'>

	<cfif fileexists('#filelocation#')>
		<cfif right(url.page, 4) IS ".htm" OR right(url.page, 4) IS ".txt" OR right(url.page, 4) IS '.cfm'>
         <cfif isdefined('url.lf')><!---if being loaded in a frame make the iframe (uses url.lf=t if it load in frame, lf=f or not present it won't)--->
		 	<cfif url.lf IS 't'>
            	<cfoutput>#CGI.HTTP_REFERER#<iframe name="ifm" id="ifm" src="#request.homeurl#docs/#url.page#" width="100%"></iframe></cfoutput>
				<script>
            	resizeIframe('ifm');
           		</script>
            <cfelse>
				<cfsavecontent variable="page_output">
                <cfinclude template ="docs/#url.page#">
                </cfsavecontent>
								<cfoutput>#page_output#</cfoutput>
			</cfif>
         <cfelse>
				<cfsavecontent variable="page_output">
                <cfinclude template ="docs/#url.page#">
                </cfsavecontent>
				      	
				<cfoutput>#page_output#</cfoutput>         
		</cfif>
        </cfif><!---end if html or other doc--->
        <cfif right(url.page, 4) IS ".pdf"><!---load pdf files--->
           <cfoutput><iframe name="ifm" id="ifm" src="docs/#url.page#" width="100%" height="800"></iframe></cfoutput>
           <script>
            resizeIframe('ifm');
           </script>
        </cfif>
    <cfelse>
    <h2>Page Not Found</h2>
    We're sorry, the requested page was not found.  The page may have been moved or is not longer available.   
    </cfif>
</cfif>
