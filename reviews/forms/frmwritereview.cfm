<cfinclude template = "../actions/actchecklogin.cfm">
<script>
function limitText(limitField, limitNum) {
    if (limitField.value.length > limitNum) {
        limitField.value = limitField.value.substring(0, limitNum);
    } 
}
</script>

<cfparam name = "ItemID" default="0">

<cfinclude template = "../queries/qryProduct.cfm">

<cfquery name = "qryReviewDuplicate" datasource="#request.dsn#">
SELECT * FROM product_reviews
WHERE itemid = '#qryProduct.itemid#' AND email = '#cookie.custemail#'
</cfquery>

<cfoutput><h2 class="review_submittitle">Writing Review For #qryProduct.ProductName#</h2></cfoutput>

<cfif qryReviewDuplicate.recordcount GT 0>
<h3 class="review_duplicatemessage">You cannot review an item more than once</h3>
Our records indicate that you have already submitted a review for this item.  <br />
If you do not see your review, it is because it was not yet approved.<br />
Thank you.
<p>
<cfelse>

<form method="post" action="index.cfm?action=reviews_submitreview" name="submitreviewform">
  <p>Name to display: 
    <input type="text" name="displayname" id="displayname" />
    </p>
  <table width="100%" border="0" cellspacing="0" cellpadding="8">
    <tr>
      <td valign="top"><table width="250" border="0" cellspacing="0" cellpadding="4">
        <tr>
          <td><span style="font-style: italic">Rate This Item</span></td>
          <td><div align="center" style="font-weight: bold">1</div></td>
          <td><div align="center" style="font-weight: bold">2</div></td>
          <td><div align="center" style="font-weight: bold">3</div></td>
          <td><div align="center" style="font-weight: bold">4</div></td>
          <td><div align="center" style="font-weight: bold">5</div></td>
        </tr>
        <tr>
          <td width="50%"><span style="font-weight: bold">Value</span></td>
          <td width="10%"><div align="center">
              <input type="radio" name="value" id="radio" value="1" />
          </div></td>
          <td width="10%"><div align="center">
              <input type="radio" name="value" id="radio2" value="2" />
          </div></td>
          <td width="10%"><div align="center">
              <input type="radio" name="value" id="radio3" value="3" />
          </div></td>
          <td width="10%"><div align="center">
              <input type="radio" name="value" id="radio4" value="4" />
          </div></td>
          <td width="10%"><div align="center">
              <input type="radio" name="value" id="radio5" value="5" checked="checked" />
          </div></td>
        </tr>
        <tr>
          <td><span style="font-weight: bold">Features</span></td>
          <td><div align="center">
              <input type="radio" name="Features" id="radio6" value="1" />
          </div></td>
          <td><div align="center">
              <input type="radio" name="Features" id="radio9" value="2" />
          </div></td>
          <td><div align="center">
              <input type="radio" name="Features" id="radio12" value="3" />
          </div></td>
          <td><div align="center">
              <input type="radio" name="Features" id="radio15" value="4" />
          </div></td>
          <td><div align="center">
              <input type="radio" name="Features" id="radio18" value="5" checked="checked" />
          </div></td>
        </tr>
        <tr>
          <td><span style="font-weight: bold">Quality</span></td>
          <td><div align="center">
              <input type="radio" name="Quality" id="radio7" value="1" />
          </div></td>
          <td><div align="center">
              <input type="radio" name="Quality" id="radio10" value="2" />
          </div></td>
          <td><div align="center">
              <input type="radio" name="Quality" id="radio13" value="3" />
          </div></td>
          <td><div align="center">
              <input type="radio" name="Quality" id="radio16" value="4" />
          </div></td>
          <td><div align="center">
              <input type="radio" name="Quality" id="radio19" value="5" checked="checked" />
          </div></td>
        </tr>
        <tr>
          <td><span style="font-weight: bold">Performance</span></td>
          <td><div align="center">
              <input type="radio" name="Performance" id="radio8" value="1" />
          </div></td>
          <td><div align="center">
              <input type="radio" name="Performance" id="radio11" value="2" />
          </div></td>
          <td><div align="center">
              <input type="radio" name="Performance" id="radio14" value="3" />
          </div></td>
          <td><div align="center">
              <input type="radio" name="Performance" id="radio17" value="4" />
          </div></td>
          <td><div align="center">
              <input type="radio" name="Performance" id="radio20" value="5" checked="checked" />
          </div></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td colspan="2"><div align="left">Worst</div></td>
          <td>&nbsp;</td>
          <td colspan="2"><div align="right">
              <p>Best</p>
          </div></td>
        </tr>
      </table></td>
      <td width="75%" valign="top"><p style="font-weight: bold">To rate this item, please rate the items attributes and then tell us what you thought about it below.</p>
        <p><span style="font-weight: bold">Value</span> - Was it worth the price? <br />
          (1=<span style="font-style: italic">Not Worth It At</span> All - 5=<span style="font-style: italic">Totally Worth It</span>!)</p>
        <p><span style="font-weight: bold">Features</span> - How are the benefits or features it has? <br />
          (1=<span style="font-style: italic">What Features!? It's horrible! -</span>  5=<span style="font-style: italic">I couldn't ask for more!</span>)</p>
        <p><span style="font-weight: bold">Quality </span>- Was it well made? Did it fall apart or is it a good solid item?<br />
          (1=<span style="font-style: italic">A Piece of Junk Would Be Better - </span> 5=<span style="font-style: italic">The Highest Quality!</span>)</p>
        <p><span style="font-weight: bold">Performance</span> - Did it perform as expected? Or did it not work as advertised?<br />
        (1=<span style="font-style: italic">I can't get it work! - </span> 5=<span style="font-style: italic">Yes, it works exactly as described!</span>)</p>
        <p>&nbsp;</p></td>
    </tr>
  </table>
  <p style="font-weight: bold">Add Comments Below (1,000 characters max):</p>
  <p>
  <textarea name="details" id="details" cols="70" rows="8" onKeyDown="limitText(this,1000);" onKeyUp="limitText(this,1000);"></textarea>
</p>
<p> 
  <cfoutput><input type = "hidden" name = "itemid" value="#qryProduct.itemid#" /></cfoutput>
  <input type="submit" name="button" id="button" value="Submit Review" />
</p>
</form>
</cfif>







