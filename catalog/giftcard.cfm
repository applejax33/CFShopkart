<cfset posturl = "index.cfm?carttoken=#carttoken###giftcardchecker">

<cfif isdefined('CGI.QUERY_STRING')>
	<cfset posturl = "index.cfm?#CGI.QUERY_STRING###giftcardchecker">
</cfif>

<cfif NOT isdefined('form.giftcodecheck')>
<form name = "giftcheckform" method="post" <cfoutput>action="#posturl#"</cfoutput>>
	<center>
	  Enter Code below
	</center>
	<br>
	<center><input type = "text" name="giftcodecheck" /></center><br>
	<center><input type = "submit" name="submit" value="Check Balance"/></center>
</form>
</cfif>

<cfif isdefined('form.giftcodecheck')>
	<cfinclude template = "../queries/qrygiftcards.cfm">
	
	<cfif qryGiftCard.recordcount IS 0>
		<center><font color="#FF0000">Invalid code</font></center>
<form name = "giftcheckform" method="post" <cfoutput>action="#posturl#"</cfoutput>>
	<br>
	<center><input type = "text" name="giftcodecheck" size="15" /></center><br>
	<center><input type = "submit" name="submit" value="Check Balance"/></center>
</form>	
		
		<cfelse>
		
			<cfoutput query = "qryGiftCard">
				<center>The Current balance is 
				<p>
			    <strong><font size = "3">$#numberformat(gAmountLeft, ".00")#</font></strong>
			</cfoutput>
					
  </cfif>
		
</cfif>




