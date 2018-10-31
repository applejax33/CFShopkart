<style type="text/css">
<!--
.style1 {
	color: #FF0000
}
.style3 {
	color: #000066
}
-->
</style>
<cfif NOT qryCatalog.RecordCount IS 0>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="4" style="border-collapse: collapse" bordercolor="#111111">
        <cfset SearchCount = 0>
        <cfloop query = "qryCatalog" startrow="#start#" endrow="#end#">
          <cfinclude template = "../queries/qryreviews.cfm">
          <cfquery name = "ProductQuery" datasource="#request.dsn#">
	SELECT * FROM products WHERE itemid = <cfqueryparam value="#qryCatalog.Itemid#" cfsqltype="cf_sql_integer">
	</cfquery>
          <cfset mycount = 0>
          <cfloop query="ProductQuery">
            <cfif request.use_urlrewrite IS 'Yes'>
              <cfset prod_link = "#request.absolutepath##urlrw#">
              <cfelse>
              <cfset prod_link = "index.cfm?carttoken=#carttoken#&action=ViewDetails&ItemID=#ItemID#&category=#url.category#&viewby=#viewby#&sortorder=#sortorder#">
            </cfif>
            <!---for pricing levels--->
            <cfif request.pricinglevel GT 0>
              <cfset levelprice = ProductQuery.price>
              <cfquery name = "qPrice" datasource="#request.dsn#">
        SELECT * FROM products_pricing
        WHERE itemid = '#ProductQuery.itemid#'
        AND level = #request.pricinglevel#
        </cfquery>
              <cfoutput query = "qPrice">
                <cfset levelprice = qPrice.price>
              </cfoutput>
            </cfif>
            <cfoutput>
              <cfset SearchCount = SearchCount + 1>
              <cfset mycount = mycount + 1>
              <tr>
                <td width="100" valign="top" class="productrow"><cfset thisitemid = productquery.itemid>
                  <cfinclude template = "../queries/qryProductimages.cfm">
                  <cfif qry_ProductImages.recordcount IS 0>
                    <cfset TheThumbnail = "photos/small/nopic.jpg">
                  </cfif>
                  <cfloop query = "qry_ProductImages" startrow="1" endrow="1">
                    <cfset TheThumbnail = "photos/small/#qry_ProductImages.iFileName#">
                  </cfloop>
                  <a href="#prod_link#"><img src="#TheThumbnail#" Alt="#ProductName#" border="0" <cfif qry_ProductImages.tinywidth GT 75>width="75"</cfif> /></a> </td>
                <!---CHECK FOR A SALE--->
                <cfset OriginalPrice = '#Price#'>
                <cfif request.pricinglevel GT 0>
                  <cfset OriginalPrice = levelprice>
                </cfif>
                <cfset TheItemID = '#ItemID#'>
                <cfset TheCategoryID = '#Category#'>
                <cfset SalePrice = OriginalPrice>
                <cfset TodaysDate = #Now()#>
                <cfset TodaysDate = dateformat(TodaysDate, "mm/dd/yyyy")>
                <cfif NOT ProductQuery.isgift IS 'Yes'>
                  <cfinclude template = "../cart/crtCheckForSale.cfm">
                </cfif>
                <!---END CHECK FOR A SALE--->
                <td valign="top" class="productrow" style="cursor:pointer;" onclick="top.location.href = '#prod_link#';"><div class="product_name" style="font-weight: bold; font-size: 14px; padding-top: 6px; padding-bottom: 6px;"><a href = "#prod_link#" class="product_name">#ProductName#</a></div>
                  <div style="float: right;" class="rating_list">
                    <cfif NOT request.showproductreviews IS 'No'>
                      <cfinclude template = "showrating.cfm">
                    </cfif>
                  </div>
                  <div class="briefdesc">
                    <cfif request.ShowItemAvailability IS 'Yes'>
                      <!---if inventory is enabled then show that it's out of stock if it is--->
                      <span class="availability">
                      <cfif request.EnableInventory IS 'Yes'>
                        <cfif UnitsInStock LT 1>
                          <span class="style1">Out of Stock</span>
                          <cfelse>
                          <span class="style3">#availability#</span>
                        </cfif>
                        <cfelse>
                        <span class="style3">#availability#</span>
                      </cfif>
                      </span>
                    </cfif>
                    <cfif len(brand) GT 1>
                      Manufacturer: #brand#
                    </cfif>
                    #BriefDescription#</div>
                  <div class="featured_pricing" style="height: 18px; background: url(/images/price_bg.png); 
    background-repeat: no-repeat; background-position: center; padding: 1px;">
                    <div class="sku">
                      <cfif NOT request.ShowProductID IS 'No'>
                        Sku: #sku#
                      </cfif>
                    </div>
                    <div class="price_listing">
                      <cfif NOT OriginalPrice IS 0>
                        <cfif SalePrice IS OriginalPrice>
                          <cfif request.EnableEuro IS 'Yes'>
                            #LSEuroCurrencyformat(OriginalPrice, "Local")#
                            <cfelse>
                            #LSCurrencyformat(OriginalPrice, "Local")#
                          </cfif>
                        </cfif>
                        <cfif NOT SalePrice IS OriginalPrice>
                          SALE PRICE <font color="##009900">
                          <cfif request.EnableEuro IS 'Yes'>
                            #LSEuroCurrencyformat(SalePrice, "Local")#
                            <cfelse>
                            #LSCurrencyformat(SalePrice, "Local")#
                          </cfif>
                          </font>
                        </cfif>
                        <!---NOT OriginalPrice IS 0 then show this--->
                      </cfif>
                      <cfif OriginalPrice IS 0>
                      </cfif>
                      <!---End if OriginalPrice IS 0--->
                    </div>
                  </div></td>
              </tr>
            </cfoutput>
          </cfloop>
        </cfloop>
      </table>
</cfif>
