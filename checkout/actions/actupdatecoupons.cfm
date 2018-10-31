<cfinclude template = "../queries/qryshoppingcarts.cfm">

<cfif NOT #ListLen(qryShoppingCarts.crtCoupons, "^")# IS 0>
	<cfloop from="1" to="#ListLen(qryShoppingCarts.crtCoupons, '^')#" index="couponcount">
		<cfset ThisCoupon = #ListGetAt(qryShoppingCarts.crtCoupons, couponcount, '^')#>
		<cfinclude template = "../queries/qrycoupons.cfm">
		<cfset NewTimesAllowed = #qryCoupons.TimesAllowed# - 1>
		<cfinclude template = "../actions/actupdatecoupon.cfm">
	</cfloop>
</cfif>