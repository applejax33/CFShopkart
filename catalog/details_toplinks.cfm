<!---displays the email item, print item, and add to wishlist links--->
<cfif qryWishListCheck.isvisible IS 'Yes'>
	<cfset wishliston = 'Yes'>
</cfif>
<cfif ISDEFINED('url.emailsent')><font color="##FF0000">Item was emailed!</font></cfif>
	  <a href="##" onclick="printme('details');"><img src="images/defaults/printer.gif" border="0" align="absmiddle" />Print Item</a>&nbsp;
  	  <cfoutput><a href="index.cfm?carttoken=#carttoken#&action=EmailItem&itemid=#itemid#"><img src="images/defaults/email.gif" border="0" align="absmiddle" /> Email Item</a>&nbsp; 
      <a href="http://digg.com/submit?phase=2&url=#request.homeurl#index.cfm?action=viewdetails&itemid=#itemid#" target="_blank"><img src="images/defaults/digg.gif" border="0" align="absmiddle" /> Digg it</a>&nbsp;
	  <cfif request.enablewishlists IS 'Yes'>
      <a href="index.cfm?carttoken=#carttoken#&action=addtowishlist&amp;itemid=#itemid#"><img src="images/defaults/wishlist.gif" border="0" align="absmiddle" /> Add to Wishlist</a>&nbsp;
	  </cfif>
  	  </cfoutput>



