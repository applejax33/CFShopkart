<h2>Wish List</h2>
<cfparam name = "itemid" default = "0">
<style type="text/css">
<!--
.style1 {
	font-size: 12pt;
	font-weight: bold;
}
-->
</style>

<cfif NOT isdefined('session.wishlist')>
	<cflock scope="session" type="exclusive" timeout="10">
    <cfset session.wishlist = ''>
   	</cflock>
</cfif>

	<cfif session.wishlist IS ''>
	<cfif NOT isdefined('form.CreateWishList')>
	<!---a wishlist hasn't been started for this person so tell them to create one--->
	
	<span class="style1">Create a Wishlist</span><br />
	You can create a wishlist and share it with your friends so they know what to buy you!  To create a wishlist fill out the form below and your wishlist will be saved. You will then be able to send your friends and family a link so they can see your wishlist:
	
	<p>
	<form name = "wishlistcreateform" method="post" <cfoutput>action="index.cfm?action=AddToWishList&CartToken=#CartToken#"</cfoutput>>
	<table width="400" border="0" cellspacing="0" cellpadding="4">
	  <tr>
		<td width="160">Give your  wishlist a name:</td>
		<td width="224"><input name = "wishlistname" type = "text" value = "" size="40" /></td>
	  </tr>
	  <tr>
		<td>What is your name?</td>
		<td><input name = "wishlistowner" type = "text" value = "" size="40"  /></td>
	  </tr>
	  <tr>
		<td>Create a username</td>
		<td><input type = "text" name = "wUsername" value = "" /></td>
	  </tr>
	  <tr>
		<td>Enter a Password</td>
		<td><input type = "text" name = "wPassword" value = "" /></td>
	  </tr>
	  <tr>
		<td colspan="2"><label>
		  <cfoutput><input type = "hidden" name = "itemid" value = "#itemid#" /></cfoutput>
		  <input type = "hidden" name = "CreateWishList" value ="Yes" />
		  <input type="submit" name="Submit" value="Create a wishlist" />
		</label></td>
		</tr>
	</table>
	<br />
	</form>
	</cfif>
	</cfif>
	
	<cfif isdefined('form.CreateWishList')>
	<!---Create a new wishlist if the form above was filled out --->
	<!---Create a unique wishlist id--->
	<cfif session.wishlist IS ''>
		<CFSET randomnum=RAND()*100>
		<cfset randomnum=#Round(Randomnum)#>
		<cfset TempDate = Now()>
		<cfset wishlistid = #DateFormat(TempDate, "mm")# & #DateFormat(TempDate, "dd")# & #DateFormat(TempDate, "yy")# & #TimeFormat(TempDate, "HH")# & #TimeFormat(TempDate, "mm")# & #Timeformat(TempDate, "ss")# & #randomnum#>
		
		<cfset Creationdate = #Dateformat(TempDate, "mm/dd/yyyy")#>
		
			<cfquery name = "CreateWishList" datasource="#request.dsn#">
			INSERT INTO wishlists
			(wishlistid, wishlistname, createdon, wusername, wpassword, wishlistowner)
			VALUES
			(<cfqueryparam value="#wishlistid#" cfsqltype="cf_sql_varchar">, 
            <cfqueryparam value="#form.wishlistname#" cfsqltype="cf_sql_varchar">, 
            <cfqueryparam value="#createodbcdate(Creationdate)#" cfsqltype="cf_sql_date">, 
            <cfqueryparam value="#form.wusername#" cfsqltype="cf_sql_varchar">, 
            <cfqueryparam value="#form.wpassword#" cfsqltype="cf_sql_varchar">, 
            <cfqueryparam value="#form.wishlistowner#" cfsqltype="cf_sql_varchar">)
			</cfquery>
	
		<cflock scope="session" type="exclusive" timeout="10">
			<cfset session.wishlist = #wishlistid#>
		</cflock>
	
		<cflock scope="session" type="readonly" timeout="10">
			<cfset thewishlist = session.wishlist>
		</cflock>
		
		<!---Update the shoppingcart with this wishlistid--->
		<cfquery name = "UpdateShoppingCartWithWishListID" datasource="#request.dsn#">
		UPDATE shoppingcarts SET wishlist = <cfqueryparam value="#wishlistid#" cfsqltype="cf_sql_varchar">
		WHERE CartToken = <cfqueryparam value="#CartToken#" cfsqltype="cf_sql_varchar">
		</cfquery>
		
		You have created a new wishlist.  To share your wishlist with others give them the url below:
		<p>
		<cfoutput><strong>#request.HomeURL#/index.cfm?action=viewwishlist&wishlist=#thewishlist#</strong></cfoutput>
	</cfif>
	</cfif>
	
	<!---if a wishlist was created for this session, add this item to the wishlist--->
	
	<cfif NOT session.wishlist IS ''>
	
	<cflock type="readonly" scope="session" timeout="10">
		<cfset wishlistid = #session.wishlist#>
	</cflock>
	
		<cfif NOT isdefined('form.wComments')>
			<!---they need to add some comments for this item--->
			
			<cfoutput>
			<form name = "AddToWishList" method="post" action="index.cfm?action=addtowishlist&itemid=#itemid#&CartToken=#CartToken#">
			<strong>Enter any comments about this item you want to share with other:</strong> <br />
			<textarea name = "wComments" cols="50" rows="8"></textarea>
			<input type = "hidden" name = "wishlistid" value = "#wishlistid#" />
			<input type = "submit" name="submit" value="Add the item to my wishlist" />
			</form>
			</cfoutput>
		</cfif>
	
		<cfif isdefined('form.wComments')>
			<cfquery name = "CreateWishListItem" datasource="#request.dsn#">
				INSERT INTO wishlistitems
				(wishlistid, wItemID, Comments)
				VALUES
				(<cfqueryparam value="#wishlistid#" cfsqltype="cf_sql_varchar">, 
                <cfqueryparam value="#itemid#" cfsqltype="cf_sql_varchar">, 
                <cfqueryparam value="#form.wComments#" cfsqltype="cf_sql_varchar">)
			</cfquery>
			
			<cflocation url = "index.cfm?action=viewdetails&itemid=#itemid#&CartToken=#CartToken#">
			
		</cfif>
	
	</cfif>



