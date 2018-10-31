<script>
function printme()
{
	var a = window.open('','','width=640,height=480,scrollbars=1');
	a.document.open("text/html");
	a.document.write(document.getElementById('printpart').innerHTML);
	a.document.close();
	a.print();
}
</script>

<div id="printpart">
<cfparam name = "OrderNumber" default="0">
<cfif isdefined('url.m_OrderNumber')>
	<cfset OrderNumber = "#url.m_OrderNumber#">
</cfif>
<cfif isdefined('invoice')>
	<cfset OrderNumber = #invoice#>
</cfif>

<table width = "90%" align="center">
<tr>
<td>

<cfset paymentsent = 'No'>

<!---For SkipJack.  If the order was not approved then display a message--->

<cfif NOT ISDEFINED('session.CartToken')>
	<cflock scope="session" type="readonly" timeout="10">
		<cfset session.CartToken = '0'>
	</cflock>
</cfif>

<cfinclude template = "../queries/qrycompanyinfo.cfm">

<!---First get this customer's info from the database--->
<cfinclude template = "../queries/qryfinalize.cfm">

<cfif OrderNumber IS '0'>
<strong><center><h4>Thank you for you order!</h4></center></strong>
<p>
<center>You can login to your account on the main website to view details of this order</center></p>
<p>
<cfset tempvariable = StructClear(session)>
<p align="left">&nbsp;</p>
<center><cfoutput><a href="#request.HomeURL#"></cfoutput><b>
Back to the Catalog</b></a></center>
<cfabort>
</cfif>

<center><b><h3><font color="#000000">Your Order has been received! Thank you!</font></h3></b></center>

<!---Setup variables for giftcards--->
<cfset giftlist = "">
<cfset showdownloads = "no">
<cfoutput query="QryOrders">
<!---Now display what was ordered--->
<cfset paymentsent = '#paid#'>

    <p><b>Order Summary for Order Number #OrderNumber#</b></p>
      <center>
        <table width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr class="TableTitles"> 
            <td width="70%" height="19" align="left"> 
              <b>Name</b></td>
            <td width="15%" height="19"><div align="center"> 
                <b>Quantity</b></div></td>
            <td width="15%" height="19" align="right"> 
              <div align="right"><b>Price</b></div></td>
          </tr>
          <cfloop index="indexCount" from="1" To="#ListLen(CrtProductID, "^")#">
		  
		  <cfset ThisItemID = "#ListGetAt(CrtItemID, indexcount, "^")#">
		  <cfset ThisQuantity = "#ListGetAt(CrtQuantity, indexcount, "^")#">
		  
		  <cfquery name = "FindProduct" datasource="#request.dsn#">
		  SELECT * FROM products WHERE ItemID = #ThisItemID# 
		  </cfquery>

		  <!---if there are downloads--->
          <cfquery name = "qDownloads" datasource="#request.dsn#">
		  SELECT * FROM product_files
          WHERE itemid = '#ThisItemid#'
          </cfquery>
          
          <cfif qDownloads.recordcount GT 0>
          	<cfset showdownloads = 'Yes'>
          </cfif>

		  <!---If it's a gift card then add to the gift card list for processing below--->
		  <cfif FindProduct.isgift IS 'Yes'>
			<cfset giftlist = listappend(giftlist, '#ListGetAt(CrtPrice, IndexCount, "^")#', "^")>
		  </cfif>
		   
             <tr> 
                <td width="70%" style="border-color:##000000; border-width:1; " valign="middle" align="left">
					#ListGetAt(CrtProductID, IndexCount, "^")# - #ListGetAt(CrtProductName, IndexCount, "^")#</td>
                <td width="15%" valign="middle" align="center"> 
                  <p align="center"> #ListGetAt(CrtQuantity, IndexCount, "^")#</p></td>
                <td width="15%" align="right"> 
					<div align="right"><cfset TotalOfItems = #ListGetAt(CrtPrice, IndexCount, "^")#>
					<cfif request.EnableEuro IS 'Yes'>
                    #lseurocurrencyformat(TotalOfItems, "Local")# 
                      <cfelse>
                      #lscurrencyformat(TotalOfItems, "Local")#
                  </cfif></div></td>
            </tr>
          </cfloop>
          </tr>
          <tr>
            <td height="15" colspan="2" align="right"><div align="right">Discounts:</div></td>
            <td height="15" align="right">
        	<div align="right"><cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyFormat(DiscountAmount, "Local")#<cfelse>#LSCurrencyFormat(DiscountAmount, "Local")#</cfif></div>		
			</td>
          </tr>
          <tr>
            <td height="15" colspan="2" align="right"><div align="right">Gift Card Amount Applied <cfif len(giftcode) GT 0>(#giftcode#)</cfif>:</div></td>
            <td height="15" align="right">
        	<div align="right"><cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyFormat(giftamountused, "Local")#<cfelse>#LSCurrencyFormat(giftamountused, "Local")#</cfif></div>		
			</td>
          </tr>	  
          <tr> 
            <td height="15" colspan="2" align="right"><div align="right">Taxes:</div></td>
            <td height="15" align="right">
				<div align="right"><cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyformat(FiguredTax, "Local")#
				<cfelse>#LSCurrencyformat(FiguredTax, "Local")#</cfif></div>
			</td>
          </tr>
          <tr> 
            <td width="88%" height="15" colspan="2" align="right"> 
						<div align="right"><cfif NOT ShippingMethod IS 'N/A'>(#ShippingMethod#) - </cfif>Shipping &amp; Handling: </div></td>
            <td width="20%" height="15" align="right">
				<div align="right"><cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyformat(QuotedShipping, "Local")#
				<cfelse>#LSCurrencyformat(QuotedShipping, "Local")#</cfif></div>
			</td>
          </tr>
          <tr> 
            <td width="88%" height="15" colspan="2"> 
              <div align="right"><b>Total:</b></div></td>
            <td width="20%" height="15" align="right"><b> 
                <div align="right"><cfif request.EnableEuro IS 'Yes'>
                  #lseurocurrencyformat(OrderTotal, "Local")# 
                  <cfelse>
                  #lscurrencyformat(OrderTotal, "Local")# 
                </cfif></div>
                </b></td>
          </tr>
        </table>
      </center>
<cfset ThePaymentMethod = #PaymentMethod#>
</cfoutput>
<p>
<cfset customeremail = 'none@customerwasnotfoundinthedb.com'>
<table width="100%" align="center" cellpadding="4" cellspacing="0" class="finalize_addresstable">
  <tr>
    <td height="15" colspan="2" Class="TableTitles"><strong>Billing Information</strong></td>
    <td height="15" valign="top" Class="TableTitles"><strong>Ship Order To:</strong></td>
  </tr>
  <tr> 
    <td height="15" colspan="2" class="finalize_billingaddress">
	<cfoutput query = "qryCustomers">
	<cfif len(BusinessName) GT 0>#BusinessName#<br /></cfif>
		#FirstName# #LastName#<br>
		#address#<br>
		<cfif len(address2) GT 0>#address2#<br /></cfif>
        #city#, #State# &nbsp;&nbsp; #ZipCode#<br>
        #Country#<br>
		<p>
		<b>Email Address:</b> #EmailAddress#<br>
        <b> Phone Number:</b> #PhoneNumber# <br>
        </p>
        <p>&nbsp; </p>
	<cfset CustomerEmail = '#EmailAddress#'>
    </cfoutput>
      	</td>
    <td width="48%" height="15" valign="top" class="finalize_shippingaddress">
	<cfoutput query = "qryOrders">
	<cfif len(ShipBusinessName) GT 0>#ShipBusinessName#<br /></cfif>
	#ShipFirstName# #ShipLastName#<br>
	 #ShipAddress#<br>
	 <cfif len(ShipAddress2) GT 0>#ShipAddress2#<br /></cfif>
        #ShipCity#, #shipstate# &nbsp;&nbsp; #ShipZip#<br>
        #ShipCountry#
    </cfoutput>
        </td>
  </tr>
</table>

<p align="left"><b><cfoutput>Your Order number is #OrderNumber#</b></p>
<p align="left"><b>IMPORTANT: Write your Order number down exactly <br>
    how it appears above and do NOT lose it. You can use it to reference your 
    order later.</cfoutput></b> 
    <p align="left"> 
	<cfoutput query="qryCompanyInfo"> 
    <cfset EmailBody = '#EmailText#'>
    <cfset FinalMessage = '#EndOrderMessage#'>
    <cfset TheCompanyEmail = '#EmailAddress#'>
    <cfset TheHomeURL = '#request.HomeURL#'>
    <cfset TheMailServer = '#mailserver#'>
	<cfset EndOrderSubject = '#EndOrderSubj#'>
	</cfoutput>  

<cfoutput>
<p align="left">
#FinalMessage# 
</p>
</cfoutput>

<!---Email the order summary--->
<cfif qryOrders.sent_emails IS 0>
	<cfif not #len(trim(TheCompanyEmail))# IS 0>
        <cfinclude template = "../actions/actordernotify.cfm">
        <cfinclude template = "../actions/actemailordersummary.cfm">
    </cfif>
</cfif>

<!---This is where callback scripts are called.  The below file loads the processor settings and then loads the callback file.  The variable 'paymentsent' is generated and set.--->
<cfinclude template = "../actions/actcheckifpaid.cfm">

<cfset allowdownloads = 'No'>
<cfif PaymentSent IS 'Yes'>
	<cfset allowdownloads = 'Yes'>
</cfif>

<!---update downloads to approved if payment was sent--->
<cfif paymentsent IS 'Yes'>
	<cfset NewList = qryOrders.CrtApproved>
	<cfloop from="1" To="#Listlen(qryOrders.CrtApproved)#" index="MyCount">
		<cfset NewList = ListSetAt(NewList, MyCount, "Yes", "^")>
	</cfloop>

	<cfset allowdownloads = 'Yes'>
</cfif>

<cfif showdownloads IS 'Yes'>
	<cfinclude template = "frmdownloads.cfm">
</cfif>

<cfinclude template = "../actions/actgenerategiftcards.cfm">
<cfinclude template = "../actions/actchecksubscriptions.cfm">
</td>
</tr>
</table>
</div>
<center><cfoutput><input type="image" name="PrintButton" value="Print order summary" alt="Print order summar" title="Print Order Summary" src="#request.PrintButton#" onClick="printme();" class="PrintButton"></cfoutput></center>

<!---If Coupons were used, check each one and lower the TimesAllowed Value by one--->
<cfinclude template = "../actions/actupdatecoupons.cfm">
<!---updates gift card if one was used--->
<cfinclude template = "../actions/actupdategiftcard.cfm">
<!---if using accesscodes, the update the access code to used so they can't use it again--->
<cfinclude template = "../actions/actmarkaccesscodeused.cfm">

<!---Load script for an affiliate program--->
<cfoutput>
	<cfset affcode = #request.CustomAffiliateCodeCheckout#>
    <cfset affcode = replacenocase(affcode, '{{orderid}}', '#ordernumber#')>
    <cfset affcode = replacenocase(affcode, '{{ordertotal}}', '#TotalOfItems#')>
    #affcode#
</cfoutput>

<p align="left">&nbsp;</p>
<center><cfoutput><a href="#request.HomeURL#?startover=1"></cfoutput><b>
Back to the Catalog</b></a></center>
<p>&nbsp;</p>

<cfinclude template = "../actions/actdeleteshoppingcart.cfm">

<cfoutput>
<CFCOOKIE name="CustomerID" expires="NOW" value="None">
<CFCOOKIE name="CustEmail" expires="NOW" value="None">
<CFCOOKIE name="CustPassword" expires="NOW" value="None">
<CFCOOKIE name="PromoCode" expires="NOW" value="None">
</cfoutput>