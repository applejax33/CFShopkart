<!---Displays the featured items in a vertical table--->
<cfinclude template = "../queries/qryFeatures.cfm">

<cfif NOT qryfeatures.recordcount IS 0>

<!---Pick a random featured item--->

<cfset FeaturedItemToShow = #RandRange(1, qryFeatures.recordcount)#>

       <cfoutput query = "qryFeatures" startrow="#FeaturedItemToShow#" maxrows="1"> 
            <center><a href="index.cfm?carttoken=#carttoken#&action=ViewDetails&itemid=#itemid#">
                <cfinclude template = "../queries/qryFeaturedProductimages.cfm">
                
                <cfset TheThumbnail = "#request.secureURL#photos/tiny/nopic.jpg">
                
                <cfloop query = "qry_ProductImages" startrow="1" endrow="1">
                    <cfset TheThumbnail = "#request.secureURL#photos/tiny/#qry_ProductImages.iFileName#">
                </cfloop>
                <img src="#TheThumbnail#" alt="#ProductName#" name="FeaturedItem" border="0">            
                        
            <br>#ProductName#</a><br>
			  <br />
              <a href="index.cfm?carttoken=#carttoken#&action=showfeatured">[More Featured Items]</a>
</cfoutput> 
</cfif>



