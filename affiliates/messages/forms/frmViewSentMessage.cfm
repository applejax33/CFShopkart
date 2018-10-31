
<!---Mark this message as read--->
<cfinclude template = "../queries/qrySentMessage.cfm"> 
<cfloop query = "qrySentMessage">
<span class = "message">
  <cfoutput><strong><font size="4">Viewing Message</font></strong> 
    <p><strong>Message Sent on:</strong> #datesent#</p>
    <p><strong>Message Sent To: </strong>#SentTo#</p>
    <p><strong>Subject: </strong>#subject#</p>
    <p><strong>Message: </strong>
	<p>#paragraphformat(body)#</p>
  </cfoutput> 
</span>
 </cfloop>








