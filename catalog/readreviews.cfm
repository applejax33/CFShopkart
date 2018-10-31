<cfparam name = "itemid" default="0">
<cfparam name = "start" default="0">
<cfparam name = "disp" default="5">

<cfinclude template = "../queries/qryreviews.cfm">

<cfsavecontent variable="review_pagination">

<cfset PageCount = 0>

<cfloop Index="Pages" FROM="1" TO="#qTotalReviews.totalrecords#" Step="#disp#">
<cfset PageCount = PageCount + 1>
<cfoutput><span class="pagination_page"><a href = "index.cfm?action=reviews_read&itemid=#itemid#&start=#pages#&disp=#disp#">#PageCount#</a></span></cfoutput>
</cfloop>

</cfsavecontent>

<cfset prv = start - disp>
<cfset nxt = start + disp>

<cfquery name="qryItem" datasource="#request.dsn#">
SELECT * FROM products
WHERE itemid = <cfqueryparam value="#itemid#" cfsqltype="cf_sql_integer">
</cfquery>

<cfoutput><h2>Reviews for #qryItem.productname#</h2></cfoutput>

<cfif qryReviews.recordcount IS 0>
There are no reviews posted for the selected item

<cfelse>

<cfoutput>
  <table width="100%" border="0" cellspacing="0" cellpadding="4">
    <tr>
      <td width="50%"><a href="index.cfm?action=viewdetails&itemid=#qryItem.itemid#&carttoken=#carttoken#">Back to Item</a> | <a href = "index.cfm?action=reviews_write&itemid=#itemid#">Write a review</a></td>
      <td><div align="right"><cfoutput><cfif pagecount GT 1><cfif prv GT 1> <a href = "index.cfm?action=reviews_read&itemid=#itemid#&start=#prv#&disp=#disp#">Previous</a></cfif> &nbsp;#review_pagination#&nbsp; <cfif nxt LT qTotalReviews.recordcount> <a href = "index.cfm?action=reviews_read&itemid=#itemid#&start=#nxt#&disp=#disp#">Next</a></cfif></cfif></cfoutput></div></td>
    </tr>
  </table>
  <p>&nbsp;</p></cfoutput>

<table width="100%" cellspacing="0" cellpadding="6" border="0" class="review_container">
<cfoutput query = "qryReviews">
	<tr>
    <td class="review_row">
       <table width="100%" cellpadding="4" cellspacing="0" align="left" class="review_table">
       <tr>
       <td width = "85%" class="review_title"><!---who reviewed it--->
       	<strong>REVIEWED BY:</strong> <cfif len(trim(reviewer)) GT 0>#reviewer#<cfelse>
       	Anonymous
       	</cfif> #dateformat(review_date, "mmm, dd yyyy")#
        <br />
        <table width="300" border="0" cellspacing="0" cellpadding="4">
          
          <tr>
            <td width="30%"><span style="font-weight: bold">Value</span></td>
            <td>
			<cfif value IS 5>
				  <img src = "images/ratings/stars-5-0.gif" border="0">
			</cfif>
			<cfif value IS 4>
				  <img src = "images/ratings/stars-4-0.gif" border="0">
			</cfif>
			<cfif value IS 3>
				  <img src = "images/ratings/stars-3-0.gif" border="0">
			</cfif>
			<cfif value IS 2>
				  <img src = "images/ratings/stars-2-0.gif" border="0">
			</cfif>
			<cfif value IS 1>
				  <img src = "images/ratings/stars-1-0.gif" border="0">
			</cfif>
			</td>
            </tr>
          <tr>
            <td><span style="font-weight: bold">Features</span></td>
            <td>
			<cfif features IS 5>
				  <img src = "images/ratings/stars-5-0.gif" border="0">
			</cfif>
			<cfif features IS 4>
				  <img src = "images/ratings/stars-4-0.gif" border="0">
			</cfif>
			<cfif features IS 3>
				  <img src = "images/ratings/stars-3-0.gif" border="0">
			</cfif>
			<cfif features IS 2>
				  <img src = "images/ratings/stars-2-0.gif" border="0">
			</cfif>
			<cfif features IS 1>
				  <img src = "images/ratings/stars-1-0.gif" border="0">
			</cfif>            
            </td>
            </tr>
          <tr>
            <td><span style="font-weight: bold">Quality</span></td>
            <td>
			<cfif quality IS 5>
				  <img src = "images/ratings/stars-5-0.gif" border="0">
			</cfif>
			<cfif quality IS 4>
				  <img src = "images/ratings/stars-4-0.gif" border="0">
			</cfif>
			<cfif quality IS 3>
				  <img src = "images/ratings/stars-3-0.gif" border="0">
			</cfif>
			<cfif quality IS 2>
				  <img src = "images/ratings/stars-2-0.gif" border="0">
			</cfif>
			<cfif quality IS 1>
				  <img src = "images/ratings/stars-1-0.gif" border="0">
			</cfif>                                  
            </td>
            </tr>
          <tr>
            <td><span style="font-weight: bold">Performance</span></td>
            <td>
			<cfif quality IS 5>
				  <img src = "images/ratings/stars-5-0.gif" border="0">
			</cfif>
			<cfif quality IS 4>
				  <img src = "images/ratings/stars-4-0.gif" border="0">
			</cfif>
			<cfif quality IS 3>
				  <img src = "images/ratings/stars-3-0.gif" border="0">
			</cfif>
			<cfif quality IS 2>
				  <img src = "images/ratings/stars-2-0.gif" border="0">
			</cfif>
			<cfif quality IS 1>
				  <img src = "images/ratings/stars-1-0.gif" border="0">
			</cfif>             
            </td>
            </tr>
        </table>
        <br /></td>
        <td class="review_rating">
<!---rating stars--->
<div align="center"><strong>Overall</strong></div>
<div align="center">
<cfif rating GT 4.5 AND rating LT 5.1>
  <img src = "images/ratings/stars-5-0.gif" border="0">
  </cfif>
<cfif rating GT 4.0 AND rating LT 4.6>
  <img src = "images/ratings/stars-4-5.gif" border="0">
</cfif>
<cfif rating GT 3.5 AND rating LT 4.1>
  <img src = "images/ratings/stars-4-0.gif" border="0">
  </cfif>
<cfif rating GT 3.0 AND rating LT 3.6>
  <img src = "images/ratings/stars-3-5.gif" border="0">
  </cfif>
<cfif rating GT 2.6 AND rating LT 3.1>
  <img src = "images/ratings/stars-3-0.gif" border="0">
  </cfif>
<cfif rating GT 2.0 AND rating LT 2.6>
  <img src = "images/ratings/stars-2-5.gif" border="0">
  </cfif>
<cfif rating GT 1.6 AND rating LT 2.1>
  <img src = "images/ratings/stars-2-0.gif" border="0">
  </cfif>
<cfif rating GT 1.0 AND rating LT 1.6>
  <img src = "images/ratings/stars-1-5.gif" border="0">
  </cfif>
<cfif rating GT 0.5 AND rating LT 1.1>
  <img src = "images/ratings/stars-0-5.gif" border="0">
  </cfif>
<cfif rating GT 0 AND rating LT .6>
  <img src = "images/ratings/stars-0-0.gif" border="0">
</cfif>
</div></td>
<tr>
<td colspan="2" class="review_details"><!---details--->
#details#
</td>
</tr>
</table>
 </td>
</tr>
</cfoutput>
</table>
<cfoutput>
  <table width="100%" border="0" cellspacing="0" cellpadding="4">
    <tr>
      <td width="50%"><a href = "index.cfm?action=reviews_write&itemid=#itemid#">Write a review</a></td>
      <td><div align="right"></div></td>
    </tr>
  </table>
  <p>&nbsp;</p></cfoutput>
</cfif>



