<CFQUERY Name ="VerifyUserPass" DATASOURCE = #request.dsn#>
SELECT UserName, Password FROM users WHERE UserName = '#form.EditThisUser#' AND 
Password = '#form.ChangePasswordOld#' 
</CFQUERY>

<CFIF #VerifyUserPass.recordcount# IS 0>
Invalid user password. You must supply the correct current user password in order to change 
it.
<cfabort>
</cfif>

<CFIF NOT #form.ChangePasswordNew# IS #ChangePasswordConfirm#>
The New Password and the Confirmation Password are not the same. The password 
was not changed. If you wish to change the password, please make sure that the 
New Password and the Confirmed Password are the same. 
<cfabort>
</cfif>

<CFQUERY Name = "UpdateUserInfo" Datasource = #request.dsn#>
UPDATE users 
SET Password = '#form.ChangePasswordNew#',
UserName = '#form.ChangeUserName#'
WHERE UserName = '#form.EditThisUser#' 
</CFQUERY>

<cfset CartVar.UserName = '#form.ChangeUserName#'>
<cfset CartVar.Password = '#form.ChangePasswordNew#'>

<p align="center"><b>New password was set!</b></p>
