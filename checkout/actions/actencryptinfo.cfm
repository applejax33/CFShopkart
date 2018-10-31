<cfif len(trim(form.CreditCardNumber)) GT 0>
	<cfset encCreditCardNumber = #encrypt(form.card_number, request.SeedString)#>
	<cfset encCreditCardNumber = #replace(encCreditCardNumber, "/", "//", "ALL")#>
	<cfset encCreditCardNumber = #replace(encCreditCardNumber, "\", "\\", "ALL")#>

	<cfset encCardCode = #encrypt(form.card_cvs, request.SeedString)#>
    <cfset encCardCode= #replace(encCardCode, "/", "//", "ALL")#>
    <cfset encCardCode= #replace(encCardCode, "\", "\\", "ALL")#>
<cfelse>
	<cfset encCreditCardNumber = 'Not Provided'>
    <cfset encCardCode = 'Not Provided'>    
</cfif>







