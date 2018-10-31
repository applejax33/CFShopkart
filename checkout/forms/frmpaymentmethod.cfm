<table width="100%" cellpadding="4" cellspacing="0">
<cfif GrandTotal GT 0>

<cfsavecontent variable="jscript_output">
// turn all off first
<cfoutput query = "qGateway">
document.getElementById('div#id#').className = 'paymentmethod_notselected';
</cfoutput>
<cfoutput query = "q3rdParties">
document.getElementById('div#id#').className = 'paymentmethod_notselected';
</cfoutput>
</cfsavecontent>

<cfoutput>
<script language="javascript">

function selectmethod (divid) {

#jscript_output#
document.getElementById(divid).className = 'paymentmethod_selected';
}
</script>
</cfoutput>

	<!---Primary processor (gateway)--->
    <cfoutput query = "qGateway">
    <tr>
    <td width="5%" onclick="selectmethod('div#id#'); document.getElementById('radio#id#').checked='checked'">
	<div id = "div#id#" <cfif qGateway.p_name IS payment_method>class="paymentmethod_selected"<cfelse>class="paymentmethod_notselected"</cfif> onclick="selectmethod('div#id#'); document.getElementById('radio#id#').checked='checked'">
     <input id="radio#id#" type="radio" name="payment_method"  value="#qGateway.p_name#" <cfif qGateway.p_name IS payment_method>checked="checked"</cfif>>
    </div>
    </td>
    <td align="left">
    <label for="radio#id#" onclick="selectmethod('div#id#');">
        <cfif len(trim(p_image)) GT 0> <img src="images/checkout/#p_image#" alt="#p_displayname#" title="#p_displayname#" /><cfelse>#p_displayname#</cfif>
    </label>
    </td>
    
    </tr>
    </cfoutput>

	<cfset accepts_po = 'No'>    
    <!---optional 3rd party processors--->
    <cfoutput query = "q3rdParties">
	<cfif q3rdParties.p_name IS 'ponumber'>
    		<cfset accepts_po = 'Yes'>
            <tr>
            <td width="5%" onclick="selectmethod('div#id#'); document.getElementById('radio#id#').checked='checked';">
           	<div id = "div#id#" <cfif payment_method IS 'ponumber'>class="paymentmethod_selected"<cfelse>class="paymentmethod_notselected"</cfif> >
            <input type="radio" name="payment_method" id="radio#id#" value="ponumber" <cfif payment_method IS 'ponumber'>checked="checked"</cfif>>
			</div>
            </td>
            <td>
            <label for="radio#id#" onclick="selectmethod('div#id#');">
            PO Number: <cfoutput><input type = "text" size="20" name="ponumber" value="#ponumber#" /></cfoutput> <cfif isdefined('msgPONumber')><span class="requiredfields">*</span></cfif></label>
            </td>
            </tr>
        <cfelse>
            <tr>
            <td width="5%" onclick="selectmethod('div#id#'); document.getElementById('radio#id#').checked='checked'">
            <div id = "div#id#" <cfif payment_method IS q3rdParties.p_name>class="paymentmethod_selected"<cfelse>class="paymentmethod_notselected"</cfif> >
            <input type="radio" id="radio#id#" name="payment_method" value="#p_name#" <cfif q3rdParties.p_name IS payment_method>checked="checked"</cfif>>
			</div>
            </td>
            <td>
            <label for="radio#id#" onclick="selectmethod('div#id#');"><cfif len(trim(p_image)) GT 0> <img src="images/checkout/#p_image#" alt="#p_displayname#" title="#p_displayname#" /><cfelse>#p_displayname#</cfif></label>
            </td>
            </tr>
        </cfif>
    </cfoutput>
    
    <cfif NOT request.ShowGiftCardAtCheckout IS 'No'>
    <tr>
    <td colspan="2" align="left" valign="middle" class="TableTitles"><strong><em>Gift Certifcate or Gift Card </em></strong></td>
    </tr>
    <tr>
    <td height="21" colspan="2" align="left" valign="top"><p>If you have a Gift Card or a Gift Certificate, please enter the code in the box provided below:</p>
      <p>
        Gift Code:
        <input name="GiftCode" type="text" id="GiftCode" size="40" />
      </p></td>
    </tr>
    <cfelse>
    <input name="GiftCode" type="hidden" id="GiftCode" size="40" value="" />
	</cfif>
<cfelse>
<input name="GiftCode" type="hidden" id="GiftCode" size="40" value="" />
<input type = "hidden" name = "po_number" value="">
<input type = "hidden" name = "payment_method" value="offline" />
</cfif>    
</table>
<cfif accepts_po IS 'No'><input type = "hidden" name = "ponumber" value=""></cfif>
