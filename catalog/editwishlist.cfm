<style type="text/css">
<!--
.style2 {font-size: 14pt}
-->
</style>

<cfparam name = "wishlistid" default="">

<cfif isdefined('form.wishlistid')>
	<cfquery name = 'findwishlist' datasource="#request.dsn#">
		SELECT * FROM wishlists
		WHERE wUsername = '#form.wUsername#' AND wPassword = '#form.wPassword#' AND wishlistid = '#form.wishlistid#'
	</cfquery>
	
	<cfif findwishlist.recordcount is 0>
		The wishlist id and/or username and CustPassword were not correct.  Please try again.
	</cfif>

	<cfif NOT findwishlist.recordcount is 0>
		<cflock scope="session" type="exclusive" timeout="10">
			<cfset session.wishlist = #findwishlist.wishlistid#>
		</cflock>
	</cfif>
</cfif>

<!---If there is no active wishlist then show the form--->
<cfif isdefined('url.load')>
	<form name="form1" method="post" <cfoutput>action="index.cfm?action=editwishlist&carttoken=#carttoken#"</cfoutput>>
	  <label> <span class="style2">Edit a wishlist </span><br>
	  <br>
	  You can edit a wishlist you have created on our site. All we need is the wish list id number and the username and CustPassword you created. <br>
	  <br>
	  Wishlist ID  
	  <input name="wishlistid" type="text" id="wishlistid" size="45">
	  </label>
	  <label><br>
	  <br>
	  Username:  
	  <input name="wUsername" type="text" id="wUsername" size="30">
	  <br>
	  <br>
	  CustPassword: 
	  <input name="wPassword" type="CustPassword" id="wPassword" size="30">
	  <br>
	  <br>
	  <input type="submit" name="Submit" value="Edit Your Wishlist">
	  </label>
	</form>
</cfif>

<cfif NOT isdefined('url.load')>

<cfif NOT ISDEFINED('session.wishlist')>
<cfif NOT isdefined('form.wishlistid')>

	<form name="form1" method="post" <cfoutput>action="index.cfm?action=editwishlist&carttoken=#carttoken#"</cfoutput>>
	  <label> <span class="style2">Edit a wishlist </span><br>
	  <br>
	  You can edit a wishlist you have created on our site. All we need is the wish list id number and the username and CustPassword you created. <br>
	  <br>
	  Wishlist ID  
	  <input name="wishlistid" type="text" id="wishlistid" size="45">
	  </label>
	  <label><br>
	  <br>
	  Username:  
	  <input name="wUsername" type="text" id="wUsername" size="30">
	  <br>
	  <br>
	  CustPassword: 
	  <input name="wPassword" type="CustPassword" id="wPassword" size="30">
	  <br>
	  <br>
	  <input type="submit" name="Submit" value="Edit Your Wishlist">
	  </label>
	</form>
</cfif>

</cfif>

<!---If there is an active wishlist then display it so they can edit it--->

<cfif ISDEFINED('session.wishlist')>

	<cflock scope="session" type="readonly" timeout="10">
		<cfset wishlistid = #session.wishlist#>
	</cflock>

	<cfquery name = "qryWishlistids" datasource="#request.dsn#">
	SELECT * FROM wishlists
	WHERE Wishlistid = '#wishlistid#'
	</cfquery>

	<cfif qryWishlistids.recordcount IS 0>
		The ID number of the wishlist is invalid.  The owner of the website may have removed it.  You will need to create a new one.
	</cfif>

	<cfif NOT qryWishlistids.recordcount IS 0>
	
		<cfoutput query = "qryWishlistids">
			<cfset WishListFound = #wishlistid#>	
<cfif isdefined('form.wishlistid')>
	<cfquery name = 'findwishlist' datasource="#request.dsn#">
		SELECT * FROM wishlists
		WHERE wUsername = '#form.wUsername#' AND wPassword = '#form.wPassword#' AND wishlistid = '#form.wishlistid#'
	</cfquery>
	
	<cfif findwishlist.recordcount is 0>
		The wishlist id and/or username and CustPassword were not correct.  Please try again.
	</cfif>

	<cfif NOT findwishlist.recordcount is 0>
		<cflock scope="session" type="exclusive" timeout="10">
			<cfset session.wishlist = #findwishlist.wishlistid#>
		</cflock>
	</cfif>
</cfif>
		</cfoutput>
		
	    <cfquery name = "qryWishListItems" datasource="#request.dsn#">
		SELECT * FROM wishlistitems
		WHERE wishlistid = '#wishlistid#'
		</cfquery>
		
		<cfif qryWishListItems.recordcount IS 0>
			There are no items on your wishlist.  Add items from the catalog.
		</cfif>
		
		<cfif NOT qryWishListItems.recordcount IS 0>
			<!---Show a table of the items this person wants--->
			
			<h2>Your wishlist</h2>
			<p>
			<table width="100%" border = "0" align="center" cellpadding="8" cellspacing="0">
				<tr>
					<td width = "25%" class="TableTitles"><strong>Item</strong></td>	
                    <td width = "25%" class="TableTitles"></td>				
					<td width = "40%" class="TableTitles"><strong>Comments</strong></td>
					<td width = "10%" class="TableTitles"></td>
					
				</tr>

				<cfloop query = "qryWishListItems">
					<cfquery name = "FindItem" datasource="#request.dsn#">
					SELECT * FROM products
					WHERE ItemID = #wItemID#
					</cfquery>
				
					<cfoutput query = "FindItem">
					<tr>
						<td align="left">
						
					       <table border="0" cellpadding="3" cellspacing="0">
							  <tr> 
								<td align="left">
								  <div align="left"><a href = "index.cfm?action=ViewDetails&ItemID=#ItemID#&CartToken=#CartToken#">
							      <img src="#request.HomeURL#/photos/tiny/#Thumbnail#" Alt="#ProductName#" border="0"><br />
							      </a><b><br>
						          </div></td>
							 </tr>
							</table>
					
						</td>
                        <td><b>#ProductName#</b></td>					
						<td>#qryWishListItems.Comments#</td>
						<td><a href = "index.cfm?action=DeleteFromWishList&id=#qryWishListItems.id#&CartToken=#CartToken#">Delete</a></td>
					 </tr>
					 </cfoutput>
				</table>
			</cfloop>	
		</cfif>
</cfif>

</cfif>
</cfif>





