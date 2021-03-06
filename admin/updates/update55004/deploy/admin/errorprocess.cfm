<!--- Log Error Message --->
<cfset carttoken="NULL_adminerror">
<cfset errorbrief="Not Specified.">
<cfset fullerror="No error report could be generated.">

<!--- Email Error Message --->
<cfsavecontent variable="extradetail">
<cfoutput>
<style>
td,th{font:11px verdana;}
th{text-align:left;font-weight:bold;background-color:##EEE;}
th,td{vertical-align:top;}
</style>
<h4>Error Report</h4>
<table cellpadding="5" cellspacing="1" border="0" width="100%">
	<tr>
		<th>Date:</th>
		<td>#dateFormat(now(),"m/d/yy")# #timeFormat(now(),"h:mm tt")#</td>
	</tr>
	<tr>
		<th>URL:</th>
		<td><cfset theURL = #request.homeurl#>
        	<cfset theURL = replacenocase(theURL, request.absolutepath, "", "ALL")>
			<cfset theURL = theURL & cgi.script_name>
			<cfif Len(CGI.query_string)>
				<cfset theURL = theURL & "?" & CGI.query_string>
                <cfset repstring = "&user=#request.adminusername#&pass=#request.adminpassword#">
                <cfset theURL = replacenocase(theURL, repstring, "", "ALL")>
			</cfif>
			<cfset theURL = replace(theURL,"//","/","ALL")>
            <cfset theURL = replace(theURL,"http:/","http://","ALL")>
			<a href="#theURL#">#theURL#</a>
		</td>
	</tr>
	<tr>
		<th>Visitor IP:</th>
		<td>#cgi.REMOTE_ADDR#
	  </td>
	</tr>    
	<tr>
		<th>Browser:</th>
		<td>#cgi.HTTP_USER_AGENT#
	  </td>
	</tr>   
	<tr>
		<th>Application:</th>
		<td><cfif isdefined('application.applicationnname')>#Application.applicationname#</cfif></td>
	</tr>
	<cfset infoList = "Message,Type,Browser,Httpreferer,Rootcause,Tagcontext">
	<cfloop list="#infoList#" index="errorItem">
		<cfif StructKeyExists(cfcatch,errorItem)>
		<tr>
			<th>#errorItem#:</th>
			<td><cfdump var="#cfcatch[errorItem]#"></td>
		</tr>

        <cfif errorItem IS 'Message'>
        	<cfset errorbrief = "#replace(cfcatch.message, '#request.bslash#', '#request.bslash##request.bslash#', 'ALL')#  Error Occurred on line #cfcatch.Tagcontext[1].LINE# in #replace(cfcatch.Tagcontext[1].template, '#request.bslash#', '#request.bslash##request.bslash#', 'ALL')#">
		</cfif>
	
        </cfif> 
	</cfloop>
    
    <tr>
    	<th>Token:</th>
        <td>#carttoken#</td>    
</table>
</cfoutput>
</cfsavecontent>

<!---autoban hack attempts--->
<!---hack attempts try to use mysql commands the shopping cart doesn't use, especially in query strings so it's easy to find out if someone is trying to hack.  Therefore, they are banned on their first
attempt so they don't fill up our error log--->
<cfif CGI.query_string CONTAINS '+union' OR CGI.query_string CONTAINS '+concat' OR CGI.query_string CONTAINS '+all' OR CGI.query_string CONTAINS '%20and%20' OR CGI.query_string CONTAINS '+or'>
	
    <!---create the file if it doesn't exist--->
	<cfif NOT fileexists('#request.catalogpath#config#request.bslash#banned.cfm')>
	    <cffile action = "write" file="#request.catalogpath#config#request.bslash#banned.cfm" output="">	
    </cfif>

	<!---append the ip address--->
  	<cffile action = "append" file="#request.catalogpath#config#request.bslash#banned.cfm" output="#cgi.REMOTE_ADDR#">

</cfif>

<cfset extradetail = replacenocase(extradetail, "\", "\\", "ALL")>
<cfset fullerror = '#extradetail#'>

<cfquery name = "qryErrors" datasource="#request.dsn#">
SELECT * FROM errorlog WHERE brief = <cfqueryparam value="#errorbrief#" cfsqltype="cf_sql_longvarchar">
</cfquery>

<cfif qryErrors.recordcount IS 0><!---prevent duplicate entries--->
    <cfquery name = "qryLogError" datasource="#request.dsn#">
    INSERT INTO errorlog
    (errordetail, errordate, brief, errorid)
    VALUES
    (<cfqueryparam value="#fullerror#" cfsqltype="cf_sql_longvarchar">,
    <cfqueryparam value="#createodbcdatetime(now())#" cfsqltype="cf_sql_date">, 
    <cfqueryparam value="#errorbrief#" cfsqltype="cf_sql_longvarchar">,
    <cfqueryparam value="0" cfsqltype="cf_sql_longvarchar">)
    </cfquery>
</cfif>
 
<cfif NOT request.debug IS 'On'>
<p align="left"><strong>
<h2>Sorry, We are experiencing technical difficulties!</h2>
</strong><br></p>
<p align="left"><strong>We appolgize for the inconvenience, but we were unable to process your request.
A report of the generated error was sent to the webmaster along with some information about your
browser and ip address.<br>
</strong>
<p><strong>
You do not need to contact us about this error because we will be automatically notified.
Thank you for your patience.</strong></p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="left">Please <a href="index.cfm" target="_top">click here</a> to return to the start page.</p>
<p align="left">&nbsp;</p>
<cfelse>
<cfoutput>
Debug is on!  Details of errors are being displayed on your website.  For greater security, turn off debug mode.
<p>
#replace(fullerror, "\\", "\", "ALL")#
</cfoutput>
</cfif>

<cfif NOT request.debug IS 'On'>
	<cflocation url = "#request.adminpath#error.cfm">
</cfif>
