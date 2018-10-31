<!---This file builds the category tree in the left nav menu--->

	<!--- Define required parameters --->
	<cfparam name="Attributes.CartToken" type="string" default="0">
	<cfparam name="Attributes.PathView" type="string" default="/">
	<cfparam name="Attributes.ShowBullet" type="string" default="No">
	<cfparam name="Attributes.BulletStyle" type="string" default="&middot;">
	<cfparam name="Attributes.ShowMoreArrow" type="string" default="Yes">
	<cfparam name="Attributes.MoreArrowStyle" type="string" default="&raquo;">
 	<cfparam name="Attributes.Directory" type="string" default="/">
	<cfparam name="Attributes.Datasource" type="string" default="">
	<cfparam name="Attributes.StoreUser" type="string" default="">
	<cfparam name="Attributes.SelectedItem" type="string" default="">
    <!---set to 1 to show empty categories set to 0 to hide them--->	
	<cfparam name="Attributes.ShowEmpty" type="string" default="1">	
    	
	<!--- Define internal tag processing parameters --->
	<cfparam name="Attributes.ParentDirectory" type="string" default="NoParentDirectory">
	<cfparam name="Attributes.TagRecursiveCount" type="numeric" default="0">
	<cfparam name="Attributes.DirectoryToTreeInitialized" type="boolean" default="No">
	<cfparam name="Attributes.ShowCurrentView" default="No">
	<cfparam name="Attributes.FirstIndent" default="5">
	
	<!--- Execute a query to find the currently passed path--->
	<cfquery name = "qCurrentDirectoryWithoutDotParents" Datasource="#attributes.Datasource#">
	SELECT * FROM categories
	WHERE CategoryPath = '#attributes.Directory#'
	ORDER BY OrderValue ASC
	</cfquery>

	<cfif qCurrentDirectoryWithoutDotParents.recordcount IS 0>
	</cfif>
		 
<!--- Build the directory tree --->
	<cfoutput>
	<cfif Attributes.DirectoryToTreeInitialized></cfif>
			
			<!--- Loop through the directory query to create the drop down box--->
			<cfloop query="qCurrentDirectoryWithoutDotParents">
			<!--- Determine current and parent directories --->
						<cfscript>
							NextDirectory = Attributes.Directory & qCurrentDirectoryWithoutDotParents.CategoryID & "/";
							NextParentDirectory = Attributes.ParentDirectory & qCurrentDirectoryWithoutDotParents.CategoryID;
						</cfscript>
					
					<!---Find out how many '/' characters are in this path.  <br>
						 This will determine the number	of Spaces to use for the indent--->
					
					<CFSET str = "#Attributes.Directory#">
											
					<CFSET key = "/">
					<CFSET keyCnt = 0>
					<CFSET findIdx = -1>
					<CFSET startFind = 1>
	
				   <CFLOOP condition="findIdx NEQ 0">
						   <CFSET findIdx = FindNoCase(key, str, startFind)>
							  <CFIF findIdx GT 0>
						   <CFSET keyCnt = keyCnt + 1>
						   <CFSET startFind = findIdx + 1> 
						  </CFIF> 
				  </CFLOOP>

						<!---Now create a variable to generate the number of spaces for the indent)
						 For main categories this will be a negative -1 so that they are not <br>
						indented --->
						<cfset NumberOfSpaces = #keyCnt# - 2>
								
						   <!--- Now build the element and recurse --->
						   <!---Get the Category ID from the category List--->
							<cfset DirID = #qCurrentDirectoryWithoutDotParents.CategoryID#>

							<cfquery name = "Qrycategories" datasource='#Attributes.Datasource#'>
							SELECT *
							FROM categories
							WHERE CategoryID = #DirID#
							</cfquery>
							
                            	<!---get item count--->
                                <!---
                                <cfquery name = "qCount" datasource="#request.dsn#">
                                SELECT count(*) AS totalrecords FROM product_categories JOIN products ON products.itemid = product_categories.itemid
                                WHERE product_categories.categoryid = <cfqueryparam value="#DiriD#" cfsqltype="cf_sql_integer">
                                AND products.isoption = <cfqueryparam value="0" cfsqltype="cf_sql_integer">
                                <cfif request.ShowOutOfStockItems NEQ 'Yes'>
                                    AND products.UnitsInStock > <cfqueryparam value="0" cfsqltype="cf_sql_integer">
                                </cfif>
                                </cfquery>
								--->
                                <cfquery name = "qSubs" datasource="#request.dsn#">
                                SELECT count(*) as totalrecords FROM categories WHERE subcategoryof = '#DirID#'
                                </cfquery>
                            								
								<cfset ThisSubCategoryOf = '#Qrycategories.SubCategoryOf#'>
									<!---Now create the item in the list and loop over the spaces <br>
									(&nbsp;) to determine the amount of indent for this category.--->
									
									<!---Display it only if it's a main cateogry and it's part of the current
										tree of the category being viewed--->
								    <cfif attributes.pathview CONTAINS '#Qrycategories.CategoryPath#' OR Qrycategories.CategoryPath IS '/'>

										<!---show only if it has subcategories and/or items--->
                                        <cfif qSubs.totalrecords GT 0 OR attributes.showempty IS 1>
                                        
										<cfif Qrycategories.CategoryPath IS '/'>
											<div class="categorylinkrow"><cfloop From="0" To="#NumberOfSpaces#" Index="MyCount">&nbsp;&nbsp;</cfloop>
											<cfif attributes.ShowBullet IS 'Yes'>#Attributes.BulletStyle#</cfif>&nbsp;
                                            <cfif request.use_urlrewrite IS 'Yes'>
                                            <a class="categorylinks" href = "#urlrw#">#qrycategories.CategoryName# <cfif qCount.totalrecords GT 0>(#qCount.totalrecords#)</cfif></a>
										<cfelse>
                                            <a class="categorylinks" href = "index.cfm?Action=ViewCategory&Category=#CategoryID#&CartToken=#Attributes.CartToken#">#qrycategories.CategoryName# <!---<cfif qCount.totalrecords GT 0>(#qCount.totalrecords#)</cfif>---></a>
                                        </cfif>
											<cfif attributes.ShowMoreArrow IS 'Yes' AND qSubs.totalrecords GT 0>
												<font size="1">#Attributes.MoreArrowStyle#</font>
											</cfif>
											</div>
										</cfif>
										
										</cfif>                                        

										<cfif NOT Qrycategories.CategoryPath IS '/'>
											<div class="categorylinkrow"><cfloop From="0" To="#NumberOfSpaces#" Index="MyCount">&nbsp;&nbsp;</cfloop>
											<cfif attributes.ShowBullet IS 'Yes'>#Attributes.BulletStyle#</cfif>&nbsp;<a class="categorylinks" href = "index.cfm?Action=ViewCategory&Category=#CategoryID#&CartToken=#Attributes.CartToken#">#qrycategories.CategoryName#</a>
	
											<cfquery name = "CheckForSubs" datasource='#Attributes.Datasource#'>
											SELECT *
											FROM categories
											WHERE SubCategoryOf = '#CategoryID#'
											</cfquery>
	
											<cfif attributes.ShowMoreArrow IS 'Yes' AND CheckForSubs.RecordCount GT 0>
												<font size="1">#Attributes.MoreArrowStyle#</font>
											</cfif>
											</div>
										</cfif>
										
									</cfif> 
									
									<cfmodule Template="maincategorytree.cfm"
										Directory="#NextDirectory#"
										ParentDirectory="#NextParentDirectory#"
										TagRecursiveCount="#IncrementValue(Attributes.TagRecursiveCount)#"
										ShowCurrentView="#Attributes.ShowCurrentView#"
										ShowBullet="#Attributes.ShowBullet#"										
										BulletStyle="#Attributes.BulletStyle#"
										ShowMoreArrow="#Attributes.ShowMoreArrow#"
										MoreArrowStyle="#Attributes.MoreArrowStyle#"
										PathView="#attributes.pathview#"
										SelectedITem="#Attributes.SelectedItem#"
										Datasource="#attributes.datasource#"
										FirstIndent="#Attributes.FirstIndent#"
										StoreUser="#Attributes.StoreUser#"
										CartToken="#Attributes.CartToken#"
                                        ShowEmpty="#Attributes.ShowEmpty#"
										DirectoryToTreeInitialized="Yes">							
				</cfloop>
	</cfoutput>



