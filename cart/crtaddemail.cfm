<!---Adds a customers email to the email list if enter it into the box on the front page--->
<cfset waserror = 'No'>

<cfparam name = "fullname" default="">
<cfparam name = "emailaddress" default="">
<cfparam name = "firstname" default="">
<cfparam name = "lastname" default="">

<cfif not isdefined('form.fullname')>
	<cfset form.fullname = '#form.firstname# #form.lastname#'>
</cfif>

<cfif #form.EmailAddress# IS ''>
    You failed to enter an email address.  Please provide your email address to be added
    to the list.
    <cfset waserror = 'yes'>
</cfif>

<cfif waserror IS 'No'>
	<cfif NOT #form.EmailAddress# CONTAINS '@'>
        You failed to enter a proper email address.  You must provide a valid email address to be 
        added to the list.
        <cfset waserror = 'yes'>
     </cfif>
</cfif>

<cfif waserror IS 'No'>
    <cfquery name = "CheckForDuplicateEmail" Datasource = "#request.dsn#">
    SELECT *
    FROM nl_members
    WHERE EmailAddress = <cfqueryparam value="#form.EmailAddress#" cfsqltype="cf_sql_varchar">
    </cfquery>
    
    <cfif #CheckForDuplicateEmail.RecordCount# IS 0>
    <cfset adddate = now()>
    
    <CFQUERY Name = "AddtoMailingList" Datasource = "#request.dsn#">
    INSERT INTO nl_members
    (name, emailaddress, active, subscribedon, firstname, lastname)
    VALUES
    (<cfqueryparam value="#Form.FullName#" cfsqltype="cf_sql_varchar">, 
    <cfqueryparam value="#form.EmailAddress#" cfsqltype="cf_sql_varchar">, 
    <cfqueryparam value="active" cfsqltype="cf_sql_varchar">, 
    <cfqueryparam value="#createodbcdatetime(addDate)#" cfsqltype="cf_sql_date">,
    <cfqueryparam value="#firstname#" cfsqltype="cf_sql_varchar">,
    <cfqueryparam value="#lastname#" cfsqltype="cf_sql_varchar">
    )
    </CFQUERY>
    <cfelse>
    Our records indicate that you are already a member of our newsletter.	 
    </cfif>
    
    <cflocation url = "index.cfm?action=ThanksEmail">
</cfif>