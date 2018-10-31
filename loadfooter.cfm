<!---Include Custom Store Header--->
<cfset filelocation = '#request.catalogpath#docs#request.bslash#footer.cfm'>

<cfif NOT fileexists('#filelocation#')>
	<cffile action = 'write' file="#filelocation#" output=" ">
</cfif>

<cfinclude template = "docs/footer.cfm">

<cfinclude template = "customfootercode.cfm">