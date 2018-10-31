<cfquery name = "qryGiftCards" datasource="#request.dsn#">
SELECT * FROM giftcards
<cfif isdefined('giftcode')>
	WHERE gNumber = <cfqueryparam value="#giftcode#" cfsqltype="cf_sql_varchar"> 
    AND activated = <cfqueryparam value="Yes" cfsqltype="cf_sql_varchar">
<cfelse>
	WHERE activated = <cfqueryparam value="Yes" cfsqltype="cf_sql_varchar">
</cfif>
</cfquery>








