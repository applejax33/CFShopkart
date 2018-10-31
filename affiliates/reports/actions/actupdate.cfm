<cfquery name = "UpdateAccount" datasource="#request.dsn#">
UPDATE afl_affiliates
SET FirstName='#form.firstname#',
LastName='#form.lastname#', 
Birthdate='#form.birthdate#', 
Email='#form.Email#', 
Phone='#form.Phone#', 
address1='#form.address1#', 
address2='#form.address2#', 
city='#form.city#', 
state='#form.state#', 
zip='#form.zip#', 
country='#form.country#',
TaxID = '#form.TaxID#', 
pnumber='#form.pNumber#'
WHERE affiliateID = #qryLogin.affiliateID#
</cfquery>
<center><b>Account information was saved!</b></center>
<p>
<cfinclude template = "../../main.cfm">