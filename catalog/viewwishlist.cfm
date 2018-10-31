<style type="text/css">
<!--
.style2 {font-size: 14pt}
-->
</style>

<cfparam name = "wishlistid" default="">
<cfparam name = "wishlistname" default="">

<!---No wishlistid number was given so display a form so they can enter it or the name of the wishlist--->
<cfif wishlistid IS '' AND wishlistname IS ''>
<form name="form1" method="post" <cfoutput>action="index.cfm?action=Viewwishlist&CartToken=#CartToken#"</cfoutput>>
  <label> <span class="style2">View a wishlist </span><br>
  <br>
  Did someone tell you about their wishlist on this website?  <br>
  Enter the Wishlist ID that the person gave you or enter the name of the wishlist below in the boxes provided:<br>
  <br>
  Wishlist ID  
  <input name="wishlistid" type="text" id="wishlistid" size="45">
  <br>
  <br>
  or Wishlist Name:
  </label>
  <label>
  <input name="wishlistname" type="text" id="wishlistname" size="45">
  <br>
  <br>
  <input type="submit" name="Submit" value="Find a Wishlist">
  </label>
</form>
</cfif>

<!---if a wishlist name was given then locate the name of that wishlist in the database and display all the ones that are
	  relevant--->

<cfif NOT wishlistname IS ''>

	<cfquery name = "qryWishlistNames" datasource="#request.dsn#">
	SELECT * FROM wishlists
	WHERE Wishlistname = '#wishlistname#'
	</cfquery>
	
	<cfif NOT qryWishlistNames.recordcount IS 0>
		The following withlists were found that match the name you entered:<p>
		<cfoutput query = "qryWishlistNames">
		<a href = "index.cfm?action=viewwishlist&wishlistid=#wishlistid#&CartToken=#CartToken#">#Wishlistname#</a> - #wishlistowner#<br>
		</cfoutput>
	</cfif>
	
	<cfif NOT qryWishlistNames.recordcount IS 0>
		There were no wishlists found with that name.
	</cfif>

</cfif>

<!---If they specified a wishlistid then find it and display it--->

<cfif NOT wishlistid IS ''>

	<cfquery name = "qryWishlistids" datasource="#request.dsn#">
	SELECT * FROM wishlists
	WHERE Wishlistid = '#wishlistid#'
	</cfquery>

	<cfif qryWishlistids.recordcount IS 0>
		The ID number you entered is invalid.  The wishlist you tried to access may have been removed.
	</cfif>

	<cfif NOT qryWishlistids.recordcount IS 0>
	
		<cfoutput query = "qryWishlistids">
			<cfset WishListFound = #wishlistid#>	
		</cfoutput>

	    <cfquery name = "qryWishListItems" datasource="#request.dsn#">
		SELECT * FROM wishlistitems
		WHERE wishlistid = '#WishListFound#'
		</cfquery>
		
		<cfif qryWishListItems.recordcount IS 0>
			There are no items on this persons wishlist.
		</cfif>
		
		<cfif NOT qryWishListItems.recordcount IS 0>
			<!---Show a table of the items this person wants--->
			
			<cfoutput>This wishlist belongs to: #qryWishlistids.wishlistowner#</cfoutput>
			<p>
			<table width="100%" border = "0" align="center">
				<tr>
					<td width = "25%" class="tabletitles">Item</td>					
					<td width = "75%" class="tabletitles">Comments</td>
				</tr>

				<cfloop query = "qryWishListItems">
					<cfquery name = "FindItem" datasource="#request.dsn#">
					SELECT * FROM products
					WHERE ItemID = #wItemID#
					</cfquery>
					
                    <cfset thisitemid = wItemid>
                    
					<cfloop query = "FindItem">
					<tr>
						<td width = "25%" align="center">
						
					       <table border="0" cellpadding="3" cellspacing="0">
							  <tr> 
								<td align="center">
								<a href = "index.cfm?action=ViewDetails&ItemID=#ItemID#&CartToken=#CartToken#">
								<cfinclude template = "../queries/qryProductimages.cfm">
         
								<cfif qry_ProductImages.recordcount IS 0>
                                    <cfset TheThumbnail = "photos/tiny/nopic.jpg">
                                </cfif>
                                
                                <cfloop query = "qry_ProductImages" startrow="1" endrow="1">
                                    <cfset TheThumbnail = "photos/tiny/#qry_ProductImages.iFileName#">
                                </cfloop>
                                
                                <cfoutput>
                                <a href="index.cfm?carttoken=#carttoken#&action=ViewDetails&ItemID=#ItemID#&Category=#url.Category#"><img src="#TheThumbnail#" Alt="#ProductName#" border="0" /><br />
                                <strong>#ProductName#</strong></a><br>
                                </cfoutput>
								</td>
								</tr>
							</table>
					
						</td>					
						<td width = "75%">#qryWishListItems.Comments#</td>
					 </tr>
					 </cfloop>
				</table>
			</cfloop>	
		</cfif>
</cfif>

</cfif>






