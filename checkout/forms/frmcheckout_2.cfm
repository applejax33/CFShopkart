
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

<div id="newcustomer_choice" <cfoutput>style="display: #loginform#; padding-top: 12px;"</cfoutput>>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
  <tr>
    <td width="50%" class="TableTitles"><h3 style="padding:0px; margin: 0px;"><strong>New Customers</strong></h3></td>
    <td width="50%" class="TableTitles"><h3 style="padding:0px; margin: 0px;"><strong>Returning Customers</strong></h3></td>
  </tr>
  <tr>
<!---NEW CUSTOMERS--->
    <td valign="top" class="checkout_newcell" <cfif qryCustomers.recordcount GT 0>colspan="2"</cfif>>
	
    If you are a new customer, please click the button below to Continue with the checkout process.
      <p>
  	<cfoutput>
    <input type = "image" src="#request.ReviewOrder#" name="ReviewOrder" class="ReviewOrderButton" value="Review Order" alt="Review Order" title="Review Order" onclick="getElementById('newcustomer_choice').style.display='none'; getElementById('newcustomer_form').style.display='block';" />
	</cfoutput>
	</p>
    
   </td>
 <!----RETURNING CUSTOMERS--->
    <td class="checkout_returningcell" valign="top">
      
    <div class="checkout_returningdiv">   
     <div class="checkout_loginformcell">
        <cfinclude template = "frmlogin.cfm">
     </div>     		
	</div>   
    
    </td>
  </tr>
</table>
</div>

<div id="newcustomer_form" <cfoutput>style="display: #newform#;"</cfoutput>>
<table width="100%" border="0" cellspacing="2" cellpadding="2">
  <tr>
    <td class="TableTitles"><h3 style="padding:0px; margin: 0px;"><strong>Account Information</strong></h3></td>
  </tr>
  <tr>
<!---NEW CUSTOMERS--->
<td class="checkout_newcell" <cfif qryCustomers.recordcount GT 0>colspan="2"</cfif>>
    <cfinclude template = "frmnewcustomer.cfm">
</td>
</tr>
</table>
</div>

</cfif>



