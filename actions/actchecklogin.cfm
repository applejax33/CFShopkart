<!---If the login form was not used to login, then check for cookies--->
<cfset isloggedin = 'No'>
<cfif isdefined('url.action')>
	<cfset request.action = url.action>
</cfif>
<cfif isdefined('form.action')>
	<cfset request.action = form.action>
</cfif>
<cfif not isdefined('url.action') AND NOT isdefined('form.action')>
	<cfset request.action = 'loadhomepage'>
</cfif>

<cfif NOT request.action IS 'site_login'>
	<cfif NOT isdefined('form.sitepassword')>
        <cfif NOT isdefined('cookie.sitepassword')>
            <cfif NOT isdefined('url.login')>
               <cfoutput>
                     <script language="JavaScript">
                        <!--
                        top.location.replace("#request.homeurl#index.cfm?action=site_login");
                        -->	
                      </script>
                </cfoutput>
                <cfabort>
            </cfif>
        </cfif>
    </cfif>
    
    <!---If the login form was used, check the username and Password entered--->
    <cfif isdefined('form.sitepassword')>
        <cfquery name ="qryLoginCheck" datasource = "#request.dsn#">
            SELECT * FROM settings_main
            WHERE sitepassword = <cfqueryparam value="#form.sitepassword#" cfsqltype="cf_sql_varchar">
        </cfquery>
    
        <cfif #qryLoginCheck.recordcount# IS 0>      
           <CFCOOKIE name="sitepassword" expires="NOW" Value="None">
           <cfoutput>
                 <script language="JavaScript">
                    <!--
                    top.location.replace("#request.homeurl#index.cfm?action=site_login&invalid=1");
                    -->	
                  </script>
            </cfoutput>
            <cfabort>
         </cfif>
         
        <!---if login id matches then create cookie--->
        <cfset isloggedin = 'Yes'><!---used for if they login using form we don't check login twice since the cookies will be found--->
        <cfcookie name="sitepassword" value="#form.sitepassword#" expires="never">
    </cfif>
    
    <!---if the cookie exists check login--->
    <cfif isloggedin IS 'No'>
		<cfif isdefined('cookie.sitepassword')>
    
            <cfquery name ="qryLoginCheck" datasource = "#request.dsn#">
            SELECT sitepassword FROM settings_main
            WHERE sitepassword = <cfqueryparam value="#cookie.sitepassword#" cfsqltype="cf_sql_varchar">
            </cfquery>
    
        <!---if it doesn't match then count as failed attempt---->
            <cfif #qryLoginCheck.recordcount# IS 0> 
               
               <cfset isloogedin = 'No'>
               
               <CFCOOKIE name="sitepassword" expires="NOW" Value="None">
                      
               <cfoutput>
                     Invalid login attempt.
                     <script language="JavaScript">
                        <!--
                        top.location.replace("#request.homeurl#index.cfm?action=site_login&invalid=1");
                        -->	
                      </script>
                </cfoutput>
                <cfabort>
           <cfelse>
                <cfset isloggedin = 'Yes'>
           </cfif>
        </cfif>
    </cfif>

</cfif><!---end if the action call is not site_login--->



