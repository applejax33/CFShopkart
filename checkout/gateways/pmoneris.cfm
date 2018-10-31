<cfinclude template="USmpgAPIFunctions.cfm">

<cfset avs_street_number =  listgetat(form.bill_address, 1, " ")>
<cfset avs_street_name = listgetat(form.bill_address, 2, " ")>
<cfset avs_zipcode = form.bill_zip>
<cfif var_usecvs IS 0>
	<cfset cvd_indicator = "0">
<cfelse>
	<cfset cvd_indicator = "1">
</cfif>    
<cfset cvd_value = form.card_cvs>

<cfset order_id = '#form.ordernumber#'>
<cfset startdate = now()>
<cfset startdate = dateadd("m", 1, startdate)>
<cfset startdate = dateformat(startdate, "yyyy/mm/dd")>

<!---append time stamp to the order_id so no duplicates are made at Moneris.  This way if the transaction fails they can go back and try again without the duplicate order
error message ocurring--->

<cfset ordertimestamp = now()>
<cfset ordertimestamp = timeformat(ordertimestamp, "hhmmss")>
<cfset order_id = '#order_id#-#ordertimestamp#'>

<cfif form.SubscriptionTotal IS 0>
	<!---for basic transactions--->
    <!---charge the card and setup a recuring fee through Moneris--->
    
    <cfset avsInfo = setAvsInfo(avs_street_number, avs_street_name, avs_zipcode)>
    <cfset cvdInfo = setCvdInfo(cvd_indicator, cvd_value)>
    <cfset myTxn = formUsPurchaseArray( "#order_id#", "#total_charge_today#", "#form.card_number#", "#CCExpireDate#", "7" )>
    
    <CF_USmpgAPI_CF5 host="https://esplusqa.moneris.com/gateway_us/servlet/MpgRequest" store_id="#var_user#" api_token="#var_trans#" txn_array="#myTxn#" cust_id="#form.customerid#" avs_info_array="#avsInfo#" cvd_info_array="#cvdInfo#">
</cfif>

<!----for subscription items--->
<cfif form.SubscriptionTotal GT 0>

	<cfset total_charge_today = form.ordertotal>
    <cfset total_recur_fee = 0>
    
    <!---get the total recurring fee to charge for this order--->
    <cfloop list="#form.subscription_items#" index="sitem_id">
        <cfquery name = "qGetSubInfo" datasource="#request.dsn#">
        SELECT * FROm products_subscriptions WHERE itemid = '#sitem_id#'
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
    
    <cfset short_expyear = right(form.card_expyear, 2)>
    <cfset CCExpireDate = '#short_expyear##form.card_expmonth#'>
    
    <cfset total_recur_fee = #NumberFormat(total_recur_fee, '_0.00')#>
    <cfset total_charge_today = #NumberFormat(total_charge_today, '0.00')#>
    
    <cfset avsInfo = setAvsInfo(avs_street_number, avs_street_name, avs_zipcode)>
    <cfset cvdInfo = setCvdInfo(cvd_indicator, cvd_value)>
    
    <!---charge the card and setup a recuring fee through Moneris--->
    <cfset myTxn = formUsPurchaseArray( "#order_id#", "#total_charge_today#", "#form.card_number#", "#CCExpireDate#", "7" )>
    <cfset myRecur = formUsRecurArray("month", "true", "#startdate#", "99", "#recur_period#", "#total_recur_fee#" )>
    
    <CF_USmpgAPI_CF5 host="https://esplusqa.moneris.com/gateway_us/servlet/MpgRequest" store_id="#var_user#" api_token="#var_trans#" txn_array="#myTxn#" cust_id="#form.customerid#" recur="#myRecur#"  avs_info_array="#avsInfo#" cvd_info_array="#cvdInfo#">
    
</cfif>

<cfif NOT isdefined('response_struct')>
	<center><strong>A Connection error occurred or this merchant is not correct setup with Moneris.  Please contact the store owner or website administrator for assistance.</strong></center>
     <cfset processor_error = "Yes">
<cfelse>

	<cfif response_struct.responsecode LT 50>
    	 
		 <cfset processor_error = "No">
         
            <cfquery name = "UpdateOrderPaid" datasource="#request.dsn#">
            UPDATE orders
            SET paid = 'Yes'
            WHERE OrderNumber = '#form.OrderNumber#'
            </cfquery>         
         
         <cfelse>
         
          <cfset processor_error = "Yes">
          
          <center><div style="color: #FF0000; font-weight: bold; font-size: 14pt; margin-top: 15px;">Problem processing your credit card</div>
          <p style="font-size: 12pt;">There was a problem processing your card.  <br />
          The message returned from the gateway was: <cfoutput><strong>#reesponse.struct.message#</strong>
		  </cfoutput>
         </p>
         Please use your browsers back button and check your entries.
         </center>
    </cfif> 

</cfif>







