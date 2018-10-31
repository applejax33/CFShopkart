<!---check valid order number--->
<cfquery name = "qryValidOrder" datasource="#request.dsn#">
SELECT * FROM orders
WHERE ordernumber = <cfqueryparam value="#url.order#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfquery name = "qryDownload" datasource="#request.dsn#">
SELECT * FROM product_files
WHERE filename = <cfqueryparam value="#url.filename#" cfsqltype="cf_sql_varchar">
</cfquery>

<!---make sure order is valid, that it was paid, and that the order contains the itemid necessary to allow this download--->
<cfset allowdownload = 'No'>
<cfif qryValidOrder.recordcount GT 0>
	yup<br />
	<cfif qryValidOrder.paid IS 'Yes'>yup<br /><cfoutput>#qryValidOrder.crtItemid# - #qryDownload.itemid#</cfoutput><br />
    	<cfif qryValidOrder.crtItemid CONTAINS '#qryDownload.itemid#'>yup<br />
        	<cfset allowdownload = 'Yes'>
			<CFSET fnameandpath = "#request.downloadspath##url.filename#">
			<!--- //Force the browser to download the file and give it a filename. --->
			<CFHEADER NAME="content-disposition" VALUE="attachment; filename=#url.filename#">
			<CFCONTENT TYPE="application/zip" FILE="#fnameandpath#" DeleteFile="No">
        </cfif>
     </cfif>
</cfif>

<cfif allowdownload IS 'No'>
You do not have permission to download this file.
</cfif>



