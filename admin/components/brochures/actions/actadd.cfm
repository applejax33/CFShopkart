<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<!---UPloads the images, creates the smaller images for flipping; the image they upload is the zoomable one...then creates the directory (if it doesn't already exist) and copies the default files over then generates the xml file--->

<h2>Create Brochure</h2>
<cfif len(trim(form.brochurename)) IS 0>
	Error: You did not give your brochure a name.<cfabort>
</cfif>

<!---create the new folder for this brochure--->
<cfif NOT DirectoryExists('#request.CatalogPath##request.bslash#brochures#request.bslash##form.brochurename#')>
	<cfdirectory action="create"
		directory = "#request.CatalogPath##request.bslash#brochures#request.bslash##form.brochurename#" mode="777">
</cfif>

<!---Copy the master files over to this new directory--->
<cffile action="copy" source="#request.CatalogPath#brochures#request.bslash#master#request.bslash#brochure.swf" destination="#request.CatalogPath##request.bslash#brochures#request.bslash##form.brochurename##request.bslash#brochure.swf" nameconflict="overwrite" mode="777">

<cffile action="copy" source="#request.CatalogPath#brochures#request.bslash#master#request.bslash#brochure.html" destination="#request.CatalogPath##request.bslash#brochures#request.bslash##form.brochurename##request.bslash#brochure.html" nameconflict="overwrite" mode="777">

<!---Upload each of the images--->
<cfset imageslistBIG = ''>
<cfset imageslistSMALL = ''>

<cfloop from = "1" to = "10" index="iCount">
	<cfset thisform = "page#icount#">

	<cfif NOT evaluate(thisform) IS ''>
		<CFFILE	Action="Upload"
		FileField = "form.page#iCount#"
		Destination = "#request.CatalogPath##request.bslash#brochures#request.bslash##form.brochurename##request.bslash#"
		NameConflict = "overwrite"
		Accept = "image/gif, image/pjpeg, image/jpg, image/jpeg, application/x-shockwave-flash, image/png"
        mode="777">
		
		<cfset BigImage = "#cffile.ServerFile#">
		<cfset SmallImage = "SM#cffile.ServerFile#">			

		<!---Resize the above image to 300 wide and make the resized image prefixed with SM--->
		
		<cfif NOT right(BigImage, 4) IS '.swf'>
			<cfset NewWidth = 300>
			<cfset inFile = BigImage>
            <cfset outFile = SmallImage>
            
            <cfinclude template = "actresize.cfm">
		
			<cfset imageslistBIG = listappend(imageslistBIG, BigImage)>
			<cfset imageslistSMALL = listappend(imageslistSmall, SmallImage)>		

			<!---If this is the first image then use it to create the preview image--->
			<cfif listlen(imageslistBIG) IS 1>
				<cfset NewWidth = 120>
 				<cfset inFile = BigImage>
            	<cfset outFile = 'brochure.jpg'>
                           		
                <cfinclude template = "actResize.cfm">
			</cfif>
		</cfif>

		<cfif right(BigImage, 4) IS '.swf'>
			<cfset imageslistBIG = listappend(imageslistBIG, BigImage)>
			<cfset imageslistSMALL = listappend(imageslistSmall, SmallImage)>
		</cfif>			
	</cfif>
</cfloop>

<!---build the xml file--->

<cfxml variable="MyBrochure">
<PageflipDataSet>
	<Settings PageWidth="400" PageHeight="400"
			  AutoSize="false"
			  StartPage="1"
			  Hardcover="false"
			  LargeCover="true"
			  HcoverAngle="-30" 
			  ClickArea="64" AutoFlipArea="56"
			  GotoPageSpeed="2" MousePursuitSpeed="5" OnReleaseSpeed="3"
			  FlippingEnabled="true"
			  TransparencyEnabled="true"
			  TearDistance="80"
		  
			  PDFlink=""
			  BackgroundColour="0x000000"
			   
			  ZoomAreaWidth="760"
			  ZoomAreaHeight="480"
			  ZoomFollowSpeed="5"
			  
			  ThumbnailsEnabled="true"
			  ThumbnailsOnEachSide="false"			
			  ThumbnailsOnFacingPages="true"
			  ThumbnailMargin="0"
			  ThumbnailPadding="20"
			  ThumbnailBorderWidth="0"
			  ThumbnailBorderColor="0x000000"
			  ThumbnailBorderHoverColor="0x000000"			  
			  
			  MouseHandler="true"
			  FlipBeforeLoaded="false"
			  MinPagesBeforeFlip="3">
			  
			  <Sounds Enabled="false"
			  		  Start="pf1.mp3"
					  End="pf2.mp3"
					  TearOff="pf3.mp3" />
					  
	</Settings>
	<PageOrder>
		<cfloop from = "1" to = "#listlen(imageslistBig)#" index="imgCount">
			<cfset ThisBigImage = listgetat(imageslistBIG, imgcount)>
			<cfset ThisSmallImage = listgetat(imageslistSMALL, imgCount)>
				<cfoutput><PageData PageFile="#ThisSmallImage#" LargeFile="#ThisBigImage#" TearOff="false"/></cfoutput>
         </cfloop>
	</PageOrder>
</PageflipDataSet>
</cfxml>

<!---Write the xmlfile--->
<cffile action="write" file="#request.CatalogPath##request.bslash#brochures#request.bslash##form.brochurename##request.bslash#brochure.xml" output="#myBrochure#" mode="777">

<!---delete the brochure from the database with the same name (if there is one)--->
<cfquery name = "qryDeleteDuplicate" datasource="#request.dsn#">
DELETE FROM brochures WHERE name = '#form.brochurename#'
</cfquery>

<!---brochure's created here will be assigned to itemid 0, in that they are not assigned to any item in the catalog--->
<cfquery name = "InsertBrochure" datasource = "#request.dsn#">
INSERT INTO brochures
(name, itemid)
VALUES
('#form.brochurename#', '0')
</cfquery>

Your brochure has been successfully generated.  <a href = "index.cfm">Click here to continue</a>.