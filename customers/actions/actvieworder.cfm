<cfinclude template = "actchecklogin.cfm">
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

<cfinclude template = "../queries/qrycompanyinfo.cfm">

<style type="text/css">
<!--
.giftcode {
	font-size: 18px;
	font-weight: bold;
}
-->
</style>

<cfoutput>
<h3 align="left">Order Number #Url.OrderNumber#</h3>
</cfoutput> 

<cfquery name = "qryCustomers" datasource = "#Request.DSN#">
SELECT * FROM customerhistory
WHERE CustomerID = <cfqueryparam value="#URL.CustomerID#" cfsqltype="cf_sql_integer">
</cfquery>

<cfquery name = "QryOrders" datasource = "#Request.DSN#">
SELECT * FROM orders
WHERE OrderNumber = <cfqueryparam value="#url.OrderNumber#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfoutput query="QryOrders">
<blockquote>
		<a href="index.cfm?action=customers_orders&amp;CartToken=#CartToken#"></p>Back to Order History</a></blockquote>

<div id="printpart">
<blockquote>		
		<p>
      <b>Order Summary: #OrderStatus#</b></p> 
	 <cfif OrderStatus IS 'Received'>Your order was received and we will begin processing it soon.  Please check back for status updates.
	 <p>
	 </cfif>
	 <cfif OrderStatus IS 'Completed'>Your order has been marked at Completed!
	 <p>
	 Tracking Numbers: <br />
	 <cfset TrackingCount = 0>
	 <cfloop from = "1" to = "#listlen(CrtTrackingNumbers, '^')#" index="tCount">
	 <cfset tNumber = listgetat(CrtTrackingNumbers, tCount, "^")>
	 <cfif not tNumber IS '0'>
	 	<cfset TrackingCount = TrackingCount + 1>
		<cfoutput>#tNumber#<br /></cfoutput>
	 </cfif>
	 </cfloop>
	 <cfif TrackingCount IS 0>
	 	Sorry, there are no tracking numbers for this order.
	</cfif>
	</cfif>
  </blockquote>
      <center>
        <table width="90%" border="0" cellspacing="0" cellpadding="3" style="border-collapse: collapse" bordercolor="##111111">
          <tr> 
            <td class="TableTitles" width="50%" height="19" style="border-color:##000000; border-width:1; " > 
              <b>Name</b></td>
            <td class="TableTitles" width="25%" height="19" style="border-color:##000000; border-width:1; " ><b>Quantity</b></td>
            <td class="TableTitles" width="25%" align="center" style="border-color:##000000; border-width:1; " ><span style="font-weight: bold">Status</span></td>
            <td class="TableTitles" width="25%" height="19" align="center" style="border-color:##000000; border-width:1; " > 
              <b>Price</b></td>
          </tr>
          <cfset showdownloads = 'No'>
          <cfloop index="IndexCount" from="1" To="#ListLen(CrtProductID, "^")#">
          
          <cfset ThisItemID = "#ListGetAt(CrtItemID, indexcount, "^")#">
          
          <!---if there are downloads--->
          <cfquery name = "qDownloads" datasource="#request.dsn#">
		  SELECT * FROM product_files
          WHERE itemid = <cfqueryparam value="#ThisItemid#" cfsqltype="cf_sql_varchar">
          </cfquery>
          
          <cfif qDownloads.recordcount GT 0>
          	<cfset showdownloads = 'Yes'>
          </cfif>
          
             <tr> 
                <td width="50%" style="border-color:##000000; border-width:1; " valign="middle">
			   #ListGetAt(CrtProductID, IndexCount, "^")# - #ListGetAt(CrtProductName, IndexCount, "^")#</td>
                <td width="25%" style="border-color:##000000; border-width:1; " valign="middle"> 
                  <p align="center"> #ListGetAt(CrtQuantity, IndexCount, "^")#</p></td>
                <td width="25%" align="center" style="border-color:##000000; border-width:1; ">
				<cfif NOT listlen(CrtShipped, "^") LT IndexCount>#ListGetAt(CrtShipped, IndexCount, "^")#
				<cfelse>
				Not Available
				</cfif>
				</td>
                <td width="25%" align="right" style="border-color:##000000; border-width:1; "> 
					<cfset TotalOfItems = #ListGetAt(CrtPrice, IndexCount, "^")#>
					<cfif request.EnableEuro IS 'Yes'>
                    #lseurocurrencyformat(TotalOfItems, "Local")# 
                      <cfelse>
                      #lscurrencyformat(TotalOfItems, "Local")#
               </cfif></td>
            </tr>
          </cfloop>
          </tr>
          <tr>
            <td height="15" colspan="3" style="border-style: none" align="right">Discount 
                (If any):</td>
            <td height="15" align="right" style="border-color:##000000; border-width:1; ">
        	<cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyFormat(DiscountAmount, "Local")#<cfelse>#LSCurrencyFormat(DiscountAmount, "Local")#</cfif>			</td>
          </tr>
          <tr>
            <td height="15" colspan="3" align="right">Gift Card Amount Applied <cfif len(giftcode) GT 0>(#giftcode#)</cfif>:</td>
            <td height="15" align="right">
			<cfif len(giftamountused) GT 0>
        	<cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyFormat(giftamountused, "Local")#<cfelse>#LSCurrencyFormat(giftamountused, "Local")#</cfif>		
			<cfelse>
			N/A
			</cfif>
			</td>
          </tr>	  	  
          <tr> 
            <td height="15" colspan="3" style="border-style: none" align="right">Taxes:</td>
            <td height="15" align="right" style="border-color:##000000; border-width:1; ">
				<cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyformat(FiguredTax, "Local")#
		    <cfelse>#LSCurrencyformat(FiguredTax, "Local")#</cfif>			</td>
          </tr>
          <tr> 
            <td width="88%" height="15" colspan="3" style="border-style: none" align="right"> 
              <cfif NOT ShippingMethod IS 'N/A'>(#ShippingMethod#) - </cfif>Shipping &amp; Handling: </td>
            <td width="20%" height="15" align="right" style="border-color:##000000; border-width:1; ">
				<cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyformat(QuotedShipping, "Local")#
		    <cfelse>#LSCurrencyformat(QuotedShipping, "Local")#</cfif>			</td>
          </tr>
          <tr> 
            <td width="88%" height="15" colspan="3" style="border-style: none"> 
              <p align="right"><b>Total:</b></p></td>
            <td width="20%" height="15" align="right" style="border-color:##000000; border-width:1; "><b> 
                <cfif request.EnableEuro IS 'Yes'>
                  #lseurocurrencyformat(OrderTotal, "Local")# 
                  <cfelse>
                  #lscurrencyformat(OrderTotal, "Local")# 
</cfif>
                </b></td>
          </tr>
        </table>
      </center>
<hr width="90%" align="center">
    
<cfinclude template = "../forms/frmDownloads.cfm">
	
<cfset ThePaymentMethod = #PaymentMethod#>
</cfoutput>
<p>
<hr width="90%" align="center">
<cfoutput query = "qryCustomers">
<table width="90%" border="1" align="center" cellpadding="4" cellspacing="0">
  <tr>
    <td height="15" colspan="2" Class="TableTitles"><strong>Billing Information</strong></td>
    <td height="15" valign="top" Class="TableTitles"><strong>Order Shipping To:</strong></td>
  </tr>
  <tr> 
    <td height="15" colspan="2">#FirstName# #LastName#<br>
		#BusinessName#
		#address#<br>
        #city#, #State# &nbsp;&nbsp; #ZipCode#<br>
        #Country#<br>
		<p>
		<b>Email Address:</b> #EmailAddress#<br>
        <b> Phone Number:</b> #PhoneNumber# <br>
        </p>
        <p>&nbsp; </p>
   	  </td>
    <td width="48%" height="15" valign="top">
	#qryOrders.ShippedTo#
	<p>
	<b>Coupon Code Used:</b>  <cfif NOT qryOrders.PromoCode IS '0'>#qryOrders.PromoCode#</cfif><cfif qryOrders.PromoCode IS '0' OR len(qryOrders.PromoCode) IS 0>NONE USED</cfif></p></td>
  </tr>
</table>
</cfoutput>

<blockquote>
<p>
<cfoutput query = "qryOrders"> 
  <p><strong>Order Notes: </strong></p>
    <p> 
	 #Notes#
	 <cfif len(notes) IS 0>
	   There are no notes posted to this order
	 </cfif>
    </p>
    <p>&nbsp;</p>
</cfoutput>

<!---Check for gift certificates on this order--->

<cfquery name = "qryCheck" datasource="#request.dsn#">
SELECT * FROM giftcards
WHERE OrderID = <cfqueryparam value="#OrderNumber#" cfsqltype="cf_sql_varchar">
</cfquery>	

<cfif qryCheck.RecordCount GT 0>
  <h4>Gift Codes:</h4>
  <cfloop query = "qryCheck">
<!---Display this gift certificate number--->
<table width = "350" cellpadding="4" cellspacing="0" style="border: dashed 2px #CCCCCC;" align="center">
<tr>
	<td height="150" align="center" valign="middle">
	Use this code
	<p>
	<span class="giftcode"><cfoutput>#gNumber#</cfoutput></span>
	<p>
	at <cfoutput>#replacenocase(request.homeurl, "http://", "", "ALL")#</cfoutput><br />
	to get up to <cfoutput><strong>$#gAmount#</strong></cfoutput> off any purchase!
    <cfif qryCheck.activated IS 'No'><br /><font color="#993300"><strong>This code is not active.  <br />
    You won't be able to use it until it is active.</strong></font></cfif>
    </td>
</tr>
</table>
<p>
</cfloop>

</cfif>	
<!---End check for gift certificates--->
<p>&nbsp;</p>
</div>

<center><input type="submit" name="Print" value="Print this order" onClick="printme();"></center>







