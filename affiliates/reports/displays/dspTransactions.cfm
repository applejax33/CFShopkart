<!---Styles--->
<style type="text/css">
<!--
.style2 {font-size: 24px}
.style3 {
	color: #FFFFFF;
	font-weight: bold;
}
-->
</style>

<script language="javascript">
function viewme(ordernumber)
{
	var a = window.open('','','width=350,height=400,scrollbars=1');
	var elname = 'view_'+ordernumber;
	a.document.open("text/html");
	a.document.write(document.getElementById(elname).innerHTML);
	a.document.close();
}
</script>


<!---Default Values--->
<cfparam name = "viewmonth" default="#dateformat(now(), 'mm')#">
<cfparam name = "viewyear" default="#dateformat(now(), 'yyyy')#">

<!---Figure their current balance.  
This is all the current transactions that have not been paid out yet--->
<cfquery name = "qryTransactions" datasource="#request.dsn#">
SELECT * FROM afl_transactions
WHERE AffiliateID = '#request.affiliateid#' AND paid = 'No'
</cfquery>

<!---If above returns zero records then set the balance to zero, otherwise add it up--->
<cfset accountbalance = 0.00>
<cfoutput query = "qryTransactions">
	<!---If there is a commission, then add it to the balance due--->
	<cfif len(commission) GT 0>
		<cfset accountbalance = accountbalance + #commission#>
	</cfif>
</cfoutput>

<!---Query the transactions for the currently selected month/year--->
<cfquery name = "qryMonthTransactions" datasource="#request.dsn#">
SELECT * FROM afl_transactions
WHERE AffiliateID = '#request.affiliateid#' 
AND TransMonth = #ViewMonth# AND TransYear = #ViewYear#
ORDER BY TransDate DESC
</cfquery>

<cfquery name = "qryAllTrans" datasource="#request.dsn#">
SELECT * FROM afl_transactions
WHERE AffiliateID = '#request.affiliateid#' 
</cfquery>

<!---Get the years to display in the year box--->
<cfquery name = "qryYears" datasource="#request.dsn#">
SELECT DISTINCT TransYear FROM afl_transactions
WHERE affiliateID = '#request.affiliateid#'
</cfquery>

<cfquery name = "qryHits" datasource="#request.dsn#">
SELECT * FROM afl_affiliates
WHERE affiliateid = '#request.affiliateid#'
</cfquery>

<table width="200" border="0" cellspacing="0" cellpadding="4">
<!---Display the account balance (figured above)--->
  <tr>
    <td align="center" bgcolor="#0066CC"><span class="style3">Current Balance*</span></td>
  </tr>
  <tr>
    <td height="35" align="center" bgcolor="#E8E8E8"><strong><span class="style2"><cfoutput>#dollarformat(accountbalance)#</cfoutput></span></strong></td>
  </tr>
</table>
<br />
<cfif len(trim(qryHits.taxid)) IS 0 AND len(trim(qryHits.pnumber)) IS 0>
	<div style="border: 1px solid #000000; padding:6px; background: #FFFFCC;"><font color="#FF0000"><strong>You have not provided a tax identification number yet:</strong></font><br />
    You will not receive payment until you have provided a tax identification number (Social Security Number or EIN for U.S. Residents).  This information is necessary before we can pay out any commissions.<br /></div>
</cfif>
<cfif qryHits.has1099 IS 'No'>
<br />
<div style="border: 1px solid #000000; padding:6px; background: #FFFFCC;">
<font color="#FF0000"><strong>You have not sent in your 1099 Form yet</strong></font>
A 1099 form is an IRS tax form used for the purposes of reporting income.  Our records indicate that you have not yet filled out and sent us a 1099 form. 
We require all affiliates to send us a completed 1099 before we can pay out any commissions.  You can find a link to the 1099 form on the menu.
</div>
</cfif>

<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td colspan="8"><form name="form1" method="post" action="index.cfm?action=reports.transactions">
      <table width="100%" border="0" cellspacing="0" cellpadding="4">
        <tr>
          <td width="40%"><select name="viewmonth">
            <option value="01" <cfif viewmonth IS '01'>selected</cfif>>January</option>
            <option value="02" <cfif viewmonth IS '02'>selected</cfif>>February</option>
            <option value="03" <cfif viewmonth IS '03'>selected</cfif>>March</option>
            <option value="04" <cfif viewmonth IS '04'>selected</cfif>>April</option>
            <option value="05" <cfif viewmonth IS '05'>selected</cfif>>May</option>
            <option value="06" <cfif viewmonth IS '06'>selected</cfif>>June</option>
            <option value="07" <cfif viewmonth IS '07'>selected</cfif>>July</option>
            <option value="08" <cfif viewmonth IS '08'>selected</cfif>>August</option>
            <option value="09" <cfif viewmonth IS '09'>selected</cfif>>September</option>
            <option value="10" <cfif viewmonth IS '10'>selected</cfif>>October</option>
            <option value="11" <cfif viewmonth IS '11'>selected</cfif>>November</option>
            <option value="12" <cfif viewmonth IS '12'>selected</cfif>>December</option>
          </select>
            <select name="viewyear">
				<cfoutput query = "qryYears">
				<option SELECTED value = "#transyear#">#transyear#</option>
				</cfoutput>
				<cfif qryYears.recordcount IS 0>
					<cfoutput><option value = "#viewyear#">#viewyear#</option></cfoutput>
				</cfif>
            </select>
			<input type = "submit" name = "submitview" value="View"></td>
          <td>Total Sales To Date: <cfoutput>#qryAllTrans.recordcount#</cfoutput></td>
          <td>Total Clicks Throughs To Date: <cfoutput>#qryHits.hits#</cfoutput> </td>
        </tr>
      </table>
        </form>    </td>
  </tr>
  <tr>
    <td width="15%" align="left" bgcolor="#000000"><span class="style3">Date</span></td>
    <td align="left" bgcolor="#000000"><span class="style3">Description</span></td>
    <td width="15%" align="left" bgcolor="#000000"><span class="style3">Order</span></td>
    <td width="15%" align="left" bgcolor="#000000"><span class="style3">Order Status</span></td>
    <td width="10%" align="left" bgcolor="#000000"><span class="style3">Sale</span></td>
    <td width="10%" align="left" bgcolor="#000000"><span class="style3">Earned</span></td>
    <td width="10%" align="left" bgcolor="#000000"><span class="style3">Payment</span></td>
  </tr>
  <cfloop query = "qryMonthTransactions">
  
  <cfquery name = "qOrder" datasource="#request.dsn#">
  SELECT * FROM orders WHERE ordernumber = '#OrderNumber#'
  </cfquery>
  
  <cfset customerid = 0>
  
  <cfoutput query = "qOrder">
  	<cfset customerid = qOrder.customerid>
  </cfoutput>
  
  <cfoutput>
  <tr>
    <td <cfif TransType IS 0>bgcolor="##DDFBD9"</cfif>>#dateformat(transdate, "mm/dd/yyyy")#</td>
    <td <cfif TransType IS 0>bgcolor="##DDFBD9"</cfif>>#TransDesc#</td>
    <td <cfif TransType IS 0>bgcolor="##DDFBD9"</cfif>>#OrderNumber#
    
    <div id="view_#ordernumber#" style="display:none;">
  	
    	<cfif qOrder.recordcount GT 0>
        	<cfinclude template = "dspDetails.cfm">
        <cfelse>
        	Information about this transaction cannot be found.
       	</cfif>

    </div>

    </td>
    <td <cfif TransType IS 0>bgcolor="##DDFBD9"</cfif>>#OrderStatus#</td>
	<td <cfif TransType IS 0>bgcolor="##DDFBD9"</cfif>>
	<cfif TransType IS 0>-<cfelse>#dollarformat(SaleAmount)#</cfif>
	</td>
    <td <cfif TransType IS 0>bgcolor="##DDFBD9"</cfif>>
	<cfif TransType IS 0>-<cfelse>$#Commission#</cfif></td>
    <td <cfif TransType IS 0>bgcolor="##DDFBD9"</cfif>>
	<cfif TransType IS 0>#dollarformat(Payout)#<cfelse>-</cfif>
	</td>
  </tr>
  </cfoutput>
  
    
  </cfloop>
  <cfif qryMonthTransactions.recordcount IS 0>
  <tr>
    <td colspan = "8">There are no transactions to display for the selected month/year.</td>
  </tr>
  </cfif>
</table>
<p>* Balance is an estimate and may change prior to payout.</p>








