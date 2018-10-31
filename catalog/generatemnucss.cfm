<!---Generates the CSS for this particular menu--->
		<cfoutput query = "qryNavStyle">       
		<cfset padval = replacenocase(cellheight, "px", "", "ALL")>
		<cfset padval = padval / 3>

		<style>

			.yuimenubaritem a.disabled {
			text-decoration: none;
			color: #mfontcolor#;}
			
			.yuimenubar {
			color: #mfontcolor#;
			border:solid 0px ##cccccc;
			background-image: url(#tileimage#);
			background-color: #mBackgroundColor#;}
			
			.bd {
			color: #mfontcolor#;
			background-position: bottom;
			border: 0px solid ##666666;		
			}

			.yuimenu {
			color: #mfontcolor#;
			background-color: #mBackgroundColor#;
			<cfif len(tileImage) GT 0>
			background-image: url();</cfif>		
			}
			
			<cfset decTrans = #mnuTransparency# / 100>
			
			.yuimenu {filter:alpha(opacity=#mnuTransparency#);
			-moz-opacity:#decTrans#;
			-khtml-opacity: #decTrans#;
			opacity: #decTrans#;}			

			.yuimenu ul{
			margin:0;
			border: 0px ##000000 solid;}

		.yuimenubaritem {
			font-size: #mfontsize#;
			color: #mfontcolor#;
			font-family: #mfontfamily#;
			font-weight: #mfontweight#;
			text-align: #textalignment#;
			cursor:pointer;
			text-decoration: none;
			}

			.yuimenubaritem a{
			font-size: #mfontsize#;
			color: #mfontcolor#;
			font-family: #mfontfamily#;
			font-weight: #mfontweight#;
			text-align: #textalignment#;
			cursor:pointer;
			text-decoration: none;
			padding-top: #padval#px;
			padding-bottom: #padval#px;
			}

			.yuimenuitem a{
			font-size: #mfontsize#;
			color: #mfontcolor#;
			font-family: #mfontfamily#;
			font-weight: #mfontweight#;
			text-align: left;
			cursor:pointer;
			text-decoration: none;
			}
	
			.yuimenubaritem a.selected {
			background-color: #mHoverBackgroundColor#;
			background-image: url(#tileimagehover#);
			font-size: #mfonthoversize#;
			font-family: #mfontfamily#;
			font-weight: #mfontweight#;
			text-align: #textalignment#;
			cursor:pointer;
			text-decoration: none;
			color: #mfonthovercolor#;
			}

			.yuimenuitem a.selected{
			background-color: #mHoverBackgroundColor#;
			background-image: url();
			font-size: #mfonthoversize#;
			color: #mfonthovercolor#;
			font-family: #mfontfamily#;
			font-weight: #mfontweight#;
			text-align: left;
			cursor:pointer;
			text-decoration: none;
			}
			
			.yuimenuitemlabel {
			font-size: #mfontsize#;
			color: #mfontcolor#;
			font-family: #mfontfamily#;
			font-weight: #mfontweight#;
			text-align: left;
			cursor:pointer;
			text-decoration: none;}			

			.yuimenuitemlabel a{
			font-size: #mfontsize#;
			color: #mfontcolor#;
			font-family: #mfontfamily#;
			font-weight: #mfontweight#;
			text-align: left;
			cursor:pointer;
			text-decoration: none;			
			}

			.yuimenuitemlabel a.selected{
			font-size: #mfonthoversize#;
			color: #mfonthovercolor#;
			text-decoration: none;
			}

			.yuimenubaritemlabel .submenuindicator {
				
				display:none;
				color: #mfonthovercolor#;
				height:0px;
				width:0px;
				overflow:hidden;
				vertical-align:middle;
				text-indent:0px;
				background-image:url();
				background-repeat:no-repeat;			
			}
			
			.yuimenubaritemlabel .submenuindicator {
			
				display:none; /* Gecko */
				display:none; /* IE, Opera and Safari */
				font:0/0 arial; /* Gecko */
			
			}
			.first-of-type {border: 0px solid ##000000;}
				
		</style>		
		</cfoutput>




