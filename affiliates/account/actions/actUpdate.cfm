<cfset updatephoto = 'No'>
<cfif len(trim(form.photo)) GT 0>
	<cffile action="upload" filefield="photo" destination="#request.catalogpath#affiliates#request.bslash#photos" nameconflict="makeunique">
	<cfset photo = "#cffile.ServerFile#">   
    <cfset updatephoto = 'yes'>
</cfif>

<cfif len(trim(form.taxid)) GT 0>
	<cfset enc_ssn = #encrypt(form.taxid, request.seedstring)#>
    <cfset enc_ssn = #replace(enc_ssn, "/", "//", "ALL")#>
    <cfset enc_ssn = #replace(enc_ssn, "#request.bslash#", "#request.bslash##request.bslash#", "ALL")#>
</cfif>

<cfquery name = "UpdateAccount" datasource="#request.dsn#">
UPDATE afl_affiliates
SET FirstName=<cfqueryparam value="#form.firstname#" cfsqltype="cf_sql_varchar">,
LastName=<cfqueryparam value="#form.lastname#" cfsqltype="cf_sql_varchar">, 
Email=<cfqueryparam value="#form.Email#" cfsqltype="cf_sql_varchar">, 
Phone=<cfqueryparam value="#form.Phone#" cfsqltype="cf_sql_varchar">, 
address1=<cfqueryparam value="#form.address1#" cfsqltype="cf_sql_varchar">, 
address2=<cfqueryparam value="#form.address2#" cfsqltype="cf_sql_varchar">, 
city=<cfqueryparam value="#form.city#" cfsqltype="cf_sql_varchar">, 
state=<cfqueryparam value="#form.state#" cfsqltype="cf_sql_varchar">, 
zip=<cfqueryparam value="#form.zip#" cfsqltype="cf_sql_varchar">, 
<cfif isdefined('enc_ssn')>TaxID=<cfqueryparam value="#enc_ssn#" cfsqltype="cf_sql_varchar">,</cfif>
<cfif updatephoto IS 'yes'>photo=<cfqueryparam value="#photo#" cfsqltype="cf_sql_varchar">,</cfif>
contacthours=<cfqueryparam value="#form.contacthours#" cfsqltype="cf_sql_varchar">
WHERE affiliateID = <cfqueryparam value="#qryLogin.affiliateID#" cfsqltype="cf_sql_varchar">
</cfquery>

<center><b>Your account information was saved!</b></center>







