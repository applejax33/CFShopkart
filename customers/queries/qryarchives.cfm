<CFQUERY Name ="qryArchives" DATASOURCE = "#request.dsn#">
 	SELECT *
	FROM Orders
	WHERE OrderCompleted = <cfqueryparam value="Yes" cfsqltype="cf_sql_varchar">
	<cfif ISDEFINED('TempVar.reportmonth')>
		<cfif NOT TempVar.reportmonth IS '99'>
    		AND (((DatePart('m', [DateofOrder]))= <cfqueryparam value="#TempVar.ReportMonth#" cfsqltype="cf_sql_integer">))
		</cfif>
	</cfif>
	<cfif ISDEFINED('TempVar.reportYear')>
    	AND (((DatePart('yyyy', [DateofOrder])) = <cfqueryparam value="#TempVar.ReportYear#" cfsqltype="cf_sql_integer">))
	</cfif>
	ORDER BY DateOfOrder DESC
</CFQUERY>








