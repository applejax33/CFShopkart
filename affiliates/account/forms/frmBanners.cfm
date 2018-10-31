<cfinclude template="../queries/qryBanners.cfm">

<h2>Promotional Banners</h2>
Use this link to refer people to our website:  <cfoutput><a href = "#request.HomeURL#index.cfm?affilID=#request.affiliateid#" target="_blank">#request.HomeURL#index.cfm?affilID=#request.affiliateid#</a></cfoutput>
<p>
<table width="99%" border="0" align="center" cellpadding="4" cellspacing="0">
  <tr bgcolor="3333CC"> 
    <td bgcolor="#000000"><font color="FFFFFF"><b>&nbsp;&nbsp;Image</b></font></td>
    <td width="40%" align="left" bgcolor="#000000"><font color="FFFFFF"><strong>HTML Code</strong></font></td>
  </tr>
  <cfoutput query = "qryImages"> 
    <tr <cfif qryImages.currentrow MOD 2>bgcolor="##CCCCCC"</cfif>> 
      <td><img src="#qryCompanyinfo.homeurl#images/#location#" border="0"></td>
      <td align="left">
        <textarea name="textarea" cols="60" rows="5"><a href = "#request.HomeURL#?affilID=#request.affiliateid#" target="_blank"><img src = "#request.HomeURL#images/banners/#location#" border="0" /></a></textarea>	  </td>
    </tr>
  </cfoutput> 
</table>








