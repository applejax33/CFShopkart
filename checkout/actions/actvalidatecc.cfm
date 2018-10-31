<!---Validates the credit card information entered into the payment form if it's displayed--->
<cfif isdefined('form.card_type')>
	<cfset URLString = '?action=reviewredo'>

    <CFLOOP COLLECTION="#Form#" ITEM="VarName">
      <cfset URLString = '#URLString#&#VarName#=#evaluate(varname)#'>
    </CFLOOP>
	
	<cfset ErrorMessage = ''>
    <cfset TotalErrors = 0>
    <cfset ErrorList = ''>

	<!---if the order is $0.00 then we skip this--->
    <cfif form.OrderTotal GT 0>	
        <!---Check for empty values--->
        <cfif Len(form.card_number) IS 0>
            <cfset TotalErrors = TotalErrors + 1>
            <cfset ErrorList = ListAppend(ErrorList,'card_number')>
            <cfset ErrorMessage = ErrorMessage & '-> Please supply a credit card number!<br>'>
        </cfif>
        
        <cfif Len(form.card_cvs) IS 0>
            <cfset TotalErrors = TotalErrors + 1>
            <cfset ErrorList = ListAppend(ErrorList,'card_cvs')>
            <cfset ErrorMessage = ErrorMessage & '-> Please supply a CCID! <br>'>
        </cfif>
        
        <!---No spaces allowed--->
        <cfif form.card_number CONTAINS ' '>
            <cfset TotalErrors = TotalErrors + 1>
            <cfset ErrorList = ListAppend(ErrorList,'card_number')>
            <cfset ErrorMessage = ErrorMessage & '-> Please remove all spaces from the Credit Card Number. <br>'>
        </cfif>
        
        <cfif NOT isnumeric(form.card_number)>
            <cfset TotalErrors = TotalErrors + 1>
            <cfset ErrorList = ListAppend(ErrorList,'card_number')>
            <cfset ErrorMessage = ErrorMessage & '-> The Credit Card Number cannot contain letters.  It must be numeric. <br>'>
        </cfif>
        
        
        <!---Check for expired card--->
        <cfset todaysdate = now()>
        <cfset CurrentMonthYear = dateformat(todaysdate, "mm/01/yyyy")>
        <cfset EnteredExp = createdate(form.card_expyear, form.card_expmonth, 01)>
        
        <cfif EnteredExp LT CurrentMonthYear>
            <cfset TotalErrors = TotalErrors + 1>
            <cfset ErrorList = ListAppend(ErrorList,'ExpiresOn')>
            <cfset ErrorMessage = ErrorMessage & '-> The card you entered seems to be expired.  Check the expiration date you entered. <br>'>
        </cfif>
        
        <!---Master Card Checks--->
        <cfif form.card_type IS 'MASTERCARD'>   
            <cfif NOT len(form.card_number) IS 16>
                <cfset TotalErrors = TotalErrors + 1>
                <cfset ErrorList = ListAppend(ErrorList,'card_number')>
                <cfset ErrorMessage = ErrorMessage & '-> The MasterCard Number you entered is invalid.  It should be a 16 Digit number. <br>'>
            </cfif>
        
            <cfif left(form.card_number, 2) LT '51' AND left(form.card_number, 2) GT '55'>
                <cfset TotalErrors = TotalErrors + 1>
                <cfset ErrorList = ListAppend(ErrorList,'card_number')>
                <cfset ErrorMessage = ErrorMessage & '-> The Master Card Number you entered appears to be invalid. Please check the number.<br>'>  
            </cfif>   
        </cfif>
        <!---End Master Card Checks--->
        
        <!---Visa Checks--->
        <cfif form.card_type IS 'VISA'>
            <cfif NOT len(form.card_number) IS 16 AND NOT len(form.card_number) IS 13>
                <cfset TotalErrors = TotalErrors + 1>
                <cfset ErrorList = ListAppend(ErrorList,'card_number')>
                <cfset ErrorMessage = ErrorMessage & '-> The Visa Number you entered is invalid.  It should be 13 or 6 digits number. <br>'>   
            </cfif>   
        
            <cfif NOT left(form.card_number, 1) IS 4>
                <cfset TotalErrors = TotalErrors + 1>
                <cfset ErrorList = ListAppend(ErrorList,'card_number')>
                <cfset ErrorMessage = ErrorMessage & '-> The Visa Number you entered appears to be invalid.. <br>'>   
            </cfif>     
        </cfif>	
        <!---End Visa Checks--->
        
        <!---American Express Checks--->
        <cfif form.card_type IS 'AMEX'>
            <cfif NOT len(form.card_number) IS 15>
                <cfset TotalErrors = TotalErrors + 1>
                <cfset ErrorList = ListAppend(ErrorList,'card_number')>
                <cfset ErrorMessage = ErrorMessage & '-> The American Express Number you entered is invalid.  It should be a 15 Digit number. <br>'>  
            </cfif>
            
            <cfif NOT left(form.card_number, 2) IS 34 AND NOT left(form.card_number, 2) IS 37>
                <cfset TotalErrors = TotalErrors + 1>
                <cfset ErrorList = ListAppend(ErrorList,'card_number')>
                <cfset ErrorMessage = ErrorMessage & '-> The American Express Number you entered appears to be invalid. <br>'>  
            </cfif>       
        </cfif>	
        <!---End American Express Checks--->
        
        <!---Discover Checks--->
        <cfif form.card_type IS 'DISCOVER'>
            <cfif NOT len(form.card_number) IS 16>
                <cfset TotalErrors = TotalErrors + 1>
                <cfset ErrorList = ListAppend(ErrorList,'card_number')>
                <cfset ErrorMessage = ErrorMessage & '-> The Discover Card Number you entered is invalid.  It should be a 16 Digit number. <br>'>  
            </cfif>   
        
            <cfif NOT left(form.card_number, 4) IS '6011'>
                <cfset TotalErrors = TotalErrors + 1>
                <cfset ErrorList = ListAppend(ErrorList,'card_number')>
                <cfset ErrorMessage = ErrorMessage & '-> The Discover Card Number you entered is invalid. <br>'>  
            </cfif>   
        </cfif>	
        <!---End Discover Checks--->
    </cfif>
	
	<cfset URLString = URLString & '&ErrorMessage=#ErrorMessage#&TotalErrors=#TotalErrors#&ErrorList=#ErrorList#&carttoken=#carttoken#'>
    
    <cfif TotalErrors GT 0>
        <cfset url.errormessage = errormessage>
        <cfset url.totalerrors = totalerrors>
        <cfset url.errorlist = errorlist>
        
        <cfinclude template = "../forms/frmrevieworder.cfm">
        
        <cfset v_passed = 0>
	<cfelse>
        <cfset v_passed = 1>
    </cfif>
<!---If there are no errors then it will continue with process.cfm--->
</cfif>