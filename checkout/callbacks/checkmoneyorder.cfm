<p align="left">
You have selected to pay by check or money order.  Your order will not ship until we receive payment.
Please send your payment to:
</p>
<cfoutput query = "qryCompanyInfo">
<p align="left">
#CompanyName#<br>
#Address# #apt# <br />
#City#, #State#  #Zip#
</p></cfoutput>

<p align="left">
For faster delivery, please write your Order Number on the check or money order!
</p>
