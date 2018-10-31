<!---Generates a unique order number if one wasn't already created for this session--->
<cfif NOT ISDEFINED('session.CustomerOrderNumber')>

<cfset charlist  = "0|2|4|6|8|9|7|5|3|1|0|2|4|6|8|9|7|5|3|1">

<cfset OrderNo = "">
<cfloop condition="NOT len(OrderNo)">

	<cfloop from="1" to="5" index="i">
		<!--- pick a random number between 1 and the length of the list of chars to use --->
		<cfset ThisNum = RandRange(1,listlen(charlist, "|"))>
	
		<!--- get the character that is at the random numbers position in the list of characters ---> 
		<cfset ThisChar = ListGetAt(Charlist, ThisNum, "|")>
	
		<!--- append the new random character to the CustPassword ---> 
		<cfset OrderNo = "#OrderNo##ThisChar#">
	</cfloop>
	
    <cfset OrderNo = '#request.ordernumber_prefix##OrderNo#'>
    
	<!--- Make sure code is not already in use --->
	<cfquery name="CheckOrderNo" datasource="#Request.dsn#">
	SELECT OrderNumber FROM orders
	WHERE OrderNumber = '#OrderNo#'
	</cfquery>
	
	<!---Already used so generate another one--->
	<cfif CheckOrderNo.RecordCount>
		<cfset OrderNo = "">
	</cfif>

</cfloop>

<cfset NewOrderNumber = #OrderNo#>

<!---Create a fraud score variable too along with a couple tracking variables.  
	 All new orders start with a fraud score of 10 (meaning minimal chance of fraud--->

<cfcookie name="CustomerOrderNumber" value = "#NewOrderNumber#" expires="never">
</cfif>

<!---If the CustomerOrderNumber was already created then set the temp variable to it.--->
<cfif ISDEFINED('cookie.CustomerOrderNumber')>
	<cfset Cart.CustomerOrderNumber = #cookie.CustomerOrderNumber#>
</cfif>