<cfif NOT ISDEFINED('form.ShipCodes')>
	You must select at least one Fedex shipping method.  Hit the browser back button.
	<cfabort>
</cfif>

<cfif ListLen(form.ShipCodes) IS '0'>
	You must select at least one Fedex shipping method.  Hit the browser back button.
	<cfabort>
</cfif>

<cfquery name="UpdateUPS" datasource="#request.dsn#">
UPDATE fedexconfig
SET ServiceCodes = '#form.ShipCodes#',
ServiceNames = '#form.ShipCodes#',
MultipleShippingPoints = '#form.MultipleShippingPoints#',
AccountNumber = '#form.accountnumber#',
metercode = '#form.metercode#',
ShipFromOtherLocation = '#form.ShipFromOtherLocation#',
fallbackmethod = '#form.fallbackmethod#'
</cfquery>

<cfif #form.MultipleShippingPoints# IS 'Yes'>
	<cflocation url="doshipping.cfm?action=SetShippingPoints">
</cfif>

<cfif #form.ShipFromOtherLocation# IS 'Yes'>
	<cflocation url="doshipping.cfm?action=SetShippingLocation">
</cfif>

<cfif #form.ShipFromOtherLocation# IS 'No' AND #form.MultipleShippingPoints# IS 'No'>
	<cfinclude template = "../queries/qrycompanyinfo.cfm">
	
	<cfoutput query = "qryCompanyInfo">
	<cfquery name = "SetDefaultShippingPoint" Datasource = "#request.dsn#">
		UPDATE fedexconfig
		SET ShipFromStates = '#State#',
		ShipFromCities = '#City#',
		ShipFromCountries = '#Country#',
		ShipFromZips = '#Zip#'
		</cfquery>
	</cfoutput>	
</cfif>

<cflocation url="doshipping.cfm">