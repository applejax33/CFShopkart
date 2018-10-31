<!---displays the add to cart button if it is supposed to and there aren't any sub items--->
<cfoutput>
		<cfset ShowAddToCart = 'Yes'>
		<cfif qrySubs.recordcount IS 0>
		<cfif NOT ShowQuantity IS 'No' AND NOT isgift IS 'Yes'>
        	Qty: <input type="text" name="qty" size="3" value="1" class="AddToCartButton_qty">
		<cfelse>
        	<input type = "hidden" name = "qty" value="1" />
		</cfif>
        </cfif>
		<!---itemid is used to identify the item--->
		<cfif qrySubs.recordcount IS 0><input type = "Hidden" name="ItemID" Value="#ItemID#"></cfif>
        <!---show the button--->
        <input name="AddToCart" type="image" class="AddToCartButton" title="Add To Cart" onclick="DetailsForm.submit();" src="#request.AddToCart#" alt="Add To Cart" align="absmiddle">
</cfoutput>