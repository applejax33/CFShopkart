<cfif request.EnableInventory IS 'Yes'>
	<cfloop index="IndexCount" from="1" To="#ListLen(Cart.CrtProductID, "^")#">
		<cfset ProdID = #ListGetAt(Cart.CrtItemID, IndexCount, "^")#>
		<cfset ProdName = #ListGetAt(Cart.CrtProductName, IndexCount, "^")#>
		<cfset ProdQty = #ListGetAt(Cart.CrtQuantity, IndexCount, "^")#>

		<cfquery name = "FindProduct" datasource="#request.dsn#">
		SELECT *
		FROM products
		WHERE ItemID = #ProdID#
		</cfquery>

		<cfoutput query = "FindProduct">
			<cfset NewUnitsInStock = #UnitsInStock# - #ProdQty#>
		</cfoutput>

		<cfif NOT #FindProduct.RecordCount# IS 0>
			<cfif isdefined('NewUnitsInStock')>
				<cfquery name = "UpdateStock" datasource="#request.dsn#">
				UPDATE products
				SET UnitsInStock = '#NewUnitsInStock#'
				WHERE ItemID = #ProdID#
				</cfquery>
			</cfif>
		</cfif>

		<!---lower stock levels of each option ordered (for options that have inventory tracked)--->
        <cfset OptionCheckID = ListGetAt(cart.crtOptionFields, IndexCount, "^")>
                                
        <cfloop from="1" to="#listlen(OptionCheckID, '|')#" index="op_count">
            <cfif listlen(OptionCheckID, "|") GT 1>
                <cfset this_field = listgetat(OptionCheckID, 2, "|")>
                    <cfset op_id = listgetat(this_field, 1, "-")>
                    <cfset op_value = listgetat(this_field, 2, "-")>
                    <cfset op_itemid = 0>
                    
                    <!---look up itemid for this option--->
                        <cfquery name = "qOption" datasource="#request.dsn#">
                        SELECT * FROM options WHERE optionid = #op_id#
                        </cfquery>
                        
                        <cfif qOption.FieldType IS 'RadioList' OR qOption.FieldType IS 'DropDown'>
                            <cfset op_itemid = listgetat(qOption.itemidslist, op_value, '^')>
                        <cfelse>
                            <cfset op_itemid = qOption.itemid>
                        </cfif>
            
                        <cfif NOT op_itemid IS 0>
        
                            <cfquery name = "FindProduct" datasource="#request.dsn#">
                            SELECT UnitsInStock FROM products
                            WHERE itemid = #op_itemid#
                            </cfquery>
                            
                            <cfif FindProduct.recordcount GT 0> <!---skips if itemid is invalid--->
                           	
                            <!---reduce this by the qty in stock--->
							<cfoutput query = "FindProduct">
								<cfset NewUnitsInStock = #FindProduct.UnitsInStock# - #ProdQty#>
							</cfoutput>
 							
                                <cfquery name = "UpdateStock" datasource="#request.dsn#">
                                UPDATE products
                                SET UnitsInStock = '#NewUnitsInStock#'
                                WHERE ItemID = #op_itemid#
                                </cfquery>                           	
							                            
                            </cfif><!---end if recordcount for findproducts is 0--->
                        </cfif><!---end if the itemid is 0--->
                </cfif>
          </cfloop> <!---end loop over options--->

	</cfloop>

</cfif>
<!---note:  In the above both an option item and a regular item that an option is assigned to get their inventory reduced.  That way when the regular item runs out of stock (no options are available) the out of stock
message will appear or the item will be hidden in the catalog depending on settings--->