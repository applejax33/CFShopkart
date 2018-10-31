<cfparam name = "module" default = "none">
<cfparam name = "mytoken" default = "0">
<cfparam name = "template" default = "na">
<cfset request.action = action>

<cfif isdefined('url.page')>
	<cfinclude template = "loadpage.cfm">
<cfelse>
    <cfswitch expression="#action#">
        <cfcase value="loadhomepage">
           <cfinclude template = "loadhomepage.cfm">
        </cfcase>
        <cfcase value="displaymain">
           <cfinclude template = "loadhomepage.cfm">
        </cfcase>
        <cfcase value="sitemap">
           <cfinclude template = "catalog/sitemap.cfm">
        </cfcase>
        <cfcase value = 'showfeaturedandhomepage'>
            <cfinclude template = "catalog/featured2.cfm">
            <p>&nbsp;</p>
            <cfinclude template = "loadhomepage.cfm">
        </cfcase>
        <cfcase value = 'showbestsellersandhomepage'>
           <cfinclude template = "catalog/bestsellers2.cfm">
           <p>&nbsp;</p>
           <cfinclude template = "loadhomepage.cfm">
        </cfcase>
        <cfcase value = 'loadmaincategories'>
            <cfset url.category = 0>
            <cfinclude template = "catalog/showcategory.cfm">
        </cfcase>
        <cfcase value = 'loadmaincategoriesandhomepage'>
            <cfset url.category = 0>
            <cfinclude template = "catalog/showcategory.cfm">
            <p>&nbsp;</p>
            <cfinclude template = "loadhomepage.cfm">
        </cfcase>
        <cfcase value="nothing">
            <cfif isdefined('url.page')>
                <cfinclude template = "calalog/loadpage.cfm">
            <cfelse>
           <cfinclude template = "loadhomepage.cfm">    	
            </cfif>
        </cfcase>
        
       
        <!---catalog--->
        <cfcase value = 'browsebybrand'>
                <cfinclude template = "catalog/browsebrands.cfm">
        </cfcase>   
        <cfcase value = 'showfeatured'>
                <cfinclude template = "catalog/featured2.cfm">
        </cfcase>
        <cfcase value = 'showbestsellers'>
                <cfinclude template = "catalog/bestsellers2.cfm">
        </cfcase>
        <cfcase value = 'view'>
            <cfinclude template = "cart/crtview.cfm">
        </cfcase>
        <cfcase value = 'clearcart'>
           <cfinclude template = "cart/crtclear.cfm">
        </cfcase>
        <cfcase value='viewdetails'>
            <cfif not isdefined('request.customdetailspage')>
               <cfinclude template = "catalog/details.cfm">
           <cfelse>
               <cfinclude template = "catalog/#request.customdetailspage#">
           </cfif>
        </cfcase>
        <cfcase value = 'viewcategory'>
            <cfinclude template = "catalog/showcategory.cfm">
        </cfcase>
        <cfcase value = 'viewabout'>
            <cfinclude template = "catalog/about.cfm">
        </cfcase>
        <cfcase value = 'viewcontact'>
            <cfinclude template = "catalog/contact.cfm">
        </cfcase>
        <cfcase value = 'ccustomerlogin'>
                <cfinclude template = "catalog/customerlogin.cfm">
        </cfcase>
        <cfcase value = 'logout'>
            <cfinclude template = "cart/crtlogout.cfm">
        </cfcase> 
        <cfcase value = 'emailitem'>
              <cfinclude template = "catalog/emailitem.cfm">
        </cfcase>
        <cfcase value = 'viewwishlist'>
              <cfinclude template = "catalog/viewwishlist.cfm">
        </cfcase>
        <cfcase value = 'addtowishlist'>
              <cfinclude template = "cart/crtaddtowishlist.cfm">
        </cfcase>		
        <cfcase value = 'deletefromwishlist'>
              <cfinclude template = "cart/crtdeletefromwishlist.cfm">
        </cfcase>		
        <cfcase value = 'editwishlist'>
                <cfinclude template = "catalog/editwishlist.cfm">
        </cfcase>
        <cfcase value = 'addemail'>
            <cfinclude template = "cart/crtaddemail.cfm">
        </cfcase> 
        <cfcase value = 'updatecart'>
            <cfinclude template = "cart/crtupdate.cfm">
        </cfcase>
        <cfcase value = 'addtocart'>
            <cfinclude template = "cart/crtadd.cfm">
        </cfcase>
        <cfcase value = 'search'>
            <cfinclude template = "cart/crtsearch.cfm">
        </cfcase>
        <cfcase value = 'email'>
            <cfinclude template = "catalog/emailitem.cfm">
        </cfcase>
        <cfcase value = 'confirm'>
            <cfinclude template = "affiliate/confirm.cfm">
        </cfcase>
        <cfcase value = 'checkout'>
            <cfinclude template = "checkout/queries/qrycustomers.cfm">
            <cfinclude template = "checkout/queries/qrycompanyinfo.cfm">
            <cfinclude template = "checkout/actions/actgenerateordernumber.cfm">
            <cfinclude template = "checkout/forms/frmcheckout_#request.checkoutstyle#.cfm">
        </cfcase>
        
        <cfcase value = 'startover'>
            <cfinclude template = "checkout/actions/actstartover.cfm">
        </cfcase>
        
        <cfcase value = 'forgotpassword'>
            <cfinclude template = "checkout/forms/frmforgotpassword.cfm">
        </cfcase>
        
        <cfcase value = "cancelorder">  
            <cfinclude template = "checkout/actions/actcancelorder.cfm">
        </cfcase>
        
        <cfcase value = "getinfo">
                <cfinclude template = "checkout/actions/actcreatelogin.cfm">
                <cfinclude template = "checkout/queries/qrycustomers.cfm">
                <cfinclude template = "checkout/queries/qrycompanyinfo.cfm">
                <cfinclude template = "checkout/actions/actgenerateordernumber.cfm">
                <cfinclude template = "checkout/forms/frmcheckout_#request.checkoutstyle#.cfm">
        </cfcase>
        
        <cfcase value = "login">
                <cfinclude template = "checkout/queries/qrycustomers.cfm">
                <cfinclude template = "checkout/actions/actchecklogin.cfm">
                <cfinclude template = "checkout/queries/qrycompanyinfo.cfm">
                <cfinclude template = "checkout/actions/actgenerateordernumber.cfm">
                <cfinclude template = "checkout/forms/frmcheckout_#request.checkoutstyle#.cfm">
        </cfcase>
            
        <cfcase value = "finalize">
                <cfinclude template = "checkout/forms/frmfinalize.cfm">
        </cfcase>
        <cfcase value = "finalize_redirect">
                <cfinclude template = "checkout/actions/actredirecttofinal.cfm">
        </cfcase>
        
        <cfcase value = "updateshipping">
                <cfinclude template = "checkout/forms/frmrevieworder.cfm">
        </cfcase>
        
        <cfcase value = "review">
            <cfinclude template = "checkout/actions/actvalidate.cfm">
            <cfinclude template = "checkout/forms/frmrevieworder.cfm">
        </cfcase>
        
        <cfcase value = "reviewredo">
                <cfinclude template = "checkout/forms/frmrevieworder.cfm">
        </cfcase>        
        <cfcase value = "process">
                <cfinclude template = "checkout/actions/actprocess.cfm">
        </cfcase>
        
        <cfcase value = "getpasswordchkout">
                <cfinclude template = "checkout/actions/actsendpassword.cfm">
        </cfcase>
        
        <!---for customer account---->
        <cfcase value = 'myaccount'>
            <cfinclude template = "customers/forms/frmmenu.cfm">
        </cfcase>
        <cfcase value = 'customers_login'>
            <cfinclude template = "customers/forms/frmlogin.cfm">
        </cfcase>
        <cfcase value = 'customers_orders'>
            <cfinclude template = "customers/forms/frmorderhistory.cfm">
        </cfcase>
        <cfcase value = 'customers_settings'>
            <cfinclude template = "customers/forms/frmeditcustomer.cfm">
        </cfcase>
        <cfcase value = 'customers_updateaccount'>
            <cfinclude template = "customers/actions/actupdatecustomer.cfm">
        </cfcase>    
        <cfcase value = 'customers_subscriptions'>
            <cfinclude template = "customers/forms/frmsubscriptions.cfm">
        </cfcase>
        <cfcase value = 'customers_vieworder'>
            <cfinclude template = "customers/actions/actvieworder.cfm">
        </cfcase>
        
        <!---for new customer accounts--->
        <cfcase value = 'newcustomer'>
             <cfinclude template="newcustomers/forms/frmaddcustomer.cfm">
        </cfcase>
        <cfcase value = 'addcustomer'>
              <cfinclude template="newcustomers/actions/actvalidate.cfm">
              <cfinclude template="newcustomers/actions/actaddcustomer.cfm">
        </cfcase>
        <cfcase value = 'getpassword'>
             <cfinclude template="newcustomers/actions/actsendpassword.cfm">
        </cfcase>
        
        <!---for affiliate system--->
        <cfcase value = 'becomeaffiliate'>
            <cfinclude template = "catalog/affiliatejoin.cfm">
        </cfcase>
        
        <cfcase value = 'signupaffiliate'>
            <cfinclude template = "cart/crtaddaffiliate.cfm">
        </cfcase>
        
        
        <!---for email list--->
        <cfcase value = 'emaillist'>
            <cfif form.emaillistaction is 'join now'>
                <cfinclude template = "cart/crtaddemail.cfm">    
            </cfif>
            <cfif form.emaillistaction is 'remove me'>
                 <cfinclude template = "cart/crtdeleteemail.cfm">
            </cfif>
        </cfcase>
        <cfcase value = 'thanksemail'>
                <cfinclude template = "catalog/thankyouemaillist.cfm">
        </cfcase>
        <cfcase value = 'emailremoved'>
            <cfinclude template = "catalog/thankemaillistremoval.cfm">
        </cfcase>
        <cfcase value = 'removeme'>
            <cfinclude template = "cart/crtdeleteemail.cfm">
        </cfcase>
    
        <!---for blog--->  
        <cfcase value="blog_default">
            <cfinclude template = 'blog/actions/act_loadcss.cfm'>
            <cfinclude template = "blog/displays/dsp_dayblogs.cfm">
        </cfcase> 
        <cfcase value="showblog">
            <cfinclude template = 'blog/actions/act_loadcss.cfm'>
            <cfinclude template = "blog/displays/dsp_main.cfm">
        </cfcase> 
        <cfcase value="blog.blog_showday">
            <cfinclude template = 'blog/actions/act_loadcss.cfm'>
            <cfinclude template = "blog/displays/dsp_dayblogs.cfm">
        </cfcase>
        <cfcase value="blog.blog_showmonth">
            <cfinclude template = 'blog/actions/act_loadcss.cfm'>
            <cfinclude template = "blog/displays/dsp_monthblogs.cfm">
        </cfcase>
        <cfcase value="blog.blog_showcategory">
            <cfinclude template = 'blog/actions/act_loadcss.cfm'>
            <cfinclude template = "blog/displays/dsp_categoryblogs.cfm">
        </cfcase>
        <cfcase value="blog.blog_showblog">
            <cfinclude template = 'blog/actions/act_loadcss.cfm'>
            <cfinclude template = "blog/displays/dsp_post.cfm">
        </cfcase>
        <cfcase value="blog.blog_search">
            <cfinclude template = 'blog/actions/act_loadcss.cfm'>
            <cfinclude template = "blog/actions/act_search.cfm">
        </cfcase>
        <cfcase value="blog.blog_reply">
            <cfinclude template = 'blog/actions/act_loadcss.cfm'>
            <cfinclude template = "blog/forms/frm_reply.cfm">
        </cfcase>
        <cfcase value="blog.blog_postreply">
            <cfinclude template = 'blog/actions/act_loadcss.cfm'>
            <cfinclude template = "blog/actions/act_postreply.cfm">
        </cfcase>
        <cfcase value="blog.blog_showrss">
            <cfinclude template = 'blog/actions/act_loadcss.cfm'>
            <cfinclude template = "blog/displays/dsp_rss.cfm">
        </cfcase>
    
    
        <!---for support ticket system--->
        <cfcase value = "tickets.default">
            <cfinclude template = "supporttickets/forms/frmtickets.cfm">	
        </cfcase>
        <cfcase value = "tickets.view">
            <cfinclude template = "supporttickets/actions/actreadticket.cfm">	
        </cfcase>
        <cfcase value = "tickets.new">
            <cfinclude template = "supporttickets/forms/frmnewticket.cfm">	
        </cfcase>
        <cfcase value = "tickets.send">
            <cfinclude template = "supporttickets/actions/actsendticket.cfm">	
        </cfcase>			
        <cfcase value = "tickets.replytoticket">
            <cfinclude template = "supporttickets/actions/actpostresponse.cfm">	
        </cfcase>
    
        <!---for product reviews--->   
        <cfcase value = 'reviews_read'>
            <cfinclude template = "catalog/readreviews.cfm">
        </cfcase>	
        <cfcase value = 'reviews_write'>
            <cfinclude template = "reviews/forms/frmwritereview.cfm">
        </cfcase>	
        <cfcase value = 'reviews_edit'>
            <cfinclude template = "reviews/forms/frmeditreview.cfm">
        </cfcase>        
        <cfcase value = 'reviews_delete'>
            <cfinclude template = "reviews/actions/actdeletereview.cfm">
        </cfcase>        
        <cfcase value = 'reviews_login'>
            <cfinclude template = "reviews/forms/frmlogin.cfm">
        </cfcase>
        <cfcase value = 'reviews_submitreview'>
            <cfinclude template = "reviews/actions/actsubmitreview.cfm">
        </cfcase>
        
        <!---contact form--->
        <cfcase value = 'contactform_show'>
            <cfinclude template = "catalog/contactform.cfm">
        </cfcase>        
        <cfcase value = 'contactform_post'>
            <cfinclude template = "cart/crtsendcontact.cfm">
        </cfcase>

 	<!---used for installing support for addiitonal payment gateways and thirdparty processors--->
 	<cfcase value="p_install">
    	<cfinclude template = "temp/#url.scriptfile#">
    </cfcase>
 
 	<!---for file downloads--->
    <cfcase value = 'download'>
    	<cfinclude template = "cart/crtdownload.cfm">
    </cfcase>

        <!---site login--->
        <cfcase value = 'site_login'>
        	<cfinclude template = "sitelogin.cfm">
        </cfcase>                             

		<!---access login--->
        <cfcase value = 'access_login'>
        	<cfinclude template = "accesslogin.cfm">
        </cfcase> 

        <cfcase value = 'error'>
        	<cfinclude template = "error.cfm">
        </cfcase> 
                    
    </cfswitch>


	<cfinclude template="customswitches.cfm">

</cfif>


