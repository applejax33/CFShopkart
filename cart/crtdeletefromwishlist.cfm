<cfquery name = "qryDeleteFromWishList" datasource="#request.dsn#">
DELETE FROM wishlistitems
WHERE id = <cfqueryparam value="#url.id#" cfsqltype="cf_sql_integer">
</cfquery>

<cflocation url = "index.cfm?action=editwishlist">



