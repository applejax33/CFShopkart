<!---if they use access codes, this file will mark it as used (this is done after checkout and called from frmFinalized.cfm)--->
<cfif isdefined('cookie.access_code')>
    <cfquery name = "qryUpdateAccessCodeToUsed" datasource="#request.dsn#">
    UPDATE accesscodes
    SET wasused = '1',
    ordernumber = '#ordernumber#'
    WHERE authcode = '#cookie.access_code#' AND pincode = '#cookie.access_pin#'
    </cfquery>
    
    <cfcookie name="access_code" expires="NOW" value="NONE">
    <cfcookie name="access_pin" expires="NOW" value="NONE">
    <cfcookie name="access_maxamount" expires="NOW" value="NONE">
</cfif>







