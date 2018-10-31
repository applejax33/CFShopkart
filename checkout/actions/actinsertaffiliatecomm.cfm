<!---Insert Affiliate Commissions for affiliate system (if there was any to give)--->

<!---Set a total and date--->
<cfset total = evaluate(#grandtotal#-#request.ShippingCharges#-#Cart.FiguredTax#)>
<cfset transdate = dateformat(Now(),"yyyy-mm-dd")>

<!---If the session exists set the temp variable--->
<cfif isdefined('session.affilid')>
	<cflock scope="session" timeout="10" type="readonly">
		<cfset tempvar.affilid = session.affilid>
	</cflock>

	<!---If the affilid is 0 then not affiliate gets commission so skip it--->
	<cfif NOT tempvar.affilid IS '0'>
		<!---Delete transaction for order if it exists then put it back in (in case they hit browser back button/refresh)--->
		<cfquery name="qryTransactions" datasource="#request.dsn#">
		SELECT * FROM afl_transactions
		WHERE ordernumber = '#form.ordernumber#'
		</cfquery>
		
		<cfquery name="qryDeleteTransaction" datasource="#request.dsn#">
		DELETE FROM afl_transactions
		WHERE ordernumber = '#form.ordernumber#'
		</cfquery>

		<!---Credit sale if it hasn't already been given for this order--->		
		<cfif qryTransactions.recordcount IS 0>
			<cfquery name="qrySales" datasource="#Request.dsn#">
			SELECT sales from afl_affiliates
			WHERE AffiliateID = '#tempvar.affilid#'
			</cfquery>
			
			<cfset newsales = 0>
			<cfoutput query = "qrySales">
				<cfset newsales = sales + 1>
			</cfoutput>
			
			<cfquery name="qryUpdateSales" datasource="#Request.DSN#">
			UPDATE afl_affiliates
			SET sales = '#newsales#'
			WHERE AffiliateID = '#TempVar.affilid#'
			</cfquery>
		</cfif>
		
		<!---Get the commission rate--->
		<cfquery name="qryCommissionRate" datasource="#Request.DSN#">
		SELECT * FROM companyinfo, settings_main
		</cfquery>
		
		<!---Figure up commission rate from total--->
		<cfset commish = evaluate(#total# * evaluate(#qryCommissionRate.commrate# / 100))>
		
		<cfset iTransMonth = dateformat(transdate, "mm")>
		<cfset iTransYear = dateformat(transdate, "yyyy")>
		
		<!--- Pay the Local Affiliate--->
		<cfquery name="addsale" datasource="#Request.DSN#">
		INSERT into afl_transactions
		(AffiliateID, TransDate, TransMonth, TransYear, TransType, TransDesc, OrderNumber, SaleAmount, Commission, paid, OrderStatus)
		Values
		('#tempvar.affilid#',	'#TransDate#',	#iTransMonth#,	#iTransYear#, 1, 'Sale', '#Form.ordernumber#', '#total#', '#commish#', 'No', 'Pending')
		</cfquery>

		<!---Update order to show affiliate who referred customer--->
		<cfquery name="qryUpdateOrder" datasource="#Request.dsn#">
			UPDATE orders
			SET affiliateid = '#tempvar.affilid#'
			Where OrderNumber = '#form.ordernumber#'
		</cfquery>	
		
	</cfif>
</cfif>







