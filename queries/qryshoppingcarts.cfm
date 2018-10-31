<cfquery name = "qryShoppingCarts" datasource = "#request.dsn#">
  SELECT * FROM shoppingcarts
  WHERE CartToken = <cfqueryparam value="#CartToken#" cfsqltype="cf_sql_varchar">
</cfquery>





