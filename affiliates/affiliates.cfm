<html>
<head>
<title>Affiliate System Control Panel</title>
</head>
<body bgcolor="#FFFFFF">

<!---Get the datasource and paths--->
<cfparam name="action" default = "default.default">
<cfif NOT action IS 'login' and NOT action IS 'lostpwd'>
	<cfinclude template = "actions/actchecklogin.cfm">
</cfif>
 <cfinclude template="../header.cfm">
	<table width="100%" height="599" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="220" align="center" valign="top" bgcolor="#000099">
		<table width = "100%" Height= "30" cellpadding="4" cellspacing="0">
			<tr>
				<td align="left" bgcolor="#6B9ACE" class="menutop">
					<cfoutput>
					        <a href="affiliates.cfm" class="menutop"><font color="##FFFFFF">Main</font></a>&nbsp;&nbsp; <a href="affiliates.cfm?action=account.logout" class="menutop"><font color="##FFFFFF">Logout</font></a>
		      </cfoutput>			        </td>
			</tr>
		</table>
	<cfinclude template = "navmenu/menu.cfm">&nbsp;		</div>		</td>
		
    <td valign="top" bgcolor="#FFFFFF">
		<table width="100%" border="0" cellpadding="4">
			<tr>
				<td bgcolor="#FFFFFF">
				<cfset request.component = listgetat(action, 1, ".")>
				<cfif listlen(action, ".") IS 2>
					<cfset request.action = listgetat(action, 2, ".")>
				</cfif>

				<cfswitch expression="#request.component#">
					<cfcase value="messages">
						<cfinclude template = "messages/messages.cfm">
					</cfcase>
					<cfcase value="reports">
						<cfinclude template = "reports/reports.cfm">
					</cfcase>
					<cfcase value="account">
						<cfinclude template = "account/account.cfm">
					</cfcase>
					<cfcase value="login">
						<cfinclude template = "login.cfm">
					</cfcase>			
					<cfcase value="lostpwd">
						<cfinclude template = "lostpwd.cfm">
					</cfcase>			
					<cfdefaultcase>				
						<cfinclude template = "main.cfm">
					</cfdefaultcase>
				</cfswitch>
				</td>
			</tr>
	</table>   </td>
  </tr>
</table>
</body>
</html>

