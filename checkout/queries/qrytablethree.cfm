<cfquery name = "qryTableThree" datasource = #request.dsn#>
SELECT *
FROM shippingtable3
<CFIF ISDEFINED('url.ShippingID')>
	WHERE ShippingID = <cfqueryparam value="#url.ShippingID#" cfsqltype="cf_sql_integer">
</CFIF>
<cfif ISDEFINED('Cart.TotalCartWeight')>
WHERE MinWeight <= <cfqueryparam value="#Cart.TotalCartWeight#" cfsqltype="cf_sql_integer"> 
AND MaxWeight >= <cfqueryparam value="#Cart.TotalCartWeight#" cfsqltype="cf_sql_integer">
</cfif>
</cfquery>







