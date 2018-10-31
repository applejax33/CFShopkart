<!---Generates the CSS for this particular menu--->
<cfoutput query = "qryNavStyle">
<cfsavecontent variable="mychildstyles">
			background-color: #mBackgroundColor#;
			font-size: #mfontsize#;
			color: #mfontcolor#;
			font-family: #mfontfamily#;
			font-weight: #mfontweight#;
			text-align: left;
			cursor:pointer;
			text-decoration: none;	
</cfsavecontent>
</cfoutput>



