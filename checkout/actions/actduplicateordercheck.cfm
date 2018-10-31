<!---When an order is processed, the cookies and cart are cleared before they reach the final page.  If the cookie then is missing then they hit their
back button and ended up back here.  If they process again, they could doublecharge the card.  So this is put here to prevent that.
If they go back further, their shopping cart will be empty anyway.--->
<style type="text/css">
<!--
.style1 {color: #FF0000}
-->
</style>

<cfif NOT isdefined('cookie.customerordernumber')>
	<h2 align="center" class="style1">Unable to process your order!</h2>
	<center>
	  <strong>Either You have completed the checkout process or you have deleted cookies from your browser.<br />
      In order to prevent double-charging you for an order we have put a safe-guard in place to prevent you from hitting your 
      back button and reprocessing the order.<br>
      <p>
      We have emptied your shopping cart and cleared the order from your web browser.  If you already completed the order, you can login to 
      <br>your account to view it.
	</center>
    <p>
	<cfset processpage = 'No'>
	</p>
</cfif>





