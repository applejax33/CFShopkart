<cfset Cart.CartToken = '0'>

<cfif ISDEFINED('cookie.CartToken')>
	<cfset Cart.CartToken= '#Cookie.CartToken#'>
</cfif>

<cfif ISDEFINED('session.CartToken')>
	<cflock type="readonly" scope="session" timeout="10">
		<cfset Cart.CartToken='#session.CartToken#'>
	</cflock>
</cfif>

<cfquery name = "qryShoppingCarts" datasource = "#request.dsn#">
  SELECT * FROM shoppingcarts
  WHERE CartToken = <cfqueryparam value="#Cart.CartToken#" cfsqltype="cf_sql_varchar">
</cfquery>








