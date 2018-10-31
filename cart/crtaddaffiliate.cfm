<!---Get the last accountID in this group--->
<cfquery name = "qryAffiliates" datasource="#request.dsn#">
SELECT * FROM afl_affiliates ORDER BY accountID DESC
</cfquery>

<cfset lastID = '1001'>
<cfoutput query = "qryAffiliates" maxrows="1">
	<cfset lastID = affiliateid>
</cfoutput>

<!---Now increment it by one--->
<cfset NewID = lastid + 1>

<cfset todaysdate = now()>

<cfset thepath = "/">
<!---build their path, base it on the referring affiliate--->
<cfquery name = "qryParent" datasource="#request.dsn#">
SELECT * FROM afl_affiliates
WHERE affiliateID = '#form.referredby#'
</cfquery>

<cfoutput query = "qryParent">
	<cfset thepath = "#path##form.referredby#/">
</cfoutput>

<cfset newaffiliateid = Newid>

<!---check for duplicate entry--->
<cfquery name = "qryCheckDuplicate" datasource="#request.dsn#">
SELECT * FROM afl_affiliates WHERE email = '#form.email#'
</cfquery>

<cfif qryCheckDuplicate.recordcount GT 0>
    <h3>Affiliate Signup</h3>
    The email address you entered has already been used to create an affiliate account.  <br />
    Please check the email address and try again or use a different one.  <br />
    If you have lost your affiliateID and or password, please contact us.
    <cfelse>
    <cfquery name = "AddAccount" datasource="#request.dsn#">
    INSERT INTO afl_affiliates
    (DateSignup, groupid, accountid, affiliateid, Company, FirstName, LastName, Email, Phone, address1, address2, city, state, zip, country, subaffiliateof, path, password, sales, cEarned, cPaid, cPending, hits, CheckName, account_status)
    VALUES
    (#createodbcdatetime(todaysdate)#, '', '#Newid#', '#newaffiliateid#', '#form.company#', '#form.firstname#', '#form.lastname#', '#form.Email#', '#form.Phone#', '#form.address1#', '#form.address2#', '#form.city#', '#form.state#', '#form.zip#', '#form.country#', '#form.referredby#', '#thepath#', '#form.password#', 0, 0, 0, 0, 0, '#form.checkname#', '1')
    </cfquery>

	<cfif fileexists('#request.catalogpath#docs/aff_join.cfm')>

        <cfsavecontent variable="aff_joinmsg">
            <cfinclude template = '../docs/aff_join.cfm'>
        </cfsavecontent>
        
        <cfset aff_joinmsg = replacenocase(aff_joinmsg, "[firstname]", form.firstname, "ALL")>
        <cfset aff_joinmsg = replacenocase(aff_joinmsg, "[lastname]", form.lastname, "ALL")>
        <cfset aff_joinmsg = replacenocase(aff_joinmsg, "[email]", form.email, "ALL")>
        <cfset aff_joinmsg = replacenocase(aff_joinmsg, "[password]", form.password, "ALL")>
        <cfset aff_joinmsg = replacenocase(aff_joinmsg, "[affiliateid]", newaffiliateid, "ALL")>
        
        <cfoutput>#aff_joinmsg#</cfoutput>

	<cfelse>

		<cfset datesignup = Now()>
        <cfoutput>
        <h3>Affiliate Signup</h3>
        Thank you, #form.firstname#, for registering as an affiliate!  You can now login to your account.<br>
        <br />&nbsp;<br />
        <div class="aff_login_button">
            <form name="NewSignup" action="affiliates/affiliates.cfm" method="post" target="_blank">
        <input type="hidden" name="Affiliateid" value="#newaffiliateid#"> 
        <input type="hidden" name="affiliatepw" value="#form.password#"> 
        <input type="submit" value="Go to Affiliate Admin"> 
        </form>
        </div>
        </cfoutput>

	</cfif>

</cfif>