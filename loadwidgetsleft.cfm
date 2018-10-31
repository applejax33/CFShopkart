<cfoutput query = "qryWidgetsLeft">
	<cfif isvisible NEQ 'No'>
		<cfif widgetname IS "OrderCheck">
			<a name="orderchecker"></a>
		</cfif>
		<cfif widgetname IS "GiftCards">
			<a name="giftcardchecker"></a>
		</cfif>	
		<cfif widgetname IS "Wish List">
			<cfif isvisible IS 'Yes'>
				<cfset wishliston = 'Yes'>
			</cfif>
		</cfif>								
		<cf_widgetbox widgettitle = "#widgettitle#" 
		widgetfile="#widgetfile#"
        showtitle="#showtitle#"
        title_image = "#title_image#"
		dsn="#request.dsn#"
		carttoken="#carttoken#"
        widgetquery="#qryWidgetsLeft#"
        widgetid="#id#"
        custom_styles="#custom_styles#">
	</cfif>
	<p>
</cfoutput>



