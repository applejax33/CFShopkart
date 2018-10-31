<h2>Downloadable Items</h2>
You can download the items you ordered now.  If you need to redownload them later, login to your account and view the order to download them
again.<br />
<p>
<table width="90%" border="0" align="center" cellpadding="4" cellspacing="0">
<tr>
  <td class="TableTitles"><div align="left" class="style2">Product Name</div></td>
  <td width="15%" class="TableTitles"><div align="left" class="style2">File Size</div></td>
  <td width="20%" class="TableTitles"><div align="center" class="style2">Link</div></td>
</tr>

<cfif allowdownloads IS 'Yes'>

<cfloop index="indexCount" from="1" To="#ListLen(qryOrders.CrtProductID, "^")#">
<cfset ThisItemID = "#ListGetAt(qryOrders.CrtItemID, indexcount, "^")#">

<cfquery name = "qryDownloads" datasource="#request.dsn#">
SELECT * FROM product_files
WHERE itemid = <cfqueryparam value="#ThisItemid#" cfsqltype="cf_sql_varchar">
</cfquery>        

<cfloop query = "qryDownloads">
<tr>
  <td><cfoutput><strong>#qryDownloads.filename#</strong></cfoutput></td>
  <td><cfoutput>#qryDownloads.filesize#</cfoutput></td>
  <td><div align="center"><cfoutput><a href="index.cfm?action=download&order=#url.ordernumber#&filename=#qryDownloads.filename#">Download</a></cfoutput></div>					
  </td>
</tr>
</cfloop>
</cfloop>

<cfelse>
<tr>
<td colspan="3">
You are not eligable for an instant download.  Your order will be manually reviewed.  Please wait approximately 24 hours, then login to your account on the main website.
</td>
</tr>
</cfif>
</table>
</p>