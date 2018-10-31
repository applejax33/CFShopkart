<cfquery name = "qryCompanyInfo" datasource="#request.dsn#">
SELECT * From companyinfo, settings_main, settings_mail, settings_processors
</cfquery>







