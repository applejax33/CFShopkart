<!---Display the order form and payment options--->

<h2>Checkout</h2>

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function PopupWin(mypage) {
var myname = 'ImageWindow';
var w = 600;
var h = 480;
var winl = (screen.width - w) / 2;
var wint = (screen.height - h) / 2;
winprops = 'height='+h+',width='+w+',top='+wint+',left='+winl+',scrollbars=1,resizable'
win = window.open(mypage, myname, winprops)
if (parseInt(navigator.appVersion) >= 4) { win.window.focus(); }
}
//  End -->
</script>

<cfinclude template = "frmorder.cfm">

<cfinclude template = "../actions/actloadvars.cfm">

<cfif processpage IS 'Yes'>

<cfif TotalErrors GT 0>
	<!--- Errors were found so mark them with javascript then show the errors--->
	<div class="checkout_errorsection">
    <div class="checkout_errorheader">Please correct the following before proceeding with your order:</div>
	<div class="checkout_errormessage"><cfoutput>#ErrorMessage#</cfoutput></div>
	<div class="checkout_errorfooter"></div>
    </div>
</cfif>

<cfset newform = 'none'>
<cfset loginform = 'block'>

<cfif qryCustomers.recordcount GT 0>
	<cfset newform = 'block'>
    <cfset loginform = 'none'>
</cfif>

<cfif TotalErrors GT 0>
	<cfset newform = 'block'>
    <cfset loginform = 'none'>
</cfif>

<table width="100%" border="0" cellspacing="2" cellpadding="2">
<cfif qryCustomers.recordcount IS 0>
  <tr>
    <td class="TableTitles"><h3 style="padding:0px; margin: 0px;"><strong>Returning Customers</strong></h3></td>
  </tr>
  <tr>
 <!----RETURNING CUSTOMERS--->
    <td class="checkout_returningcell" valign="top">
    <div class="checkout_returningdiv">   
     <div class="checkout_loginformcell">
        <cfinclude template = "frmlogin.cfm">
     </div>     		
	</div>   
    </td>
  </tr>
</cfif>
  <tr>
    <td class="TableTitles"><h3 style="padding:0px; margin: 0px;"><strong><cfif qryCustomers.recordcount IS 0>New Customers<cfelse>Welcome Back!</cfif></strong></h3></td>
  </tr>
  <tr>
<!---NEW CUSTOMERS--->
<td class="checkout_newcell">
    <cfinclude template = "frmnewcustomer.cfm">
</td>
</tr>
</table>
</cfif>