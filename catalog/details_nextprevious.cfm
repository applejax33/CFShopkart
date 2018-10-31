<!---***Display Previous and Next Item links in a table****--->
<!---It only displays if browsing a category, therefore url.category must be present.--->
<cfif isdefined('url.category')>
	<cfquery name = "qryItems" dbtype="query">
	SELECT itemid FROM qryCatalog
	</cfquery>
	
	<!---Get the current row number--->
	<cfset itemrow = 1>
	<cfloop query="qryItems">
		<cfif itemid IS url.itemid>
			<cfset itemrow = qryItems.currentrow>
		</cfif>	
	</cfloop>
	
	<cfset nextrow = itemrow + 1>
	<cfset prevrow = itemrow - 1>
	
	<cfloop query="qryItems">
		<!---If the item is not in row 1 of the query then get the previous item id--->
		<cfif itemrow GT 1>
			<cfif qryItems.currentrow IS prevrow>
				<cfset previtem = qryItems.itemid>
			</cfif>	
		</cfif>
		<!---If the item is not in the last row of the query then get the next item--->
		<cfif NOT itemrow IS qryItems.recordcount>
			<cfif qryItems.currentrow IS nextrow>
			  <cfset nextitem = qryItems.itemid>
			</cfif>
		</cfif>
	</cfloop>
	
	<cfoutput>
	<table width="100%" cellpadding="4" cellspacing="0" class="nextprevioustable">
	<tr>
	<td width = "50%" align="left" class="previouscell"><div align="left"><cfif itemrow GT 1>< <a href = "index.cfm?action=viewdetails&viewby=#viewby#&category=#url.category#&sortorder=#sortorder#&itemid=#previtem#">Previous Product</a></cfif></div></td>
	<td align="right" class="nextcell"><div align="right"><cfif NOT itemrow IS qryItems.recordcount><a href = "index.cfm?action=viewdetails&viewby=#viewby#&category=#url.category#&sortorder=#sortorder#&itemid=#nextitem#">Next Product</a> ></cfif></div>
	</td>
	</tr>
	</table>
	</cfoutput>
</cfif>





