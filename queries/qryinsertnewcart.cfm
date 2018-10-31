<cfset todaysdate = now()>

<cfquery name = "qryInsertNewCart" datasource="#request.dsn#">
INSERT INTO shoppingcarts
(CartToken, DateEntered, CheckedOut, affilID)
VALUES
('#CartToken#', #createodbcdate(TodaysDate)#, 'No', '#affilid#')
</cfquery>



