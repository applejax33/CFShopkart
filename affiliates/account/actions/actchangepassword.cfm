<CFQUERY Name ="VerifyUserPass" datasource = "#request.dsn#">
SELECT * FROM afl_affiliates 
WHERE affiliateid = <cfqueryparam value="#form.EditThisUser#" cfsqltype="cf_sql_varchar">
AND Password = <cfqueryparam value="#form.ChangePasswordOld#" cfsqltype="cf_sql_varchar">
</CFQUERY>

<cfif qryLogin.AffiliateID IS '1010000001' OR qryLogin.AffiliateID IS '1010000002' OR qryLogin.AffiliateID IS '1010000003'>
	You cannot change a demo users password.
    <cfabort>
</cfif>

<CFIF #VerifyUserPass.recordcount# IS 0>
Invalid password. You must supply your current password in order to change it.
<cfabort>
</cfif>

<CFIF NOT #form.ChangePasswordNew# IS #form.ChangePasswordConfirm#>
The New Password and the Confirmation Password are not the same. The password 
was not changed. If you wish to change the password, please make sure that the 
New Password and the Confirmed Password fields are the same. 
<cfabort>
</cfif>

<CFQUERY Name = "UpdateUserInfo" Datasource = #request.dsn#>
UPDATE afl_affiliates
SET Password = <cfqueryparam value="#form.ChangePasswordNew#" cfsqltype="cf_sql_varchar">
WHERE AffiliateID = <cfqueryparam value="#form.EditThisUser#" cfsqltype="cf_sql_varchar"> 
</CFQUERY>

<cflock scope="session" timeout="10" type="exclusive">
	<cfset session.AffiliatePW = '#form.ChangePasswordNew#'>
</cflock>
<p align="center"><b>New password was set!</b></p>
