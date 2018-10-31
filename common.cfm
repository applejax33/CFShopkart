<!---This file consists of common variables and settings that are checked for with each request--->
<cfparam name="affilid" default="0">

<!--- Set today's date --->
<cfset todaysdate = dateformat(now(),"yyyy-mm-dd")>

<cfset request.HideServerSettings = 'No'>
<cfset request.HideUPSSettings = 'No'>
<cfset request.HideFEDEXSettings = 'No'>

<!---Variables from older versions that might still be used somewhere.
I left them in to prevent errors (UE is no longer officially supported)--->
<cfset request.HideUplinkEarthPassword = 'No'>
<cfset request.HideServerSettings = 'No'>
<cfset request.HideUPSSettings = 'No'>

<!---dsn username/Password to null because I included some code 
from SE that I'm working on and it uses these variables--->
<cfset request.dsnun = ''>
<cfset request.dsnpw = ''>

<!---affiliate check--->
<cfif isdefined('url.affilid')>
	<cflock scope="session" timeout="10" type="exclusive">
    	<cfset session.aid = url.affilid>
        <cfset session.affilid = url.affilid>
    </cflock>
    
	<cflock scope="session" timeout="10" type="readonly">
    	<cfset temp_aid = session.aid>
        <cfset temp_affilid = session.affilid>
    </cflock>
      
    <!---update clicks--->
    <cfquery name = "qClicks" datasource="#request.dsn#">
    SELECT * FROM afl_affiliates
    WHERE affiliateid = <cfqueryparam value="#temp_aid#" cfsqltype="cf_sql_varchar">
    </cfquery>
    
    <cfif qClicks.recordcount GT 0>
    	<cfoutput query = "qClicks" maxrows="2">
        	<cfset current_clicks = qClicks.hits>
        </cfoutput>
    
    	<cfset newclick = current_clicks + 1>
       
       	<cfquery name = "qUpdateClicks" datasource="#request.dsn#">
        UPDATE afl_affiliates
        SET hits = #newclick#
        WHERE affiliateid = <cfqueryparam value="#temp_aid#" cfsqltype="cf_sql_varchar">
        </cfquery>
    </cfif>
    
<cfelse>
	<cfif NOT isdefined('session.aid')>
        <cflock scope="session" timeout="10" type="exclusive">
            <cfset session.aid = affilid>
        </cflock>
	</cfif>
</cfif>

<!---This value below can maniplulate the indent of categories in the drop down box.  
This was used with the old directorytotree tag and is not really relevant anymore.  
It is still here incase someone finds a use for it or it's referenced somewhere in the code and I
missed the reference.--->
<cfset request.CategoryIndent = '2'>

<cfinclude template = "config/settings.cfm">

<cflock scope="application" type="readonly" timeout="10">
	<cfset oldlocale = SetLocale("#request.location#")>
</cflock>

<!---Carttoken Check--->
<cfinclude template = "cart/crtchecktoken.cfm">

<cfinclude template = "queries/qrywidgets.cfm">

<!---variables left in for backward compantability--->
<cfset request.ServiceProvider = "CF Shopkart">
<cfset request.ProviderURL = "http://www.cfshopkart.com/">
<cfset request.UseClassicImageManager = 'No'>

<!---check if site is password protected.  If so then set action to login--->
<cfif request.passwordsite IS 'Yes'>
	<cfinclude template = "actions/actchecklogin.cfm">
</cfif>

<!---check for pricing level for this visitor (default is 0)--->

<cfset request.pricinglevel = 0>

<cfif ISDEFINED('cookie.CustEmail')>
	<cfquery name = "qCustomer" datasource="#request.dsn#">
	SELECT * FROM customerhistory
	WHERE emailaddress = <cfqueryparam value="#cookie.CustEmail#" cfsqltype="cf_sql_varchar">
	</cfquery>

	<cfoutput query = "qCustomer">
		<cfif qCustomer.pricelevel GT 0>
        	<cfset request.pricinglevel = qcustomer.pricelevel>
        </cfif>
	</cfoutput>
</cfif>

<!---check for htacess file, if missing create it--->
<cfif NOT fileexists('#request.catalogpath#.htaccess')>
	<cffile action = "read" file="#request.catalogpath#config#request.bslash#defaulthtaccess.cfm" variable="htfile">
    <cffile action = "write" file="#request.catalogpath#.htaccess" output="#htfile#" mode="666">
</cfif>