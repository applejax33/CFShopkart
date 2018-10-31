<cfquery name="qryTerms" datasource="#request.dsn#">
SELECT * From termspage
Where ID = 1
</cfquery>

<cfoutput query = "qryTerms"><span class="AffiliateTerms">#termspage#</span></cfoutput>




