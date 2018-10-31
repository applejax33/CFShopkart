<!---handles subscription payments using anarb.cfm for Authorize.net--->
<!---if the above passes, see if there are any subscriptions that need to be setup--->
<cfif processor_error IS 'No'>

	<cfif var_istest IS 'false'>
    	<cfset testmode = 'live'>
    <cfelse>
    	<cfset testmode = 'test'>
    </cfif>

	<cfif form.SubscriptionTotal GT 0>
    
		<cfset PaymentGateway = CreateObject("component","anarb").init(
            loginname = "#var_user#",
            transactionKey = "#var_trans#",
            mode = "#testmode#")>
        
        <cfset subscriptionname = "Membership Subscription">
        <cfset orderdescription = "#TheCompanyName# Membership">
        
        <cfset total_charge_today = form.ordertotal><!---not used here, because authorize.net doesn't bill subscription in realtime, we do that through AIM above using form.ordertotal--->
        <cfset total_recur_fee = 0>
        
        <!---get the total recurring fee to charge for this order--->
        <cfloop list="#form.subscription_items#" index="sitem_id">
            <cfquery name = "qGetSubInfo" datasource="#request.dsn#">
            SELECT * FROM products_subscriptions WHERE itemid = '#sitem_id#'
            </cfquery>
        
            <cfoutput query = "qGetSubInfo">
                <cfset total_recur_fee = total_recur_fee + r_fee>
               
                <cfif r_frequency IS 'M'>
                    <cfset recur_period = '1'>
                <cfelse>
                    <cfset recur_period = '12'>
                </cfif>
                
            </cfoutput>
        </cfloop>
        
        <cfset total_recur_fee = #NumberFormat(total_recur_fee, '_0.00')#>
        <cfset total_charge_today = #NumberFormat(total_charge_today, '0.00')#>
		
        <!---figure up when this will start (if they are on the monthly it will be 1 month from now, annual will be 12 months from now, etc. -- Authorize.net only calculates in days and months so
		12 months = a year.)--->
        <cfset bill_start_date = DateFormat(DateAdd("m",recur_period,Now()),"yyyy-mm-dd")>

		<!---Note:  the subscription will begin being billed the specified time from today because they have been charged
		for their membership above in realtime for the current period (it's included in their order total)--->
                
        <cfinvoke component="#PaymentGateway#" method="createSubscription" returnvariable="result">
            <cfinvokeargument name="RefID" value="#form.ordernumber#">        
            <cfinvokeargument name="startDate" value="#bill_start_date#">
            <cfinvokeargument name="customerEmail" value="#form.emailaddress#">
            <cfinvokeargument name="billFirstName" value="#form.bill_firstname#">
            <cfinvokeargument name="billLastName" value="#form.bill_lastname#">
            <cfinvokeargument name="billAddress" value="#form.bill_address#">
            <cfinvokeargument name="billCity" value="#form.bill_city#">
            <cfinvokeargument name="billState" value="#form.bill_state#">
            <cfinvokeargument name="billZip" value="#form.bill_zip#">
            <cfinvokeargument name="shipFirstName" value="#form.ship_firstname#">
            <cfinvokeargument name="shipLastName" value="#form.ship_lastname#">
            <cfinvokeargument name="shipAddress" value="#form.ship_address#">
            <cfinvokeargument name="shipCity" value="#form.ship_city#">
            <cfinvokeargument name="shipState" value="#form.ship_state#">
            <cfinvokeargument name="shipZip" value="#form.ship_zip#">
        
            <cfinvokeargument name="amount" value="#total_recur_fee#">
            <cfinvokeargument name="subscriptionName" value="#subscriptionname#">
            <cfinvokeargument name="orderDescription" value="#orderdescription#">
            <cfinvokeargument name="totalOccurrences" value="9999">
            <cfinvokeargument name="paymentIntervalLength" value="#recur_period#">
 
            <cfinvokeargument name="cardNumber" value="#form.card_number#">
            <cfinvokeargument name="cardCode" value="#form.card_cvs#">
            <cfinvokeargument name="expirationDate" value="#form.card_expyear#-#form.card_expmonth#">
        
        </cfinvoke>

		<!---if success them mark subscription as paying--->
        <!---note:  if their card was charged above for setup fee/other items on their order, then it stands to reason the charge should go through for the subscription.
		Therefore, I put a backup here to abort if the subscription for some odd reason fails, but the gateway should return a success message if the card is valid.  So I update
		the payment_status for the subscription to show it went through and the card is being billed.--->
        
        <cfdump var="#result#">

		<cfset wassuberror = 'Yes'>
                
        <cfif result.messagetext CONTAINS 'Successful'>
        	<cfquery name = "qSetSubscription" datasource="#request.dsn#">
            UPDATE customers_subscriptions SET payment_status = 'Paying'
            WHERE ordernumber = '#form.ordernumber#'
            </cfquery>
			<cfset wassuberror = 'No'>
		</cfif>
        <cfif result.messagecode IS 'E00012'>
        	<!---if by some change they go back and resubmit, authorize.net lets us know of duplicates so we just ingore and update it as paying--->
        	<cfquery name = "qSetSubscription" datasource="#request.dsn#">
            UPDATE customers_subscriptions SET payment_status = 'Paying'
            WHERE ordernumber = '#form.ordernumber#'
            </cfquery>
            <cfset wassuberror = 'No'>
		</cfif>
        <cfif wassuberror IS 'Yes'>
        	<cfquery name = "qSetSubscription" datasource="#request.dsn#">
            UPDATE customers_subscriptions SET payment_status = 'Failed'
            WHERE ordernumber = '#form.ordernumber#'
            </cfquery>
            
            <center><font color="#FF0000"><strong>Your credit card could not be charged the subscription fee.  Please contact us for further assistance.</strong></font></center>
            <cfabort>
        </cfif>

	</cfif>

</cfif>