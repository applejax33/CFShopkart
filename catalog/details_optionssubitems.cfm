<!---output the options for the sub items--->
<!---Diplay option form fields if there are any--->
	<cfset OptionIDs = ''>
	<cfset OptionFormNames = ''>
    <cfset OptionsHTML = ''>					
	
    	<!---build the query and sort the options by their orderid--->
		<cfinclude template = "../queries/qryitemoptions.cfm">
		
		<cfoutput query = "qryoptions"> 
		<!---build a list of field names to reference when the add to cart button is pushed--->
			<cfif Listlen(OptionFormNames) IS 0>
					<cfset OptionFormNames = "ffield#qryOptions.OptionID#">
                    <cfset OptionIDs = #qryOptions.OptionID#>
				<cfelse>
					<cfset OptionFormNames = #OptionFormNames# & "," & "ffield#qryOptions.OptionID#">
                    <cfset OptionIDs = #OptionIDs# & "," & #OptionID#>
			</cfif>

		<!---build the HTML for this option--->
            <cfif FieldType IS 'DropDown'>				
            <cfset optionsHTML = #OptionsHTML# & '<select name="ffield#OptionID#" size="#height#">'>
                    <cfloop index="LoopCount" from="1" to="#ListLen(ItemsList, "^")#">
                       <cfset op_name = #ListGetAt(ItemsList, LoopCount, "^")#>
                       <cfset op_itemid = #ListGetAt(itemidslist, LoopCount, "^")#>
                       
                       <!---lookup itemid and see if it's out of stock (if inventory is enabled).  If it's not instock and backordering is off for this item then do NOT show it in the list--->
                       <cfquery name = "qItem" datasource="#request.dsn#">
                       SELECT UnitsInStock,CanBackOrder FROM products WHERE ItemID = <cfqueryparam value="#op_itemid#" cfsqltype="cf_sql_integer">
                       </cfquery>
                       
                       <cfset showoption = 1>
                       	<cfif qItem.recordcount GT 0>
                        	<cfif request.EnableInventory IS 'Yes'>
                            	<cfif qItem.CanBackOrder IS 'No'>
                                	<cfif qItem.UnitsInStock LT 1>
                                    	<cfset showoption = 0>
                                    </cfif>
                                </cfif>
                            </cfif>
                       </cfif>
                      
                      <cfif showoption  IS 1>          	
						   <cfif fieldvalue IS #LoopCount#>
                             <cfset optionsHTML = #OptionsHTML# &'<option value="#LoopCount#" SELECTED>#op_name#</option>'>
                           </cfif>
                           <cfif NOT fieldvalue IS #LoopCount#>
                             <cfset optionsHTML = #OptionsHTML# &'<option value="#LoopCount#">#op_name#</option>'>
                           </cfif>
					  </cfif>
                    </cfloop>

                <cfset optionsHTML = #optionsHTML# & '</select>'>
                </cfif>
                
                <cfif FieldType IS 'RadioList'>
                <cfset listcount = 0>
                <cfloop index="LoopCount" from="1" to="#ListLen(ItemsList, "^")#">
                    <cfset op_name = #ListGetAt(ItemsList, LoopCount, "^")#>
                    <cfset op_itemid = #ListGetAt(itemidslist, LoopCount, "^")#>

                       <!---lookup itemid and see if it's out of stock (if inventory is enabled).  If it's not instock and backordering is off for this item then do NOT show it in the list--->
                       <cfquery name = "qItem" datasource="#request.dsn#">
                       SELECT UnitsInStock,CanBackOrder FROM products WHERE ItemID = <cfqueryparam value="#op_itemid#" cfsqltype="cf_sql_integer">
                       </cfquery>
                       
                       	<cfif qItem.recordcount GT 0>
                        	<cfif request.EnableInventory IS 'Yes'>
                            	<cfif qItem.CanBackOrder IS 'No'>
                                	<cfif qItem.UnitsInStock LT 1>
                                    	<cfset showoption = 0>
                                    </cfif>
                                </cfif>
                            </cfif>
                       </cfif>

					<cfif showoption IS 1>
                    	<cfset listcount = listcount + 1>
						<cfif fieldvalue IS #LoopCount#>
                            <cfset optionsHTML = #optionsHTML# & '<input type="radio" name="ffield#OptionID#" value="#LoopCount#" CHECKED> #op_name#<br />'>
                        </cfif>
                        <cfif NOT fieldvalue IS #LoopCount#>
                            <cfset optionsHTML = #optionsHTML# & '<input type="radio" name="ffield#OptionID#" value="#LoopCount#"> #op_name#<br />'>
                        </cfif>
					</cfif>
                </cfloop>
                </cfif>
                
                <cfif FieldType IS 'TextArea'>
                    <cfset optionsHTML = #optionsHTML# & '<textarea cols="#width#" rows="#Height#" name="ffield#OptionID#">#FieldValue#</textarea>'>
                </cfif>
                
                <cfif FieldType IS 'TextBox'>
                    <cfset optionsHTML = #optionsHTML# & '<input type = "text" name = "ffield#OptionID#" width="#Width#" value="#FieldValue#" />'>
                </cfif>
                
                <cfif FieldType IS 'CheckBox'>
                <cfset op_itemid = #qryOption.itemid#>

				   <!---lookup itemid and see if it's out of stock (if inventory is enabled).  If it's not instock and backordering is off for this item then do NOT show it in the list--->
                   <cfquery name = "qItem" datasource="#request.dsn#">
                   SELECT UnitsInStock,CanBackOrder FROM products WHERE ItemID = <cfqueryparam value="#op_itemid#" cfsqltype="cf_sql_integer">
                   </cfquery>
                   
                   <cfset showoption = 1>
                    <cfif qItem.recordcount GT 0>
                        <cfif request.EnableInventory IS 'Yes'>
                            <cfif qItem.CanBackOrder IS 'No'>
                                <cfif qItem.UnitsInStock LT 1>
                                    <cfset showoption = 0>
                                </cfif>
                            </cfif>
                        </cfif>
                   </cfif>
               
                    <cfset optionsHTML = #optionsHTML# & '<input type = "CheckBox" name = "ffield#OptionID#" value="#FieldValue#" /> #Caption#'>
                </cfif>
                
                <cfif FieldType IS 'Hidden'>
                    <cfset optionsHTML = #optionsHTML# & '<input type = "text" name = "ffield#OptionID#" value="#FieldValue#" />'>
                </cfif>		

            <cfif FieldType IS 'checkbox'>
	            <cfif showoption IS 1> <!---checkboxes can be used to track inventory so we hide it if it's out of stock (see code above and comments)--->
					<span class="options_field" style="padding-left: 10px;">#optionsHTML#</span> <span class="options_labels">#caption#</span>
				</cfif>
			<cfelse>
				<span class="options_labels" style="padding-left: 10px;">#caption#</span>&nbsp;&nbsp;<span class="options_field">#optionsHTML#</span>
            </cfif>
		</cfoutput>