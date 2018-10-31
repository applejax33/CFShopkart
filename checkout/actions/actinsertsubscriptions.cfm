<!---Checks for subscription items and inserts info about each.--->

<cflock scope="Session" type="EXCLUSIVE" timeout="10">
	<cfoutput>
		<cfset cart.CrtProductID = '#session.CrtProductID#'>
        <cfset cart.CrtProductName = '#session.CrtProductName#'>
        <cfset cart.CrtQuantity = '#session.CrtQuantity#'>
        <cfset cart.CrtPrice = '#session.CrtPrice#'>
        <cfset cart.CrtWeight = '#session.CrtWeight#'>
        <cfset Cart.CrtThumbNails = '#session.CrtThumbNails#'>
        <cfset Cart.CrtItemID = '#session.CrtItemID#'>
        <cfset Cart.CrtType = '#session.CrtType#'>
        <cfset Cart.CrtApproved = '#session.CrtApproved#'>
    </cfoutput>
</cflock>

<cfset TodaysDate = now()>

<!---remove any that were inserted matching this order number just in case the went back or refreshed.--->
<cfquery name = "qRemoveAnyDups" datasource="#request.dsn#">
DELETE FROM customers_subscriptions
WHERE customerid = #customerid# AND 
ordernumber = '#form.ordernumber#'
</cfquery>

<!---See if any products ordered are subscription items--->
<cfloop index="IndexCount" from="1" To="#ListLen(cart.CrtItemID, "^")#">
   <cfset ThisItemID = #ListGetAt(cart.CrtItemID, IndexCount, "^")#>
   
	   <cfquery name = "qryProductsForSubs" datasource="#request.dsn#">
		  SELECT * FROM products
		  WHERE ItemID = #ThisItemID#
	   </cfquery>
   
		<cfif qryProductsForSubs.IsSubscription IS 'Yes'>
			
			<!---If this is a subscription item, then find the info in the subscriptions product table (which should be there)--->
			<cfquery name="qrySubscriptionItems" datasource="#request.dsn#">
				SELECT * FROM products_subscriptions
				WHERE itemid = '#ThisItemID#'
			</cfquery>
			
			<!---determine what date it will expire on--->
			<cfset expiremonth = #dateformat(DateAdd("m", 1, TodaysDate), "mm/dd/yyyy")#>
			<!---check to see when subscription will expire--->
			<cfif qrySubscriptionItems.r_expiresin IS '3 Days'>
				<cfset expiredate = #dateformat(DateAdd("d", 3, TodaysDate), "mm/dd/yyyy")#>
			</cfif>
			<cfif qrySubscriptionItems.r_expiresin IS '1 Week'>
				<cfset expiredate = #dateformat(DateAdd("d", 7, TodaysDate), "mm/dd/yyyy")#>
			</cfif>
			<cfif qrySubscriptionItems.r_expiresin IS '1 Month'>
				<cfset expiredate = #dateformat(DateAdd("m", 1, TodaysDate), "mm/dd/yyyy")#>
			</cfif>
			<cfif qrySubscriptionItems.r_expiresin IS '3 Monts'>
				<cfset expiredate = #dateformat(DateAdd("m", 3, TodaysDate), "mm/dd/yyyy")#>
			</cfif>
			<cfif qrySubscriptionItems.r_expiresin IS '6 Months'>
				<cfset expiredate = #dateformat(DateAdd("m", 6, TodaysDate), "mm/dd/yyyy")#>
			</cfif>
			<cfif qrySubscriptionItems.r_expiresin IS '1 Year'>
				<cfset expiredate = #dateformat(DateAdd("y", 1, TodaysDate), "mm/dd/yyyy")#>
			</cfif>                
			<cfif qrySubscriptionItems.r_expiresin IS '2 Years'>
				<cfset expiredate = #dateformat(DateAdd("y", 2, TodaysDate), "mm/dd/yyyy")#>
			</cfif>                                                      
			<cfif qrySubscriptionItems.r_expiresin IS 'Never'>
				<cfset expiredate = #dateformat(DateAdd("y", 100, TodaysDate), "mm/dd/yyyy")#>
			</cfif>
			
			<cfset todaystime = now()>
			<cfset todaystime = timeformat(todaystime, "hh:mm:ss tt")>
			<cfset expiretime = todaystime>
			
			<cfset TodaysDate = '#todaysdate# #todaystime#'>
			<cfset expiredate = '#expiredate# #expiretime#'>

			<cfquery name = "InsertSubscriber" datasource="#request.dsn#">
			INSERT INTO customers_subscriptions
			(r_id, customerid, startdate, status, ordernumber, expiredate, subscription_length)
			VALUES
			('#qrySubscriptionItems.r_id#', '#CustomerID#', #createodbcdatetime(TodaysDate)#, 'Pending', '#form.ordernumber#', #createodbcdatetime(expiredate)#, '#qrySubscriptionItems.r_expiresin#')
			</cfquery>

		</cfif>		
 </cfloop>