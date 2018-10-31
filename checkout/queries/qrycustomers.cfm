<cfif ISDEFINED('cookie.CustEmail')>
    <cfquery name = "qryCustomers" datasource = "#Request.DSN#">
    SELECT * FROM customerhistory
    WHERE EmailAddress = <cfqueryparam value="#cookie.CustEmail#" cfsqltype="cf_sql_varchar">
    AND CustPassword = <cfqueryparam value="#cookie.CustPassword#" cfsqltype="cf_sql_varchar">
    </cfquery>
</cfif>

<cfif ISDEFINED('form.Login_EmailAddress')>

	<cfset enc_password = #encrypt(form.Login_password, request.seedstring)#>
    
    <cfquery name = "qryCustomers" datasource = "#Request.DSN#">
    SELECT * FROM customerhistory
    WHERE EmailAddress = <cfqueryparam value="#form.Login_EmailAddress#" cfsqltype="cf_sql_varchar">
    AND CustPassword = <cfqueryparam value="#enc_password#" cfsqltype="cf_sql_varchar">
    </cfquery>

</cfif>

<cfif ISDEFINED('url.password')>
	<cfset url.password = urldecode(url.password)>

    <cfquery name = "qryCustomers" datasource = "#Request.DSN#">
    SELECT * FROM customerhistory
    WHERE EmailAddress = <cfqueryparam value="#url.emailaddress#" cfsqltype="cf_sql_varchar">
    AND CustPassword = <cfqueryparam value="#url.password#" cfsqltype="cf_sql_varchar">
    </cfquery>
</cfif>

<cfif NOT isdefined('qryCustomers')>
	<cfquery name = "qryCustomers" datasource = "#Request.DSN#">
	SELECT * FROM customerhistory
	WHERE EmailAddress = <cfqueryparam value="" cfsqltype="cf_sql_varchar">
	AND CustPassword = <cfqueryparam value="" cfsqltype="cf_sql_varchar">
	</cfquery>
</cfif>