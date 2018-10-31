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

<cflocation url = "index.cfm?action=finalize&ordernumber=#invoice#">