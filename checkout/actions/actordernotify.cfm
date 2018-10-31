<!---Send notification to the Company's email inbox--->

<cfif NOT isdefined('session.sendonce')>
<cfinclude template="../queries/qrycompanyinfo.cfm">

<cfsavecontent variable="messagebody">
<cfoutput>
	<font face="Verdana, Arial, Helvetica, sans-serif" size="2">
	Order Notification and Summary.  The following is a summary of an order that was placed on your website.  Login to your control panel to see details and update the order status.
	</font>
	<p>
	<b><font size = "4" face="Verdana, Arial, Helvetica, sans-serif">Order Number:  #ordernumber#</font></b><br>
	<b>ORDER SUMMARY:</b>
	<p>
	<cfloop index="IndexCount" from="1" To="#ListLen(qryOrders.CrtProductID, "^")#">
	<cfset ThisProduct = #ListGetAt(qryOrders.CrtProductName, IndexCount, '^')#>
	<font face="Verdana, Arial, Helvetica, sans-serif" size = "2">
	ITEM #IndexCount#<br>
	#ThisProduct#  <br>
	<b>Quantity Ordered:</b> #ListGetAt(qryOrders.CrtQuantity, IndexCount, "^")#<br>
	<b>Price:</b>  <cfset TotalOfItems = #ListGetAt(qryOrders.CrtPrice, IndexCount, "^")#><cfif request.EnableEuro IS 'Yes'>#lseurocurrencyformat(TotalOfItems, "Local")# <cfelse>#lscurrencyformat(TotalOfItems, "Local")#
	</cfif>
    <p>
	</cfloop>
	<b>Discount (If any):</b> <cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyFormat(qryOrders.DiscountAmount, "Local")#<cfelse>#LSCurrencyFormat(qryOrders.DiscountAmount, "Local")#</cfif>	
	<hr />
	<b>Taxes:</b>  <cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyformat(qryOrders.FiguredTax, "Local")# <cfelse>#LSCurrencyformat(qryOrders.FiguredTax, "Local")#</cfif><br />
	<b>Shipping and Handling:</b> <cfif request.EnableEuro IS 'Yes'>#LSEuroCurrencyformat(qryOrders.QuotedShipping, "Local")#
	<cfelse>#LSCurrencyformat(qryOrders.QuotedShipping, "Local")#</cfif><br />
	<b>ORDER TOTAL:</b> <cfif request.EnableEuro IS 'Yes'>#lseurocurrencyformat(qryOrders.OrderTotal, "Local")#<cfelse>#lscurrencyformat(qryOrders.OrderTotal, "Local")#</cfif><br />
	</font>
</cfoutput>
</cfsavecontent>

<cfif request.UseMailServer IS 'Yes'>

	<cfif request.UseMailLogin IS 'Yes'>
        <cfmail server="#request.MailServer#"
        username="#request.mailuser#"
        Password="#request.mailpassword#"
        From="#request.EmailAddress#"
        TO="#request.EmailAddress#"
        SUBJECT="#request.CompanyName# Website Order Notification"
        type="html">
        #messagebody#
        </cfmail>
      <cfelse>
        <cfmail server="#request.MailServer#"
        From="#request.EmailAddress#"
        TO="#request.EmailAddress#"
        SUBJECT="#request.CompanyName# Website Order Notification"
        type="html">
        #messagebody#
        </cfmail>       
    </cfif>

<cfelse>

	<cfif request.UseMailLogin IS 'Yes'>
        <cfmail username="#request.mailuser#"
        Password="#request.mailpassword#"
        From="#request.EmailAddress#"
        TO="#request.EmailAddress#"
        SUBJECT="#request.CompanyName# Website Order Notification"
        type="html">
        #messagebody#
        </cfmail>
      <cfelse>
        <cfmail From="#request.EmailAddress#"
        TO="#request.EmailAddress#"
        SUBJECT="#request.CompanyName# Website Order Notification"
        type="html">
        #messagebody#
        </cfmail>       
    </cfif>
</cfif>

<cflock scope="session" type="exclusive" timeout="10">
	<cfset session.sendonce = 'true'>
</cflock>

</cfif><!---end if sendonce is not defined--->