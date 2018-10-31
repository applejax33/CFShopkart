<!---shows the item pricing (this is hidden if there are sub items)--->
<cfoutput>
<cfif qrySubs.recordcount IS 0>
<cfif qrydiscounts.recordcount IS 0><!---If there are not vol discounts show the price--->
	<cfif NOT Price IS 0><!---If the price is not equal to zero show it--->
		<cfif qryProducts.showlistprice IS 'Yes'>
			<p class="pricing">
				<cfif request.EnableEuro IS 'Yes'>
				  <strong>List Price: <span class="ListPrice"></strong>#LSEuroCurrencyformat(ListPrice, "Local")#
				  <cfelse>
				  <strong>List Price: </strong><span class="ListPrice">#LSCurrencyformat(ListPrice, "Local")#</span>
				</cfif>
			<br />
		</cfif>
		<cfif qryProducts.showwsprice IS 'Yes'>
			<cfif request.EnableEuro IS 'Yes'>
              <strong>Wholesale Price: </strong><span class="WholesalePrice">#LSEuroCurrencyformat(WholesalePrice, "Local")#</span>
              <cfelse>
              <strong>Wholesale Price: </strong><span class="WholesalePrice">#LSCurrencyformat(WholesalePrice, "Local")#</span>
            </cfif>
            <br />
		</cfif>
		<cfif NOT qryproducts.showprice IS 'no'><!---If the option of showing the price is no then don't show it--->
		  <br>
		  <span class = "Price">		  
			
               <cfif request.pricinglevel GT 0>
             	<cfif request.EnableEuro IS 'Yes'>
                  <span>#LSEuroCurrencyformat(levelprice, "Local")#</span>
                      <cfelse>
                  <span>#LSCurrencyformat(levelprice, "Local")#</span>
                </cfif>
             </cfif> 
            
            <cfif request.pricinglevel IS 0>
			  <cfif SalePrice IS OriginalPrice>
                <cfif request.EnableEuro IS 'Yes'>
                  <strong>Your Price: </strong><span class="Price">#LSEuroCurrencyformat(OriginalPrice, "Local")#</span>
                  <cfelse>
                  <strong>Your Price: </strong><span class="Price">#LSCurrencyformat(OriginalPrice, "Local")#</span>
                </cfif>
              </cfif>
			  <cfif NOT SalePrice IS OriginalPrice>
                <cfif request.EnableEuro IS 'Yes'>
                  <strong>Original Price:</strong> <s><span class="OriginalPrice">#LSEuroCurrencyformat(OriginalPrice, "Local")#</span></s> 
                      <cfelse>
                  <strong>Original Price:</strong> <s><span class="OriginalPrice">#LSCurrencyformat(OriginalPrice, "Local")#</span></s>
                </cfif>
                <br>
                <cfif request.EnableEuro IS 'Yes'>
                  <strong>Sale Price:</strong> <span class="SalePrice">#LSEuroCurrencyformat(SalePrice, "Local")#</span>
                      <cfelse>
                  <strong>Sale Price:</strong> <span class="SalePrice">#LSCurrencyformat(SalePrice, "Local")#</span>
                </cfif>
             </cfif> <!---end if this person gets default pricing--->
             
             <cfif request.pricinglevel GT 0>
             	<cfif request.EnableEuro IS 'Yes'>
                  <strong>Sale Price:</strong> <span class="SalePrice">#LSEuroCurrencyformat(levelprice, "Local")#</span>
                      <cfelse>
                  <strong>Sale Price:</strong> <span class="SalePrice">#LSCurrencyformat(levelprice, "Local")#</span>
                </cfif>
             </cfif>
             
		  </cfif>		  
		 </span> 
	</cfif>
</cfif>
</cfif>
</cfif> <!---End if there are subs--->

<cfif qrySubs.recordcount GT 0>
<span class = "pricing"><strong>Price:</strong>  See below</span>
</cfif>
</cfoutput>



