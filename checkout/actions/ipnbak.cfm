<cfparam name = "mc_gross" default ="1.00">
<cfparam name = "invoice" default="0">
<cfparam name = "address_status" default = "unconfirmed">
<cfparam name = "payer_id" default="0">
<cfparam name = "tax" default="0.00">
<cfparam name = "address_street" default="">
<cfparam name = "payment_date" default="01/01/2007 PDT">
<cfparam name = "payment_status" default="FAILED">
<cfparam name = "charset" default = "windows-1252">
<cfparam name = "address_zip" default = "12345">
<cfparam name = "first_name" default = "">
<cfparam name = "mc_fee" default = ".00">
<cfparam name = "address_country_code" default = "US">
<cfparam name = "address_name" default = "">
<cfparam name = "notify_version" default = "2.4">
<cfparam name = "custom" default = "">
<cfparam name = "payer_status" default = "unverified">
<cfparam name = "business" default = "">
<cfparam name = "address_country" default = "United States">
<cfparam name = "address_city" default = "Ohio">
<cfparam name = "quantity" default = "1">
<cfparam name = "payer_email" default = "">
<cfparam name = "verify_sign" default = "0">
<cfparam name = "txn_id" default="0">
<cfparam name = "payment_type" default = "instant">
<cfparam name = "payer_business_name" default = "">
<cfparam name = "last_name" default = "">
<cfparam name = "address_state" default = "OH">
<cfparam name = "receiver_email" default = "">
<cfparam name = "payment_fee" default = "0.00">
<cfparam name = "receiver_id" default = "">
<cfparam name = "txn_type" default = "">
<cfparam name = "item_name" default = "Your Order">
<cfparam name = "mc_currency" default = "USD">
<cfparam name = "item_number" default = "">
<cfparam name = "residence_country" default = "US">
<cfparam name = "payment_gross" default = "1.00">
<cfparam name = "shipping" default = "0.00">
<cfparam name = "merchant_return_link" default = "Return to Merchant">
<cfparam name = "subscr_date" default = "">

<!--- read post from PayPal system and add 'cmd' --->
<CFSET str="cmd=_notify-validate">
<cfset str = str & "&mc_gross=#mc_gross#&invoice=#invoice#&address_status=#address_status#&payer_id=#payer_id#&
tax=#tax#&address_street=#address_street#&payment_date=#URLEncodedFormat(payment_date)#&payment_status=#payment_status#&charset=#charset#&address_zip=#address_zip#&first_name=#first_name#&mc_fee=#mc_fee#&address_country_code=#address_country_code#&address_name=#address_name#&notify_version=#notify_version#&custom=#custom#&payer_status=#payer_status#&business=#business#&address_country=#address_country#&address_city=#address_city#&quantity=#quantity#&payer_email=#payer_email#&verify_sign=#verify_sign#&txn_id=#txn_id#&payment_type=#payment_type#&payer_business_name=#payer_business_name#&last_name=#last_name#&address_state=#address_state#&receiver_email=#receiver_email#&payment_fee=#payment_fee#&receiver_id=#receiver_id#&txn_type=#txn_type#&item_name=#item_name#&mc_currency=#mc_currency#&item_number=#item_number#&residence_country=#residence_country#&payment_gross=#payment_gross#&shipping=#shipping#&merchant_return_link=#merchant_return_link#">

<CFIF NOT subscr_date IS ''>
   <CFSET str = str & "&subscr_date=#URLEncodedFormat(subscr_date)#">
</CFIF>

<cfset posturl = "https://www.paypal.com/cgi-bin/webscr?#str#">


<!--- post back to PayPal system to validate --->
<CFHTTP URL="#posturl#" METHOD="GET" RESOLVEURL="false">
</CFHTTP>

<cfoutput>#CFHTTP.FileContent#</cfoutput>

<cfset temporderid = #invoice#>
<cfquery name = "getCustID" datasource="#Request.dsn#">
SELECT CustomerID FROM temporders
Where OrderNumber = '#tempOrderID#'
</cfquery>

<!--- check notification validation --->
<CFIF #CFHTTP.FileContent# is "VERIFIED">
    <!--- check that payment_status=Completed --->
    <cfif payment_status eq "Completed">
	    <!--- check that receiver_email is your email address --->
     <cfif #RECEIVER_EMAIL# eq "#request.ANLogin#">
	 <cfset accpaid = "Yes">
		<cfinclude template="actInsertPermOrder.cfm">
		<!----Payment is OKAY! Update the fraud flag by one color in the database--->
		<cfquery name = "FindOrder" datasource="#request.dsn#">
			SELECT * FROM Orders
			WHERE OrderNumber = '#invoice#'
		</cfquery>

		<cfoutput query = "FindOrder">
			<cfset CurrentFlagColor = '#FraudFlag#'>
			<cfset CurrentReason = '#FraudReason#'>
		</cfoutput>

		<cfif NOT FindOrder.RecordCount IS 0>

		<!---Get the current flag color and increase it by one.  This way they will get to download
			any egoods if everything else checked out fine--->
		<cfif CurrentFlagColor IS 'Red'><cfset NewFlagColor = 'Orange'></cfif>
		<cfif CurrentFlagColor IS 'Orange'><cfset NewFlagColor = 'Yellow'></cfif>
		<cfif CurrentFlagColor IS 'Yellow'><cfset NewFlagColor = 'Green'></cfif>
		<cfif CurrentFlagColor IS 'Green'><cfset NewFlagColor = 'Green'></cfif>

		<cfset NewReason = '#CurrentReason#' & '-PayPal Payment Completed-'>
		
		<!---Update the order with the new flag color--->
		
			<cfquery name = "UpdateFraudWarning" datasource="#request.dsn#">
			UPDATE Orders 
			SET FraudFlag = '#NewFlagColor#',
			FraudReason = '#NewReason#',
			paid = 'Yes'
			WHERE OrderNumber = '#invoice#'
			</cfquery>

		</cfif>

		<cfif FindOrder.RecordCount IS 0>
			VALID<br>
			Invalid Order Number was passed back to the system.  Please contact sales to verify your order.
			<cfoutput><a href="#request.HomeURL#">Click here</a></cfoutput> to go back to our homepage.  <cfoutput>#invoice#</cfoutput>
			<cfabort>
		</cfif>					
  </cfif>
 <!--- check that payment_status=Pending --->
    <cfif payment_status eq "Pending">
    <!--- check that receiver_email is your email address --->
     <cfif #RECEIVER_EMAIL# eq "#request.ANLogin#">
	 <cfinclude template="actInsertPermOrder.cfm">
		<!----Payment is OKAY! Update the fraud flag by one color in the database--->
		<cfquery name = "FindOrder" datasource="#request.dsn#">
			SELECT * FROM Orders
			WHERE OrderNumber = '#invoice#'
		</cfquery>

		<cfoutput query = "FindOrder">
			<cfset CurrentFlagColor = '#FraudFlag#'>
			<cfset CurrentReason = '#FraudReason#'>
		</cfoutput>

		<cfif NOT FindOrder.RecordCount IS 0>

			<!---Get the current flag color and reduce it by one--->
			<cfif CurrentFlagColor IS 'Red'><cfset NewFlagColor = 'Red'></cfif>
			<cfif CurrentFlagColor IS 'Orange'><cfset NewFlagColor = 'Red'></cfif>
			<cfif CurrentFlagColor IS 'Yellow'><cfset NewFlagColor = 'Orange'></cfif>
			<cfif CurrentFlagColor IS 'Green'><cfset NewFlagColor = 'Yellow'></cfif>
			
			<cfset NewReason = '#CurrentReason#' & '-WARNING! PayPal Payment Pending!  Reason:  #pending_reason#.  DO NOT SHIP THIS ORDER YET-'>
			
			<!---Update the order with the new flag color--->
			
			<cfquery name = "UpdateFraudWarning" datasource="#request.dsn#">
			UPDATE Orders 
			SET FraudFlag = '#NewFlagColor#',
			FraudReason = '#NewReason#',
			OrderStatus = 'On Hold',
			Notes = 'Payment is pending.  Your order will not be processed until payment is received.'
			WHERE OrderNumber = '#invoice#'
			</cfquery>

		</cfif>

		<cfif FindOrder.RecordCount IS 0>
			VALID<br>
			Invalid Order Number was passed back to the system.  Please contact sales to verify your order.
			<cfoutput><a href="#request.HomeURL#">Click here</a></cfoutput> to go back to our homepage.  <cfoutput>#invoice#</cfoutput>
			<cfabort>
		</cfif>
	</cfif>					
  </cfif> 
  
  
 <!--- check that payment_status=Refunded --->
    <cfif payment_status eq "Refunded">
    <!--- check that receiver_email is your email address --->
     <cfif #RECEIVER_EMAIL# eq "#request.ANLogin#">
	 	
		<!---Set the discountamount field to the amount refunded--->
		
		<cfquery name = "FindOrder" datasource="#request.dsn#">
			SELECT * FROM Orders
			WHERE OrderNumber = '#invoice#'
		</cfquery>

		<cfset DiscountAmount = 0>

		<cfoutput query = "FindOrder">
			<cfset CurrentDiscount = #DiscountAmount#>
			<cfset CurrentMemo = #memo#>
		</cfoutput>
		
		<cfset NewDiscount = CurrentDiscount + abs(mc_gross)>
		<cfset NewMemo = '#CurrentMemo#' & ' A refund was applied to this order on #payment_date# in the amount of #abs(mc_gross)#.  The amount was applied to the discounts Column.'> 

			<cfquery name = "UpdateFraudWarning" datasource="#request.dsn#">
				UPDATE Orders 
				SET DiscountAmount = '#NewDiscount#',
				Notes = '#NewMemo#'
				WHERE OrderNumber = '#invoice#'				
		</cfquery>
	</cfif>
 </cfif>   
<!----End VERIFIED--->  
</cfif>

<CFELSEIF #CFHTTP.FileContent# is "INVALID">
<!---Set to red flag. And don't allow the download --->

	<cfquery name = "FindOrder" datasource="#request.dsn#">
		SELECT * FROM tempOrders
		WHERE OrderNumber = '#invoice#'
	</cfquery>

	<cfoutput query = "FindOrder">
		<cfset CurrentFlagColor = '#FraudFlag#'>
	</cfoutput>

	<cfif NOT FindOrder.RecordCount IS 0>
		<cfset NewFlagColor = 'Green'>

		<cfquery name = "UpdateFraudWarning" datasource="#request.dsn#">
		UPDATE Orders SET FraudFlag = '#NewFlagColor#' WHERE OrderNumber = '#invoice#'
		</cfquery>
	</cfif>

		<cfif FindOrder.RecordCount IS 0>
			INVALID
			Invalid Order Number was passed back to the system.  Please contact sales to verify your order.
			
			<a href="<cfoutput>#request.HomeURL#</cfoutput>">Click here</a> to go back to our homepage.
			<cfabort>
		</cfif>				

<CFELSEIF #CFHTTP.FileContent# is "REFUNDED">
    <!--- Set to red flag. And don't allow the download --->
	REFUNDED <cfabort>

<CFELSE>
   <!-- error -->
 
   An Error occurred while trying to process this order.  Please contact sales to verify your order was
   successful.  We appologize for the inconvenience.
   <p>
   <a href="#request.HomeURL#">Click here</a> to go back to our homepage.
   <cfabort>
</CFIF>

<cfoutput>
<cflocation url = "../../index.cfm?action=finalize&OrderNumber=#invoice#&CustomerID=#getCustID.CustomerID#">
</cfoutput>







