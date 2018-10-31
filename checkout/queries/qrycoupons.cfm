<cfquery name = "qryCoupons" datasource="#request.dsn#">
SELECT * FROM promos
<cfif ISDEFINED('form.couponcode')>
	WHERE promocode = <cfqueryparam value="#form.couponcode#" cfsqltype="cf_sql_varchar">
</cfif>
<cfif ISDEFINED('thiscoupon')>
	WHERE promocode = <cfqueryparam value="#thiscoupon#" cfsqltype="cf_sql_varchar">
</cfif>
</cfquery>







