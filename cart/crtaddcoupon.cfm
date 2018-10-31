<!---See if the coupon code was already used on this order.  If so, don't allow it to be added
	again--->

<cfset IsDuplicate = 'No'>

<cfloop from = "1" To="#ListLen(cart.CrtCoupons, '^')#" index="CouponsCounter">
	<cfset ThisCouponCode = '#ListGetAt(Cart.CrtCoupons, CouponsCounter, "^")#'>
	<cfif ThisCouponCode IS #couponcode#>
	  <cfset CouponError = 'Coupon Code ' & #couponcode# & ' is already included on this order.'>
	  <cfset IsDuplicate = 'Yes'>
	</cfif>
</cfloop>

<cfif IsDuplicate IS 'No'>

<!---Check to see if the coupon code is a valid one--->	
<cfinclude template = '../queries/qrycoupons.cfm'>

<cfif qryCoupons.recordcount IS 0>
	<cfset CouponError = 'Coupon Code ' & #couponcode# & ' not found'>
</cfif>

<cfif NOT qryCoupons.recordcount IS 0>
	<cfset CurrentDate = now()>
	<!---See if it has expired.  If not, then add it, if so give an error--->
	<cfif CurrentDate GT #qryCoupons.ExpiresOn#>
		<!---It's expired so don't add it--->
		<cfset CouponError = 'Sorry, the coupon Code ' & #couponcode# & ' cannot be used.  <br>It expired on #dateformat(qryCoupons.ExpiresOn, "mm/dd/yyyy")#'>
	</cfif>
	<cfif CurrentDate LTE #qryCoupons.ExpiresOn#>
		<!---It's not expired so check and see if the timesallowed value is more than 0--->
		<cfif qryCoupons.TimesAllowed GT 0>
			<!---See if this one can be combined with other offers.  If so put the new code 
					at the beginning of the list.  If not, remove all other ones--->
			<cfif qryCoupons.CanBeCombined IS 'No'>
				<cfset CouponError = 'The coupon code entered cannot be combined with other coupon codes.'>	
				<cfset cart.CrtCoupons = '#couponcode#'>
			<cfelse>
				<cfset cart.CrtCoupons = #ListPrepend(cart.CrtCoupons, couponcode, '^')#>
                
                <!---check to see if this a coupon for a certain item, if so set a variable for end of cart update to add the
				item to the shopping cart--->
                
                <cfif NOT qryCoupons.productid IS '0'>
                	<cfset itemtoadd = qrycoupons.productid>
                </cfif>
                
			</cfif>				
		<cfelse>
			<!---It's been used up already so don't add it--->
			<cfset CouponError = 'Sorry, the coupon Code ' & #couponcode# & ' cannot be used.  <br>It has reached the limit on the number of times it can be used.'>			
		</cfif>
	</cfif>
</cfif>
</cfif>



