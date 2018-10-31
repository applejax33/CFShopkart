<cfinclude template = "../actions/actchecklogin.cfm">
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td><h2>Order History</h2></td>
    <td><div align="right"><cfoutput><a href="index.cfm?action=myaccount&carttoken=#carttoken#">Back to Menu</a></cfoutput></div></td>
  </tr>
</table>

<cfinclude template = "../queries/qrycustomers.cfm">

<cfoutput query = "qryCustomers">
<cfset CustState = #State#>
<cfset CustCountry = #Country#>
<cfset ShipCustState = #ShipState#>
<cfset ShipCustCountry = #ShipCountry#>
<cfset TheCustomerID = #CustomerID#>
</cfoutput>

<cfif isdefined('TheCustomerID')>
<cfinclude template = "../queries/qryorders.cfm">

<CFIF #qryorders.recordcount# IS 0>
  <p align="center"><strong>You have no past orders on file at this time.</strong></p>
</CFIF>
<CFIF NOT #qryorders.recordcount# IS 0>
  <table width="95%" border="2" align="center" cellpadding="1" cellspacing="0" bordercolor="#000000">
    <tr> 
      <td> <table width="100%" border="0" align="center" cellpadding="4" cellspacing="0">
          <tr> 
            <td class="TableTitles" colspan="4">Below is a list of orders you have placed</td>
          </tr>
          <tr bgcolor="#000000"> 
            <td width="25%" align="left"><b> <font color="#FFFFFF" size="1">Date</font></b></td>
            <td width="25%" align="left"><b> <font color="#FFFFFF" size="1">Order 
              Number </font></b> </td>
            <td width="25%" align="left"> <b> <font color="#FFFFFF" size="1">Order 
              Total</font></b></td>
            <td width="25%" align="left"><strong><font color="#FFFFFF" size="1">Status</font></strong></td>
          </tr>
          <cfloop query ="qryorders">
            <!---Find the customer that ordered this--->
            <cfquery name = "qryCustomers" Datasource = "#Request.dsn#">
            SELECT * FROM customerhistory WHERE CustomerID = #CustomerID# 
            </cfquery>
            <cfoutput query = "qryCustomers"> 
              <cfset CustName = '#FirstName# #LastName#'>
              <cfset CustCity = '#City#'>
              <cfset CustState = '#State#'>
              <cfset CustPhone = '#PhoneNumber#'>
              <cfset CustEmail = '#EmailAddress#'>
            </cfoutput> <cfoutput> 
              <tr <cfif qryorders.CurrentRow MOD 2>bgcolor="##CCCCCC"</cfif>> 
                <td><a href="index.cfm?action=customers_vieworder&OrderNumber=#OrderNumber#&CustomerID=#CustomerID#&carttoken=#carttoken#"> <font size="1">#dateformat(DateOfOrder, "mm/dd/yy")#</font></a></td>
                <td><a href="index.cfm?action=customers_vieworder&OrderNumber=#OrderNumber#&CustomerID=#CustomerID#&carttoken=#carttoken#"> 
                  <font size="1">#OrderNumber#</font></a></td>
                <td><a href="index.cfm?action=customers_vieworder&OrderNumber=#OrderNumber#&CustomerID=#CustomerID#&carttoken=#carttoken#"> <font size="1"> 
                  <cfif request.EnableEuro IS 'Yes'>
                    #lseurocurrencyformat(OrderTotal, "Local")# 
                    <cfelse>
                    #lscurrencyformat(OrderTotal, "Local")# 
                  </cfif>
                  </font></a></td>
				  <td align="center"><div align="left">#orderstatus#</div></td>
              </tr>
            </cfoutput> 
          </cfloop>
        </table></td>
    </tr>
  </table>
  <p>&nbsp;</p>
</cfif>
<cfelse>
	Could not find any orders matching your account.
</cfif>







