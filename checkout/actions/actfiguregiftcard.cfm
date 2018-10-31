<!---Figure in the amount to take off based on what is left on the gift card.  If the amount off 
is more then the amount of the order then set the gift card equal to the amount of the order.
Note:  This does not reduce the amount for shipping if there is any--->

<cfif NOT len(giftcode) IS 0>
	<cfinclude template = "../queries/qrygiftcards.cfm">
    
    <!---If a gift codes matches then process it--->
    <cfif qryGiftCards.recordcount GT 0>
	
		<cfoutput query = "qryGiftCards">
			<cfset AmountLeft = gAmountLeft>
			<cfset gBalance = gAmountLeft>
			<cfset gMessage = '<em>You will have a $#gBalance# balance after this order</em>---> &nbsp;&nbsp; Gift Card'>
		</cfoutput>
		
		<!---If the amount left is more than the subtotal then set the GiftCardTotal to the sub total--->
		<cfif AmountLeft GT GiftSubTotal OR AmountLeft IS GiftSubTotal>
			<cfset GiftCardTotal = '#GiftSubTotal#'>
			<cfset gBalance = Amountleft - GiftCardTotal>
			<cfset gMessage = '<em>You will have a $#gBalance# balance after this order</em>---> &nbsp;&nbsp; Gift Card'>
		</cfif>
		
		<cfif AmountLeft LT GiftSubTotal>
			<cfset GiftCardTotal = AmountLeft>
			<cfset gBalance = 0.00>
			<cfset gMessage = '<em>You have a $#gBalance# balance after this order</em>---> &nbsp;&nbsp; Gift Card'>
		</cfif>
	</cfif>
</cfif>







