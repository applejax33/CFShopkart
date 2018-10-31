<cfparam name = "attributes.widgettitle" default="Products">
<cfparam name = "attributes.widgetfile" default="categories.cfm">
<cfparam name = "attributes.dsn" default="megalinxmall">
<cfparam name = "attributes.carttoken" default="NULL">
<cfparam name = "attributes.showtitle" default="Yes">
<cfparam name = "attributes.WidgetQuery" type="query" default="#querynew('')#">
<cfparam name = "attributes.widgetid" default="1">
<cfparam name = "attributes.customstyles" default="">
<cfparam name = "attributes.title_image" default="">

<cfset request.dsn = attributes.dsn>
<cfset carttoken = attributes.carttoken>

<cfif request.dsn IS 'megalinxmall'>
	You must pass the dsn into the tag!
    <cfabort>
</cfif>
<table width="100%" cellspacing="0" cellpadding="0" class="widget_box" <cfoutput>style="#attributes.custom_styles#"</cfoutput>>
<cfif attributes.showtitle IS 'Yes'>
<tr>
<td class="widget_title"><cfoutput>
<cfif len(trim(attributes.title_image)) GT 0>
	<img src = "#attributes.title_image#" />
<cfelse>
#attributes.widgettitle#
</cfif>
</cfoutput></td>
</tr>
</cfif>
<cfif NOT attributes.widgetfile IS 'Custom'>
<tr>
	<td class="widget_content">
    	<cfinclude template = "catalog/#attributes.widgetfile#">
	</td>
</tr>
</cfif>
<cfif attributes.widgetfile IS 'Custom'>
<cfquery name = "qryWidget" dbtype="query">
SELECT * FROM attributes.widgetquery
WHERE id = #attributes.widgetid#
</cfquery>
<tr>
	<td class="widget_content" <cfoutput>style="#attributes.custom_styles#"</cfoutput>>
    	<cfoutput query="qryWidget">#widgetcode#</cfoutput>
	</td>
</tr>
</cfif>
<tr>
	<td height="1" class="widget_footer"><img src = "images/defaults/spacer.gif" height="1" width="1" align="absmiddle" hspace="0" vspace="0" /></td>
</tr>
</table>

