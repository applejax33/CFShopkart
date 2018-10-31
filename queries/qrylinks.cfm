<cfquery name="qrylinks" datasource="#request.dsn#">
SELECT * 
FROM links 
ORDER By LinkOrder ASC 
</cfquery>



