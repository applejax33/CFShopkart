<cfquery name="qryImages" datasource="#request.dsn#">
SELECT * FROM afl_banners
<cfif ISDEFINED('url.ID')>
	WHERE ImageID = <cfqueryparam value="#url.ID#" cfsqltype="cf_sql_integer"> 
</cfif>
</cfquery>

