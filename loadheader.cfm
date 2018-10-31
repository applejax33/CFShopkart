<!---Include Custom Store Header--->
<cfset filelocation = '#request.catalogpath#docs#request.bslash#header.cfm'>

<cfif NOT fileexists('#filelocation#')>
	<cffile action = 'write' file="#filelocation#" output=" ">
</cfif>

<cfinclude template = "docs/header.cfm">

