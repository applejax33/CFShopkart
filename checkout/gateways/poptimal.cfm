<!---this an outdated processor, but here if anyone needs it.  Firepay is now Optimal Payments--->

<cfoutput>
<!---convert amount to integer--->
<cfset theamount = #numberformat(form.OrderTotal, '0.00')# * 100>

<cf_firepay_cvd
      debug = "#var_istest#"
      cvdIndicator="1"
      cvdValue="#trim(form.card_cvs)#"
      amount="#theamount#"
      cardNumber="#form.card_number#"
      cardMonth="#form.card_expmonth#"
      cardYear="#right(form.card_expyear, 2)#"
      cardType="#form.card_type#"
      customerName="#form.bill_firstname# #form.bill_lastname#"
      streetAddr="#form.bill_address#"
      streetAddr2="#form.bill_address2#"
      phone="#form.bill_phone#"
      email="#form.emailaddress#"
      city="#form.bill_city#"
      province="#form.bill_state#"
      country="#form.bill_country#"
      zip="#UCase(form.bill_zip)#"
      account="#var_custom#"
      merchantId="#var_id#"
      merchantPwd="#var_pass#"
      merchantTxn="#form.orderNumber#"
      merchantData="#form.orderNumber#"
      userData04="">
</cfoutput>

<cfswitch expression="#response.status#">
    <cfcase value="SP">
        Transaction Approved
        <cfset processor_error = "No">

        <cfquery name = "UpdateOrderPaid" datasource="#request.dsn#">
        UPDATE orders
        SET paid = 'Yes'
        WHERE OrderNumber = '#form.OrderNumber#'
        </cfquery>
        
    </cfcase>
    <cfcase value="E">
    <cfset processor_error = "Yes">
        <cfoutput>
          <table width="540" border="0" cellpadding="3" cellspacing="0" bgcolor=white align=center>
            <tr>
              <td bgcolor="red"><font color="##000000" face="Verdana, Arial, Helvetica, sans-serif" size="2">&nbsp;</font></td>
            </tr>
            <tr>
              <td bgcolor="red">
                <table width="100%" border="0" cellspacing="1" cellpadding="3" bgcolor=black align=center>
                    <tr>
                      <td bgcolor="##FFFFFF" valign=top>
                          <p>
                          <font face="Verdana, Arial, Helvetica, sans-serif" size="2">
                          <p><font color=red><strong>PROBLEM WITH PAYMENT PROCESSING</strong></font></p>
                          <cfif URLDecode(response.ERRCODE) IS 212>
                              <span style="color:red; font-weight:bold;">
                              <p style="background-color:yellow;">DO NOT RETRY THIS TRANSACTION <br />until you have read the below information!</p><p style="background-color:yellow;">Please call your credit card company (the number is on the back of your card) and confirm that you are entering the EXACT billing address they have on file for the card you are using.<br /><br />As an anti-fraud measure, the credit card company will list this transaction (and and any further transactions with incorrect billing information) as a successful, completed transaction and the funds will be held for 5 to 7 business day.  After this time the hold(s) will be removed and the funds will become available again.</p><p style="background-color:yellow;">Please note that this payment was not completed successfully and YOUR REGISTRATION IS NOT COMPLETE!</p>
                              </span>
                          <cfelse>
                              <p>There was a problem while processing your transaction.<br /><br />Please read the below details.</p>
                          </cfif>
                          <p>STATUS: #URLDecode(response.ERRSTRING)#
                          <br>DESCRIPTION: <cfif isDefined("response.SUBERRORSTRING")><b>#URLDecode(response.SUBERRORSTRING)#</b><cfelse>---</cfif>
                          <br>ERRCODE: #URLDecode(response.ERRCODE)#
                              <cfif URLDecode(response.ERRCODE) IS 34 OR URLDecode(response.ERRCODE) IS 221>
                              <br><span style="font-weight:bold; background-color:lime;">NOTE: Your payment has been refused by the card issuing bank.  Please call the number on the back of your credit card and ask them to allow the transaction.  You will then be able to process your payment without further troubles.</span>

                              </cfif>
                          <br>DATE/TIME: #timeFormat(NOW(), 'h:mm:sstt')# on #dateFormat(NOW(), 'mmmm dd, yyyy')#<p>
                          <p>Please refer to the details above and then do one of the following:</p>
                          <ol type="A">
                          <li>Click the TRY AGAIN button, double check your information, and re-submit your transaction</li>
                          <li>Click the TRY AGAIN button and re-submit your transaction using a different credit card</li>
                          <li>Failing the above options, email the above details to <a href="mailto:registration_problems@esportsdesk.com?subject=Online Registration Error&body=I have encountered a problem making my registration payment.%0A%0APlease review the below details and contact me with instructions on how to proceed.%0A%0AERRCODE: #URLDecode(response.ERRCODE)#%0ANAME ON CARD: #trim(form.bill_firstname)#%20#trim(form.bill_lastname)#%0AAMOUNT: #form.OrderTotal#%0APHONE: #trim(form.bill_phone)#%0AEMAIL: #trim(form.emailaddress)#" style="color:red;">registration_problems@esportsdesk.com</strong></a>, or call us at 1.877.606.0776</li>
                          </ol>
                      </td>
                    </tr>
                  <tr align=center bgcolor="red">
                    <td>
                    <input type="button" value="<<< TRY AGAIN" onClick="history.back();">&nbsp;&nbsp;
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>                                   
        </cfoutput>
    </cfcase>
</cfswitch>

<cfif processor_error IS "No">
    <cfquery name = "UpdateOrderPaid" datasource="#request.dsn#">
    UPDATE orders
    SET paid = 'Yes'
    WHERE OrderNumber = '#form.OrderNumber#'
    </cfquery>
</cfif>

