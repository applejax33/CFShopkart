<cfif NOT fileexists('#request.catalogpath#docs#request.bslash#header.cfm')>
	<cffile action = 'write' file="#request.catalogpath#docs#request.bslash#header.cfm" output=" ">
</cfif>

<cffile action="read" file="#request.catalogpath#docs#request.bslash#header.cfm" variable="StoreHeader">















