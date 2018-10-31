<cfscript>

function setAvsInfo(avs_street_number, avs_street_name, avs_zipcode) {
    avsInfoArray = arrayNew(1);
    avsInfoArray[1] = avs_street_number;
    avsInfoArray[2] = avs_street_name;
    avsInfoArray[3] = avs_zipcode;
    return avsInfoArray;
}

function setCvdInfo(cvd_indicator, cvd_value) {
    cvdInfoArray = arrayNew(1);
    cvdInfoArray[1] = cvd_indicator;
    cvdInfoArray[2] = cvd_value;
    return cvdInfoArray;
}

function formUsCavvPurchaseArray( orderid, amount, pan, expdate, cavv ) {
	txnArray = arrayNew(1);
	txnArray[1] = "us_cavv_purchase";
	txnArray[2] = orderid;
	txnArray[3] = amount;
	txnArray[4] = pan;
	txnArray[5] = expdate;
	txnArray[6] = cavv;
	return txnArray;
}

function formUsCavvPreauthArray( orderid, amount, pan, expdate, cavv ) {
	txnArray = arrayNew(1);
	txnArray[1] = "us_cavv_preauth";
	txnArray[2] = orderid;
	txnArray[3] = amount;
	txnArray[4] = pan;
	txnArray[5] = expdate;
	txnArray[6] = cavv;
	return txnArray;
}

function formUsPurchaseArray( orderid, amount, pan, expdate, crypttype ) {
	txnArray = arrayNew(1);
	txnArray[1] = "us_purchase";
	txnArray[2] = orderid;
	txnArray[3] = amount;
	txnArray[4] = pan;
	txnArray[5] = expdate;
	txnArray[6] = crypttype;
	return txnArray;
}

function formUsTrack2PurchaseArray( orderid, amount, track2, pan, expdate, poscode ) {
	txnArray = arrayNew(1);
	txnArray[1] = "us_track2_purchase";
	txnArray[2] = orderid;
	txnArray[3] = amount;
	txnArray[4] = track2;
	txnArray[5] = pan;
	txnArray[6] = expdate;
	txnArray[7] = poscode;
	return txnArray;
}

function formUsPreauthArray( orderid, amount, pan, expdate, crypttype ) {
	txnArray = arrayNew(1);
	txnArray[1] = "us_preauth";
	txnArray[2] = orderid;
	txnArray[3] = amount;
	txnArray[4] = pan;
	txnArray[5] = expdate;
	txnArray[6] = crypttype;
	return txnArray;
}

function formUsTrack2PreauthArray( orderid, amount, track2, pan, expdate, poscode ) {
	txnArray = arrayNew(1);
	txnArray[1] = "us_track2_preauth";
	txnArray[2] = orderid;
	txnArray[3] = amount;
	txnArray[4] = track2;
	txnArray[5] = pan;
	txnArray[6] = expdate;
	txnArray[7] = poscode;
	return txnArray;
}

function formUsCompletionArray( orderid, compamount, txnnumber, crypttype ) {
	txnArray = arrayNew(1);
	txnArray[1] = "us_completion";
	txnArray[2] = orderid;
	txnArray[3] = compamount;
	txnArray[4] = txnnumber;
	txnArray[5] = crypttype;
	return txnArray;
}

function formUsTrack2CompletionArray( orderid, compamount, txnnumber, poscode ) {
	txnArray = arrayNew(1);
	txnArray[1] = "us_track2_completion";
	txnArray[2] = orderid;
	txnArray[3] = compamount;
	txnArray[4] = txnnumber;
	txnArray[5] = poscode;
	return txnArray;
}

function formUsPurchaseCorrectionArray( orderid, txnnumber, crypttype ) {
	txnArray = arrayNew(1);
	txnArray[1] = "us_purchasecorrection";
	txnArray[2] = orderid;
	txnArray[3] = txnnumber;
	txnArray[4] = crypttype;
	return txnArray;
}

function formUsTrack2PurchaseCorrectionArray( orderid, txnnumber ) {
	txnArray = arrayNew(1);
	txnArray[1] = "us_track2_purchasecorrection";
	txnArray[2] = orderid;
	txnArray[3] = txnnumber;
	return txnArray;
}

function formUsRefundArray( orderid, amount, txnnumber, crypttype ) {
	txnArray = arrayNew(1);
	txnArray[1] = "us_refund";
	txnArray[2] = orderid;
	txnArray[3] = amount;
	txnArray[4] = txnnumber;
	txnArray[5] = crypttype;
	return txnArray;
}

function formUsTrack2RefundArray( orderid, amount, txnnumber ) {
	txnArray = arrayNew(1);
	txnArray[1] = "us_track2_refund";
	txnArray[2] = orderid;
	txnArray[3] = amount;
	txnArray[4] = txnnumber;
	return txnArray;
}

function formUsIndRefundArray( orderid, amount, pan, expdate, crypttype ) {
	txnArray = arrayNew(1);
	txnArray[1] = "us_ind_refund";
	txnArray[2] = orderid;
	txnArray[3] = amount;
	txnArray[4] = pan;
	txnArray[5] = expdate;
	txnArray[6] = crypttype;
	return txnArray;
}

function formUsTrack2IndRefundArray( orderid, amount, track2, pan, expdate, poscode ) {
	txnArray = arrayNew(1);
	txnArray[1] = "us_track2_ind_refund";
	txnArray[2] = orderid;
	txnArray[3] = amount;
	txnArray[4] = track2;
	txnArray[5] = pan;
	txnArray[6] = expdate;
	txnArray[7] = poscode;
	return txnArray;
}

function formUsTrack2ForcepostArray( orderid, amount, track2, pan, expdate, poscode, authcode ) {
	txnArray = arrayNew(1);
	txnArray[1] = "us_track2_forcepost";
	txnArray[2] = orderid;
	txnArray[3] = amount;
	txnArray[4] = track2;
	txnArray[5] = pan;
	txnArray[6] = expdate;
	txnArray[7] = poscode;
	txnArray[8] = authcode;

	return txnArray;
}

function formUsForcepostArray( orderid, amount, pan, expdate, authcode, crypttype ) {
	txnArray = arrayNew(1);
	txnArray[1] = "us_forcepost";
	txnArray[2] = orderid;
	txnArray[3] = amount;
	txnArray[4] = pan;
	txnArray[5] = expdate;
	txnArray[6] = authcode;
	txnArray[7] = crypttype;
	return txnArray;
}

function formUsAchDebitArray( orderid, amount ) {
	txnArray = arrayNew(1);
	txnArray[1] = "us_ach_debit";
	txnArray[2] = orderid;
	txnArray[3] = amount;
	return txnArray;
}

function formUsAchCreditArray( orderid, amount ) {
	txnArray = arrayNew(1);
	txnArray[1] = "us_ach_credit";
	txnArray[2] = orderid;
	txnArray[3] = amount;
	return txnArray;
}

function formUsAchReversalArray( orderid, txnnumber ) {
	txnArray = arrayNew(1);
	txnArray[1] = "us_ach_reversal";
	txnArray[2] = orderid;
	txnArray[3] = txnnumber;
	return txnArray;
}

function formUsAchFiEnquiryArray( routingnum ) {
	txnArray = arrayNew(1);
	txnArray[1] = "us_ach_fi_enquiry";
	txnArray[2] = routingnum;
	return txnArray;
}

function formUsPinlessDebitPurchaseArray( orderid, amount, pan, presentation_type, intended_use, p_account_number ) {
	txnArray = arrayNew(1);
	txnArray[1] = "us_pinless_debit_purchase";
	txnArray[2] = orderid;
	txnArray[3] = amount;
	txnArray[4] = pan;
	txnArray[5] = presentation_type;
	txnArray[6] = intended_use;
	txnArray[7] = p_account_number;
	return txnArray;
}

function formUsPinlessDebitRefundArray( orderid, txnnumber ) {
	txnArray = arrayNew(1);
	txnArray[1] = "us_pinless_debit_refund";
	txnArray[2] = orderid;
	txnArray[3] = txnnumber;
	return txnArray;
}

function formUsBatchCloseArray( ecr ) {
	txnArray = arrayNew(1);
	txnArray[1] = "us_batchclose";
	txnArray[2] = ecr;
	return txnArray;
}

function formUsOpenTotalsArray( ecr ) {
	txnArray = arrayNew(1);
	txnArray[1] = "us_opentotals";
	txnArray[2] = ecr;
	return txnArray;
}

function formUsRecurUpdateArray( orderid ) {
	txnArray = arrayNew(1);
	txnArray[1] = "us_recur_update";
	txnArray[2] = orderid;
	return txnArray;
}

function setUsBilling( first_name, last_name, company_name, address, city, province, postal_code, country, phone_number, fax, tax1, tax2, tax3, shipping_cost ) {
	billingArray = arrayNew(1);
	billingArray[1] = first_name;
	billingArray[2] = last_name;
	billingArray[3] = company_name;
	billingArray[4] = address;
	billingArray[5] = city;
	billingArray[6] = province;
	billingArray[7] = postal_code;
	billingArray[8] = country;
	billingArray[9] = phone_number;
	billingArray[10] = fax;
	billingArray[11] = tax1;
	billingArray[12] = tax2;
	billingArray[13] = tax3;
	billingArray[14] = shipping_cost;
	return billingArray;
}

function setUsShipping( first_name, last_name, company_name, address, city, province, postal_code, country, phone_number, fax, tax1, tax2, tax3, shipping_cost ) {
	shippingArray = arrayNew(1);
	shippingArray[1] = first_name;
	shippingArray[2] = last_name;
	shippingArray[3] = company_name;
	shippingArray[4] = address;
	shippingArray[5] = city;
	shippingArray[6] = province;
	shippingArray[7] = postal_code;
	shippingArray[8] = country;
	shippingArray[9] = phone_number;
	shippingArray[10] = fax;
	shippingArray[11] = tax1;
	shippingArray[12] = tax2;
	shippingArray[13] = tax3;
	shippingArray[14] = shipping_cost;
	return shippingArray;
}

function setUsEmail( email ) {
	emailArray = arrayNew(1);
	emailArray[1]= email;
	return emailArray;
}

function setUsInstructions( instruction ) {
	instructionArray = arrayNew(1);
	instructionArray[1] = instruction;
	return instructionArray;
}

function setUsItem( name, quantity, product_code, extended_amount ) {
	itemArray = arrayNew(1);
	itemArray[1] = name;
	itemArray[2] = quantity;
	itemArray[3] = product_code;
	itemArray[4] = extended_amount;
	return itemArray;
}

function formUsRecurArray( recur_unit, start_now, start_date, num_recurs, period, recur_amount ) {
	recurArray = arrayNew(1);
	recurArray[1] = recur_unit;
	recurArray[2] = start_now;
	recurArray[3] = start_date;
	recurArray[4] = num_recurs;
	recurArray[5] = period;
	recurArray[6] = recur_amount;
	return recurArray;
}

function setAchInfoArray( sec, cust_first_name, cust_last_name, cust_address1, cust_address2, cust_city, cust_state, cust_zip, routing_num, account_num, check_num, account_type, micr) {
	achInfoArray = arrayNew(1);
	achInfoArray[1] = sec;
	achInfoArray[2] = cust_first_name;
	achInfoArray[3] = cust_last_name;
	achInfoArray[4] = cust_address1;
	achInfoArray[5] = cust_address2;
	achInfoArray[6] = cust_city;
	achInfoArray[7] = cust_state;
	achInfoArray[8] = cust_zip;
	achInfoArray[9] = routing_num;
	achInfoArray[10] = account_num;
	achInfoArray[11] = check_num;
	achInfoArray[12] = account_type;
	achInfoArray[13] = micr;
	return achInfoArray;
}

</cfscript>



