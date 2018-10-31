<!---<cfinclude template="../../../../header.cfm">--->
<cfinclude template = "../queries/qrySubAffiliates.cfm">

<h3>Your Referrals</h3>

<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td width="10%" bgcolor="#6B9ACE"><font color="#FFFFFF"><b>AffiliateID</b></font></td>
    <td width="10%" bgcolor="#6B9ACE"><font color="#FFFFFF"><b>Signup Date</b> </font></td>
    <td width="60%" bgcolor="#6B9ACE"><font color="#FFFFFF"><b>Name</b></font></td>
    <td width="10%" bgcolor="#6B9ACE"><div align="center"><font color="#FFFFFF"><strong>Clicks</strong></font></div></td>
    <td width="10%" bgcolor="#6B9ACE"><center><font color="#FFFFFF"><b>Sales</b></font></center></td>
  </tr>
  <cfoutput query = "qrySubAffiliates">
	<tr>
    <td>#affiliateID#</td>
    <td>#dateformat(DateSignup, "mm/dd/yyyy")#</td>
    <td>#firstname# #lastname#</td>
	<td><div align="center">#hits#</div></td>
    <td><div align="center">#sales#</div></td>
  </tr>
	</cfoutput>
</table>







