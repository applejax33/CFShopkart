<!---called from crtCreateToken, inserts into stats log that a cart was created--->
<cfparam name = "carttoken" default="">

<cfprocessingdirective suppresswhitespace="yes">
<cfset vis_ip = CGI.REMOTE_ADDR>
<cfif vis_ip IS ''>
	<cfset vis_ip= '#CGI.REMOTE_HOST#'>
</cfif>
<cfset vis_date = Now()>
<cfset vis_month = dateformat(vis_date, "m")>
<cfset vis_year = dateformat(vis_date, "yyyy")>
<cfset vis_day = dateformat(vis_date, "d")>

<cfquery name = "qClicks" datasource="#request.dsn#">
SELECT * FROM stats_clicks 
WHERE stats_month = #vis_month# 
AND stats_year = #vis_year#
AND stats_day = #vis_day#
</cfquery>

<cfif qClicks.recordcount IS 0>
	<cfquery name="qInsert" datasource="#request.dsn#">
    INSERT INTO stats_clicks
    (carts, stats_date, stats_month, stats_year, stats_day)
    VALUES
    (1, #createodbcdate(vis_date)#, #vis_month#, #vis_year#, #vis_day#)
    </cfquery>

	<cfquery name = "qLogClicked" datasource="#request.dsn#">
    UPDATE stats_log
    SET vis_clicked = 1,
    carttoken = '#carttoken#'
    WHERE vis_ip = '#vis_ip#' 
    AND vis_month = #vis_month# 
    AND vis_year = #vis_year#
    AND vis_day = #vis_day#
    </cfquery>

<cfelse>

	<!---only log one click per visitor--->
	<cfquery name = "qLog" datasource="#request.dsn#">
    SELECT * FROM stats_log
    WHERE vis_ip = '#vis_ip#' 
    AND vis_month = #vis_month# 
    AND vis_year = #vis_year# 
    AND vis_day = #vis_day#
    AND vis_clicked = 1
    </cfquery>
    
    <!---if nothing is found above then log it as a click--->
    <cfif qLog.recordcount IS 0>
        <cfquery name = "qLogClick" datasource="#request.dsn#">
        UPDATE stats_clicks SET carts = carts + 1
        WHERE stats_month = #vis_month# 
        AND stats_year = #vis_year#
        AND stats_day = #vis_day#
        </cfquery>

        <cfquery name = "qLogClicked" datasource="#request.dsn#">
        UPDATE stats_log
        SET vis_clicked = 1,
        carttoken = '#carttoken#'
        WHERE vis_ip = '#vis_ip#' 
        AND vis_month = #vis_month# 
        AND vis_year = #vis_year#
        AND vis_day = #vis_day#
        </cfquery>

	</cfif>

</cfif>
</cfprocessingdirective>