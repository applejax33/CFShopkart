<cfinclude template = "../queries/qrylinks.cfm">

<cfset carttokenstring = '?CartToken=#CartToken#'>

<table width="100%" cellpadding="0" cellspacing="0" class="LinksTable">
<cfoutput query="qrylinks"> 
	<tr class="LinksRow">
		<td class="LinksCell" onmouseover="this.className='LinksCellHover';" onmouseout="this.className='LinksCell';" onclick="window.location.href = '#Linkref##carttokenstring#';">
		  <cfif qrylinks.linkref contains '?'>
            <cfset carttokenstring = '&CartToken=#CartToken#'>
          </cfif>
	<img name="linkimage#linkid#" id="linkimage#linkid#" src = "photos/#LinkImage#" border="0" <cfif NOT #LinkRImage# IS 'none'>onmouseover="this.src='photos/#LinkRImage#';" onmouseout="this.src='photos/#LinkImage#';"</cfif>></a>
    </td>
    </tr>
</cfoutput>
</table>



