<!---creates a new carttoken--->
<cfset charlist  = "0|2|4|6|8|9|7|5|3|1|A|C|E|H|J|K|M|P|O|Q|S|T|U|V|W|X|Y|0|2|4|6|8|9|7|5|3|1">

<!---set datetime strings to append to end of token to ensure it's unique--->
<cfset DateCreated = #dateformat(now(), "mmddyy")#>
<cfset TimeCreated = #timeformat(now(), "hhmmss")#>

<cfset theToken = "">
<cfloop condition="NOT len(theToken)">

	<cfloop from="1" to="7" index="i">
		<!--- pick a random number between 1 and the length of the list of chars to use --->
		<cfset ThisNum = RandRange(1,listlen(charlist, "|"))>
	
		<!--- get the character that is at the random numbers position in the list of characters ---> 
		<cfset ThisChar = ListGetAt(Charlist, ThisNum, "|")>
	
		<!--- append the new random character to the CustPassword ---> 
		<cfset theToken = "#theToken##ThisChar#">
	</cfloop>
	
    <cfset theToken = "#theToken##DateCreated##TimeCreated#">
    
	<!--- Make sure code is not already in use --->
    <cfquery name="qryCarts" datasource="#Request.dsn#">
    SELECT CartToken FROM shoppingcarts
    WHERE CartToken = <cfqueryparam value="#theToken#" cfsqltype="cf_sql_varchar">
    </cfquery>
    
    <!---Already used so generate another one--->
    <cfif qryCarts.RecordCount>
        <cfset theToken = "">
    </cfif>
</cfloop>

<cfset CartToken = '#theToken#'>

<cfset todaysdate = now()>

<cfquery name = "qryInsertNewCart" datasource="#request.dsn#">
INSERT INTO shoppingcarts
(CartToken, DateEntered, CheckedOut, affilID)
VALUES
(<cfqueryparam value="#CartToken#" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#createodbcdate(TodaysDate)#" cfsqltype="cf_sql_date">, 
<cfqueryparam value="No" cfsqltype="cf_sql_varchar">, 
<cfqueryparam value="#affilid#" cfsqltype="cf_sql_varchar">)
</cfquery>

<cfif request.stats_enabled IS 1>
	<cfinclude template = "#request.absolutepath#stats/stats_click.cfm">
</cfif>


<!---set the carttoken cookie so we can pull their shopping cart from the database when they go to checkout.  This cookie will expire in 1 day.
URLs to checkout should containc &cartoken=#carttoken# since cookies/sessions can be lost in some browsers when switching to https.  This ensures
that the cookies/sessions are not lost.--->
<cfcookie name="carttoken" value="#carttoken#" expires="1">


