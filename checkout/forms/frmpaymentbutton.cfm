<!---find out what payment_method they chose and then either display the button for the 3rd party processor or show the process button to go through the gateway--->
<cfparam name = "payment_method" default="prcoessoffline">

<!---if there is nothing due to charge then change the processor to processoffline since there is no card needed--->
<cfif GrandTotal IS 0>
  <cfset payment_method = 'processoffline'>
</cfif>

<div class="payment_button">
<cfinclude template = "../actions/actpaymentmethodvars.cfm">

<!---if there is a card being collected here, then there must at least be a script_pay value set to process through process.cfm--->
	<cfif qProc.askforcard IS 1>
        <cfif len(trim(qProc.script_pay)) GT 0 OR len(trim(qProc.script_subscribe))>
            <form method="Post" action="index.cfm?action=process">
            
            <cfif GrandTotal IS 0>
	        	  <input type = "hidden" value="" Name="card_type">
                  <input type = "hidden" value="" Name="card_number">
                  <input type = "hidden" value="" Name="card_expmonth">
                  <input type = "hidden" value="" Name="card_expyear">
                  <input type = "hidden" value="" Name="card_cvs">
			<cfelse>
                <cfinclude template = "frmpayment.cfm">
			</cfif>
            
            <cfif isdefined('form')>
              <CFLOOP COLLECTION="#Form#" ITEM="VarName">
                <cfif VarName IS 'card_number' OR VarName IS 'card_type' OR VarName IS 'card_cvs' OR VarName IS 'card_expmonth' OR VarName IS 'card_expyear'>
                
                <cfelse>
				<cfoutput>
                    <span style="font-weight: bold">
                      <input type="hidden" name="#VarName#" value="#evaluate(varname)#">
                      </span>
                </cfoutput>
                </cfif>
              </CFLOOP>
            </cfif>
                       
            <!---cart content totals and other variables calculated from frmorders.cfm--->
            <cfoutput>
            <cfif NOT isdefined('form.OrderTotal')>
                <input type = "hidden" value="#GrandTotal#" Name="OrderTotal"><!---this is the total they are charged today--->
                <input type="hidden" value="#TotalSubscriptionItems#" Name="SubscriptionTotal"> <!---this is calculated total of future recurring payments--->
                <input type="hidden" value="#subscription_items#" name = "subscription_items" />
                <input type = "hidden" value="#TotalItemsInCart#" Name="TotalItemsInCart">
                <input type="hidden" name="askforshipping" value="#askforshipping#" />
                <input type="hidden" value="#Cart.FiguredTax#" Name="FiguredTax">
                <input type="hidden" value="#Cart.TotalShippingCosts#" Name="TotalShippingCosts">
                <input type="hidden" Value="#CustomerID#" Name="CustomerID">
                <input type = "hidden" value="#TotalItemsInCart#" Name="TotalItemsInCart">
			</cfif>
            <cfif NOT isdefined('form.ShipFromState') AND ISDEFINED('request.ShipFromState')>
              <input type="hidden" value="#request.ShipFromState#" Name="ShipFromState">
              <input type="hidden" value="#request.ShipFromCountry#" Name="ShipFromCountry">
            </cfif>
            <cfif NOT ISDEFINED('form.ShippingMethod') AND ISDEFINED('Cart.DefaultService')>
            <!---Tracks what method the customer chose for shipping--->
              <input type = "hidden" Value = "#Cart.DefaultService#" Name="ShippingMethod">
            </cfif>
            </cfoutput>
            
            <!---if there is a script for paying then process through process.cfm and load the script there (for real time processors like authorize.net--->
            
            <cfoutput><input type="image" src="#request.ProcessOrder#" name="ProcessOrder" value="ProcessOrder" alt="Complete Order" title="Complete Order"  class="ProcessOrderButton" /></cfoutput>   
        </form>
    </cfif>
    
    <!---If there is a button for this payment processor (Usually 3rd party processors have HTML that posts to their gateway, then show that instead--->
    <cfif len(trim(qProc.script_button)) GT 0>
        <cfinclude template = "../gateway/#qproc.script_button#">
    </cfif>
    </div>
</cfif> <!---end if the type of processor chosen is a gateway type processor that uses either a post script of some sort or a button--->

<cfif qProc.p_type IS '3rdparty'>

    <cfif len(trim(qProc.script_button)) GT 0>
        <cfinclude template = "../thirdparty/#qproc.script_button#">
    </cfif>

</cfif>