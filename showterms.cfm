<cfif fileexists('#request.catalogpath#docs#request.bslash#terms.cfm')>
<cfinclude template="docs/terms.cfm">
<cfelse>
Terms and conditions file was not found.  Site owner:  Please refer to the help context for this feature to create your Terms and Conditions.
</cfif>