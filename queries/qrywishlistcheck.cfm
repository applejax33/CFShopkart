<cfquery name = "qryWishlistCheck" datasource="#request.dsn#">
SELECT * FROM widgets
WHERE widgetname = 'Wish List'
</cfquery>



