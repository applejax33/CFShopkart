<div align="left">
  <font size="3"><strong>Hello <cfoutput>#qryLogin.FirstName#</cfoutput></strong></font>
  <p>It is <cfoutput>#DateFormat(Now(),"dddd, mmmm d, yyyy")#</cfoutput></p>
</div>

<cfif len(trim(qryLogin.taxid)) IS 0 AND len(trim(qryLogin.pnumber)) IS 0>
	<div style="border: 1px solid #000000; padding:6px; background: #FFFFCC;"><font color="#FF0000"><strong>You have not provided a tax identification number yet:</strong></font><br />
    You will not receive payment until you have provided a tax identification number (Social Security Number or EIN for U.S. Residents).  This information is necessary before we can pay out any commissions.<br /></div>
</cfif>
<cfif qryLogin.has1099 IS 'No'>
<br />
<div style="border: 1px solid #000000; padding:6px; background: #FFFFCC;">
<font color="#FF0000"><strong>You have not sent in your 1099 Form yet</strong></font>
A 1099 form is an IRS tax form used for the purposes of reporting income.  Our records indicate that you have not yet filled out and sent us a 1099 form. 
We require all affiliates to send us a completed 1099 before we can pay out any commissions.  You can find a link to the 1099 form on the menu.
</div>
</cfif>


<cfif qMessages.recordcount GT 0>
	<div align="left"><strong><font color="#990000">You have a new message!</font></strong></div>
</cfif>
<div style="padding-top: 20px;">
<cffile action="read" file="#request.catalogpath#affiliates#request.bslash#pages#request.bslash#homepage.cfm" variable="pagecontent">

<cfoutput>#pagecontent#</cfoutput>
</div>

