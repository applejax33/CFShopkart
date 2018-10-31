<!---figure average rating--->
<cfinclude template = "../queries/qryreviews.cfm">
<cfset totalrating = 0>
<cfoutput query="qryReviews">
	<cfset totalrating = totalrating + rating>
</cfoutput>

<cfif NOT totalrating IS 0>
	<cfset avgrating = totalrating / qryReviews.recordcount>
<cfelse>
	<cfset avgrating = 0.00>
</cfif>

<cfoutput>
<a href = "index.cfm?action=reviews_read&carttoken=#carttoken#&itemid=#itemid#">
<cfif avgrating GT 4.5 AND avgrating LT 5.1><img src = "images/ratings/stars-5-0.gif" border="0"></cfif><!---5.0--->
<cfif avgrating GT 4.0 AND avgrating LT 4.6><img src = "images/ratings/stars-4-5.gif" border="0"></cfif><!---4.5--->
<cfif avgrating GT 3.5 AND avgrating LT 4.1><img src = "images/ratings/stars-4-0.gif" border="0"></cfif><!---4.0--->
<cfif avgrating GT 3.0 AND avgrating LT 3.6><img src = "images/ratings/stars-3-5.gif" border="0"></cfif><!---3.5--->
<cfif avgrating GT 2.6 AND avgrating LT 3.1><img src = "images/ratings/stars-3-0.gif" border="0"></cfif><!---3.0--->
<cfif avgrating GT 2.0 AND avgrating LT 2.6><img src = "images/ratings/stars-2-5.gif" border="0"></cfif><!---2.5--->
<cfif avgrating GT 1.5 AND avgrating LT 2.1><img src = "images/ratings/stars-2-0.gif" border="0"></cfif><!---2.0--->
<cfif avgrating GT 1.0 AND avgrating LT 1.6><img src = "images/ratings/stars-1-5.gif" border="0"></cfif><!---1.5--->
<cfif avgrating GT 0.5 AND avgrating LT 1.1><img src = "images/ratings/stars-0-5.gif" border="0"></cfif><!---1.0--->
<cfif avgrating GT 0 AND avgrating LT .6><img src = "images/ratings/stars-0-0.gif" border="0"></cfif></a><!---0.0--->
</cfoutput>



