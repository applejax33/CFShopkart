<cfset therating = form.value + form.features + form.quality + form.performance>
<cfset therating = therating / 4>
<cfset reviewdate = now()>

<cfquery name = "qryInsertReview" datasource="#request.dsn#">
INSERT INTO product_reviews
(itemid, reviewer, value, features, quality, performance, details, rating, approved, review_date, email)
VALUES
('#form.itemid#', '#form.displayname#', #form.value#, #form.features#, #form.quality#, #form.performance#, '#form.details#', #therating#, 'No', #createodbcdate(reviewdate)#, '#cookie.custemail#')
</cfquery>

<h2>Thank you!</h2>
We have received your product review.  It will be posted to our website as soon as we approve of it.  We appreciate you taking the time to tell us what you think.
<p>
<cfoutput><a href = "index.cfm?action=viewdetails&itemid=#form.itemid#&carttoken=#carttoken#">Go back to item</a></cfoutput>








