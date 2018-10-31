<!--Displays the featured items in a vertical table--->
<cfinclude template = "../queries/qryBestSellers.cfm">
<cfinclude template = "../queries/qrysales.cfm">
<cfif NOT qryBestSellers.recordcount IS 0>

<cfset BestSellerToShow = #RandRange(1, qryBestSellers.recordcount)#>

<cfoutput query = "qryBestSellers" startrow="#BestSellerToShow#" maxrows="1"> 
<p align="center">
<a href="index.cfm?carttoken=#carttoken#&action=ViewDetails&itemid=#itemid#">
<cfinclude template = "../queries/qryBestSellersProductimages.cfm">

<cfset TheThumbnail = "#request.secureURL#photos/tiny/nopic.jpg">

<cfloop query = "qry_ProductImages" startrow="1" endrow="1">
	<cfset TheThumbnail = "#request.secureURL#photos/tiny/#qry_ProductImages.iFileName#">
</cfloop>
<img src="#TheThumbnail#" alt="#ProductName#" name="BestSeller" border="0" title="#ProductName#" class="BestSellerImage">

<br><span class="BestSellerProductName">#ProductName#</span></a>
<p align="center">
<a href="index.cfm?carttoken=#carttoken#&action=ShowBestSellers" class="MoreBestSellersLink">[More Best Sellers]</a>
</p>
</cfoutput>
</cfif>



