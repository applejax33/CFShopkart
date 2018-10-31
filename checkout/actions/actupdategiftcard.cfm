<!---Update gift card balance if one was applied to this order (and it wasn't already applied)--->
<cfif NOT qryorders.giftCardUpdated IS 'Yes'>
<cfif len(qryorders.giftcode) GT 0>
	<cfquery name = "qryGiftCard" datasource="#request.dsn#">
	SELECT * FROM giftcards
	WHERE gNumber = '#qryorders.giftcode#'
	</cfquery>
	
	<cfoutput query = "qryGiftCard">
		<cfset beforebalance = gAmountLeft>
	</cfoutput>

	<cfif qryGiftCard.recordcount GT 0>
		<cfif NOT len(qryorders.giftamountused) IS 0>
			<cfset giftBalance = beforebalance - qryorders.giftamountused>
			
			<cfquery name = "qUpdateGiftCode" datasource="#request.dsn#">
			UPDATE giftcards SET gAmountLeft = '#giftbalance#'
			WHERE gNumber = '#qryorders.giftcode#'
			</cfquery>

			<cfquery name = "qUpdateGiftStatus" datasource="#request.dsn#">
			UPDATE orders SET GiftCardUpdated = 'Yes'
			WHERE ordernumber = '#OrderNumber#'
			</cfquery>
		
		</cfif>
	</cfif>
</cfif>
</cfif>