<cfquery name = "qryGiftCard" datasource="#request.dsn#">
SELECT * FROM giftcards
<cfif isdefined('form.giftcodecheck')>
	WHERE gNumber = <cfqueryparam value="#form.giftcodecheck#" cfsqltype="cf_sql_varchar">
</cfif>
</cfquery>




