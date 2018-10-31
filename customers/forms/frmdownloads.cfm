<cfset isdownloads = 'No'>

  <table width="90%" border="0" align="center" cellpadding="4" cellspacing="0">
    <tr>
        <td colspan="3">
        <h2>Downloadable Items</h2>
        </td>
    <tr>
      <td class="TableTitles"><div align="left" class="style2">Product Name</div></td>
      <td width="15%" class="TableTitles"><div align="left" class="style2">File Size</div></td>
      <td width="20%" class="TableTitles"><div align="center" class="style2">Link</div></td>
    </tr>
   
    <cfloop index="indexCount" from="1" To="#ListLen(qryOrders.CrtProductID, "^")#">
    <cfset ThisItemID = "#ListGetAt(qryOrders.CrtItemID, indexcount, "^")#">
    
    <cfquery name = "qryDownloads" datasource="#request.dsn#">
    SELECT * FROM product_files
    WHERE itemid = '#ThisItemid#'
    </cfquery>        
           
    <cfloop query = "qryDownloads">
    <cfset isdownloads = 'yes'>
    <cfif qryOrders.paid IS 'yes'>
    <tr>
      <td><cfoutput><strong>#qryDownloads.filename#</strong></cfoutput></td>
      <td><cfoutput>#qryDownloads.filesize#</cfoutput></td>
      <td><div align="center"><cfoutput><a href="index.cfm?action=download&order=#url.ordernumber#&filename=#qryDownloads.filename#">Download</a></cfoutput></div>					
      </td>
    </tr>
    </cfif>
    </cfloop>
    </cfloop>
	
	<cfif NOT qryOrders.paid IS 'yes'>
	<cfif isdownloads IS 'yes'>
        <tr>
        	<td colspan="3">
You cannot download the items yet, because your order is either under review, is in process, or was cancelled.  Please check the order status.  If you are seeing this message after 24 hours of making a purchase, please contact us.
            </td>
        </tr>
	</cfif>
	</cfif>

	<cfif isdownloads IS 'no'>
        <tr>
            <td colspan="3">
             You do not have any downloadable items on this order.
            </td>
        </tr>
    </cfif>
</table>








