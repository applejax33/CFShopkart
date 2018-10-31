<!---put any custom switches in this files--->
<cfswitch expression="#action#">
    <cfcase value="custom_calls">
        <cfinclude template = "plugins/sample.cfm">
    </cfcase>
</cfswitch>