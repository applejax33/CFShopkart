<script>
function limitText(limitField, limitNum) {
    if (limitField.value.length > limitNum) {
        limitField.value = limitField.value.substring(0, limitNum);
    } 
}
</script>

<cfparam name = "ItemID" default="0">
<cfparam name = "ReviewID" default="0">

<cfinclude template = "../query/qryReview.cfm">
<cfinclude template = "../query/qryProduct.cfm">

<h3>Editing Review For #qryProduct.ProductName#</h3>

<form method="post" action="index.cfm?action=reviews_submitreview" name="submitreviewform">
<table width="300" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td><span style="font-style: italic">Rate This Item</span></td>
    <td><div align="center" style="font-weight: bold">1</div></td>
    <td><div align="center" style="font-weight: bold">2</div></td>
    <td><div align="center" style="font-weight: bold">3</div></td>
    <td><div align="center" style="font-weight: bold">4</div></td>
    <td><div align="center" style="font-weight: bold">5</div></td>
  </tr>
  <tr>
    <td><span style="font-weight: bold">Value</span></td>
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
      <input type="radio" name="value" id="radio5" value="5" checked="yes" />
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
      <input type="radio" name="Features" id="radio18" value="5" checked="yes" />
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
      <input type="radio" name="Quality" id="radio19" value="5" checked="yes" />
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
      <input type="radio" name="Performance" id="radio20" value="5" checked="yes" />
    </div></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td colspan="2"><div align="left">Low</div></td>
    <td>&nbsp;</td>
    <td colspan="2"><div align="right">
      <p>High</p>
      </div></td>
  </tr>
</table>
<p style="font-weight: bold">Add Comments Below (1,000 characters max):</p>
<p>
  <textarea name="details" id="details" cols="50" rows="8" onKeyDown="limitText(this,20);" onKeyUp="limitText(this,20);">#details#</textarea>
</p>
<p>
  <input type="submit" name="button" id="button" value="Submit Review" />
</p>
</form>







