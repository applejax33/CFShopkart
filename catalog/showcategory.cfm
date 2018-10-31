<cfinclude template = "../queries/qrycategories.cfm">

<cfset GrantAccess = 'Yes'>

<!---Check permissions on category.--->
<cfif NOT qryCategories.permissions IS 'public' AND NOT qryCategories.permissions IS '0' AND NOT len(qryCategories.permissions) IS 0>

	<cfif NOT isdefined('cookie.customerid')>
        <p>
        <center><b>You must login to access this area</b></center>
        <p>
        <cfoutput><center><a href = "index.cfm?action=myaccount&carttoken=#carttoken#">Click Here To Login</a></center></cfoutput>
        <cfset GrantAccess = 'No'>
    <cfelse>

		<!---if the cookie exists check to see if this person is allowed to access this area--->
        <cfquery name = "qryCustomerSubscriptions" datasource="#request.dsn#">
        SELECT * FROM customers_subscriptions
        WHERE r_id = '#qryCategories.permissions#' AND customerid = '#cookie.customerid#' AND status = 'Active' 
        </cfquery>
	
		<cfif qryCustomerSubscriptions.recordcount IS 0>
            <p>&nbsp;</p>
            <div class="access_denied_msg">
            <center><b>You do not have permission to <br />
            enter this area of our website.</b></center>
            </div>
                       
            <cfset GrantAccess = 'No'>
		</cfif>
        
        <cfif qryCustomerSubscriptions.recordcount GT 0>
        <!---check to see if their subscription expired--->
        <cfset thedatetoday = now()>
        
        <cfif qryCustomersubscriptions.expiredate LT thedatetoday>
            <p>&nbsp;</p>
            <div class="access_denied_msg">
        	<center><b>Your subscription has expired<br />
            You no longer have access to this area</b>
            </center>
            </div>

            <cfquery name = "qryUpdate" datasource="#request.dsn#">
            UPDATE customers_subscriptions
            SET status = 'Expired'
            WHERE customerid = '#cookie.customerid#' AND r_id = '#qryCategories.permissions#'
            </cfquery>
                        
			<cfset GrantAccess = 'No'>
        </cfif>
        
        </cfif>
	</cfif>
</cfif>
     		
<cfif GrantAccess IS 'Yes'>
	<!---Set a default value--->
		<cfset CatLayout = '1'>
					
		<!---Now see what layout this one is using--->
		<cfoutput query="qryCategories">
			<cfset CatLayout = '#CategoryLayout#'>
            <cfset ShowSubCats = '#ShowSubCats#'>
		</cfoutput>
		
		<cfinclude template = "ViewCategory_header.cfm">                          
		
		<cfif CatLayout IS '1'>
			 <cfinclude template = "ViewCategory.cfm">
		</cfif>
		<cfif CatLayout IS '2'>
			<cfinclude template = "ViewCategory2.cfm">
		</cfif>
		<cfif CatLayout IS '3'>
			<cfinclude template = "ViewCategory3.cfm">
		</cfif>
		
		<cfinclude template = "ViewCategory_footer.cfm">							
</cfif>



