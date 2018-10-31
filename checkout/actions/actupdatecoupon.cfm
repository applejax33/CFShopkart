<!---Updates the times a coupon is allowed to be used (called from frmFinalize.cfm)--->
<cfif ISDEFINED('thiscoupon')>
	<cfquery name = "qryUpdateCoupon" datasource="#request.dsn#">
	UPDATE promos 
	SET TimesAllowed = '#NewTimesAllowed#'
	WHERE promocode = '#thiscoupon#'
	</cfquery>
</cfif>







