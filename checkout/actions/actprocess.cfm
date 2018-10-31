<!---This file processes the payment--->
<cfset processpage = 'Yes'>
<cfinclude template="actduplicateordercheck.cfm">

<cfif processpage IS 'Yes'>
<cfparam name = "ipaddress" default="0">

<cfif ISDEFINED('form.card_expmonth')>
	<cfset CCExpireDate = '#form.card_expmonth#/#form.card_expyear#'>
	<cfset CCExpireDateShort = '#form.card_expmonth#/#Right(form.card_expyear, 2)#'>
</cfif>

<cfif NOT ISDEFINED('form.card_expmonth')>
	<cfset CCExpireDate = '--/--'>
	<cfset CCExpireDateShort = '0260'>
	<cfset form.card_expmonth = '--'>
	<cfset form.card_expyear = '--'>    
</cfif>

<cfset TheMemo = #form.Memo#>

<cfif isdefined('form.ShipFromState')>
	<cfset TheMemo = TheMemo & ' - Ship Items from #form.ShipFromState#, #form.ShipFromCountry#'>
</cfif>

<!---set some variables for backward compatability--->
<cfset TheCompanyName = '#request.CompanyName#'>
<cfset TheCompanyEmail = '#request.EmailAddress#'>
<cfset TheCustomerEmail = '#Form.Emailaddress#'>
<cfset TheMailServer = '#request.MailServer#'>

<!---decrypt processor settings--->
<cfinclude template = "actpaymentmethodvars.cfm">

<!---Set the total shipping costs to a variable so it can be changed if needed--->
<cfset request.ShippingCharges = '#form.TotalShippingCosts#'>
<cfset request.ShippingMethod = 'N/A'>

<cfif ISDEFINED('form.ShippingMethod')>
<cfset request.ShippingMethod = '#form.ShippingMethod#'>
</cfif>

<!---update the shipping info for this order--->
<cfquery name = "qryUpdateShippingInfo" datasource="#request.dsn#">
UPDATE orders
SET ShippingMethod = '#request.ShippingMethod#'
WHERE ordernumber = '#form.ordernumber#'
</cfquery>

<!---Create a date variable to determine when the order was placed--->
<cfset TheCurrentDate = #Now()#>
<cfset TheCurrentDate = #dateformat(TheCurrentDate, "mm/dd/yyyy")#>

<!---Note:  processor_error should be passed back from your processor script to tell actprocess.cfm to either continue or to stop.  Do not use CFABORT.--->
<cfset processor_error = 'No'>

<cfif qProc.askforcard IS 1>
	<cfinclude template = "actvalidatecc.cfm">
<cfelse>
	<cfset v_passed = 1>
</cfif>

<cfif v_passed IS 1>
    <cfinclude template = "../gateways/#qProc.script_pay#">
    
    <!---redirect to final screen if no processor error--->
    <cfif processor_error IS 'No'>
    <cfoutput>
        <script language="javascript">
            <!-- 
            location.replace("index.cfm?action=finalize_redirect&CustomerID=#form.CustomerID#&OrderNumber=#form.OrderNumber#&CartToken=#CartToken#");
            -->
        </script>
    </cfoutput>
    
    <!---Just include if java is disabled--->
    <cfset url.customerid = form.customerid>
    <cfset url.ordernumber = form.ordernumber>
    
    <cfparam name = "ordernumber" default="0">
    <cfparam name = "customerid" default="0">
    
    <!---clear the ordernumber cookie and shopping cart so they cannot reorder--->
    <cfset cookie.customerordernumber = "">
    <cfcookie name="customerordernumber" value="" expires="now">
    
    <cflock scope="SESSION" type="EXCLUSIVE" timeout="10">
        <cfset session.CrtItemID="">
        <cfset session.CrtProductID="">
        <cfset session.CrtProductName = "">
        <cfset session.CrtQuantity = "">
        <cfset session.CrtPrice = "">
        <cfset session.CrtWeight = "">
        <cfset session.CrtThumbNails = "">
        <cfset session.Crtoptions = "">
        <cfset session.CrtType = "">
        <cfset session.CrtApproved = "">
        <cfset session.CrtCoupons = "">
        <cfset session.wishlist = "">
        <cfset session.affilid = "">
        <cfset cookie.carttoken = "">
    </cflock>
    <p>
    <cfinclude template = '../forms/frmfinalize.cfm'>
    </p>
    </cfif><!---end if processor_error IS 'No'--->
</cfif><!---end if validations passed (eq 1)--->
</cfif><!---end if process page is yes--->