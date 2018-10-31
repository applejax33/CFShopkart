<cfparam name="ShowButton" default="Yes">
<cfparam name="OriginalPrice" default="0">
<cfparam name = "viewby" default="fordervalue">
<cfparam name = "sortorder" default="ASC">
<cfparam name = "category" default = "0">
<cfparam name = "itemid" default = "0">
<cfparam name = "processpage" default = "Yes">

<cfinclude template = "../queries/qryproducts.cfm">

<cfif qryproducts.RecordCount IS 0>
	<cfset processpage = 'No'>
</cfif>

<cfif request.pricinglevel GT 0>

	<cfset levelprice = qryProducts.price>

	<cfquery name = "qPrice" datasource="#request.dsn#">
    SELECT * FROM products_pricing
    WHERE itemid = '#itemid#'
    AND level = #request.pricinglevel#
    </cfquery>
    
    <cfoutput query = "qPrice">
    	<cfset levelprice = qPrice.price>
    </cfoutput>
</cfif>

<cfif processpage IS 'Yes'>
    <cfinclude template = "details_header.cfm">
	<cfinclude template = "details_layout.cfm">
	<cfinclude template = "PrintDiv.cfm">
</cfif>

<cfif processpage IS 'No'>
  <h3>Oops!</h3>
  <font size = "3">The product you are trying to view is no longer available. <br />It has been removed from the catalog.</font>
 <p>
 <cfoutput><a href = "#request.homeurl#">Click here to go to the homepage</a>.</cfoutput></p>
</cfif>



