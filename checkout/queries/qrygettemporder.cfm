<!----check to make sure a duplicate order isn't being inserted--->
<cfquery name = "gettempOrder" datasource="#Request.dsn#">
SELECT * FROM 
temporders
Order By OrderID Desc
</cfquery>







