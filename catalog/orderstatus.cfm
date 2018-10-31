<cfset posturl = "index.cfm?carttoken=#carttoken###orderchecker">

<cfif isdefined('CGI.QUERY_STRING')>
	<cfset posturl = "index.cfm?#CGI.QUERY_STRING###orderchecker">
</cfif>

<cfif NOT isdefined('form.ordercheck')>
<form name = "ordercheckform" method="post" <cfoutput>action="#posturl#"</cfoutput>>
	<center>Enter your order number to quickly check the status</center>
	<br>
	<center><input type = "text" name="ordercheck" size="15" /></center><br>
	<center><input type = "submit" name="submit" value="Check Status" class="orderstatus_button" /></center>
</form>
</cfif>

<cfif isdefined('form.ordercheck')>
	<cfinclude template = "../queries/qryorders.cfm">
	
	<cfif qryOrder.recordcount IS 0>
		<center><font color="#FF0000">We could not find that order number in our system!</font></center>
		<form name = "ordercheckform" method="post" <cfoutput>action="#posturl#"</cfoutput>>
			<center><input type = "text" name="ordercheck" size="15" /></center><br>
			<center><input type = "submit" name="submit" value="Check Status" class="orderstatus_button" /></center>
		</form>		
		
		<cfelse>
		
			<cfoutput query = "qryOrder">
				<center>The Current Status of your order is: <br>
				  <strong>#OrderStatus#</strong>
				<p>
				<cfif len(notes) GT 0>
					There is an important note on the order!<br>
				</cfif>
				<a href = "index.cfm?action=MyAccount&carttoken=#carttoken#">Login to your account to view more details</a></center>	
			</cfoutput>
					
  </cfif>
		
</cfif>



