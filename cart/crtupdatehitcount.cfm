<cfparam name = "url.itemid" default="0" type="integer">
<cfparam name = "NewTimesViewed" default="0" type="integer">

<cfquery name = "UpdateHitCount" datasource="#request.dsn#">
UPDATE products 
SET TimesViewed = <cfqueryparam value="#NewTimesViewed#" cfsqltype="cf_sql_varchar">
WHERE ItemID = <cfqueryparam value="#url.itemid#" cfsqltype="cf_sql_integer"> 
</cfquery>



