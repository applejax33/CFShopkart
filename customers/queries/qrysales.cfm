<!---Gets every order in the database--->
<CFQUERY Name ="qrySales" DATASOURCE = #request.dsn#>
 	SELECT *
	FROM Orders
	Order By DateOfOrder ASC
</CFQUERY>







