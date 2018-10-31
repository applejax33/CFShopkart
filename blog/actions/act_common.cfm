<!---<cfif isDefined("url.y")>
	<cfif IsNumeric(url.y) eq "no">
		<cfset url.y = #datepart("yyyy", now())#>
	</cfif>
	<cfif (IsNumeric(url.y) eq "yes") and (url.y gt #datepart("yyyy", now())#)>	
		<cfset url.y = #datepart("yyyy", now())#>
	</cfif>
<cfelse>
	<cfset url.y = #datepart("yyyy", now())#>
</cfif>
<cfif isDefined("url.m")>
	<cfif IsNumeric(url.m) eq "yes">
		<cfif url.m gt 12>
		<cfset url.m = 12>
		</cfif>
	<cfelse>
		<cfset url.m = #datepart("m", now())#>
	</cfif>
<cfelse>
	<cfset url.m = #datepart("m", now())#>
</cfif>
<cfif isDefined("url.d")>
	<cfif IsNumeric(url.d) eq "yes">
		<cfif url.d gt #DaysInMonth(CreateDate(url.y,url.m,1))#>
		<cfset url.d = #DaysInMonth(CreateDate(url.y,url.m,1))# -1>
		</cfif>
	<cfelse>
		<cfset url.d = 1>
	</cfif>
<cfelse>
	<cfset url.d = #datepart("d", now())#>	
</cfif>
<cfset dateob=CreateDate(url.y,url.m,1)>--->







