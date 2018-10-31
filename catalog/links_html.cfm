<cfinclude template = "../queries/qrylinks.cfm">

<cfset carttokenstring = '?CartToken=#CartToken#'>

<table width="100%" cellpadding="0" cellspacing="0" class="LinksTable">
<cfoutput query="qrylinks"> 
 <cfif qryLinks.Linkref CONTAINS '#request.homeurl#'>
	<cfif qrylinks.linkref contains '?'>
        <cfset carttokenstring = '&CartToken=#CartToken#'>
    <cfelse>
        <cfset carttokenstring = '?CartToken=#CartToken#'>
    </cfif>
  <cfelse>
  	<cfset carttokenstring = ''>
  </cfif>
	<tr class="LinksRow">
		<td class="LinksCell" onmouseover="this.className='LinksCellHover';" onmouseout="this.className='LinksCell';">
		   <cfif request.use_urlrewrite IS 'Yes'>
	           <cfif urlrw IS 'NONE'>
               	<a href="#Linkref##carttokenstring#" Target="#LinkTarget#" class="LinksLink">#LinkTitle#</a>
               <cfelse>
               		<a href="#request.absolutepath##urlrw#" Target="#LinkTarget#" class="LinksLink">#LinkTitle#</a>
               </cfif>
           <cfelse>
           		<a href="#Linkref##carttokenstring#" Target="#LinkTarget#" class="LinksLink">#LinkTitle#</a>
           </cfif>
		</td>
     </tr>
</cfoutput>
</table>



