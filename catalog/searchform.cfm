<cfparam name="Attributes.ShowTitle" Default="Yes">
<cfparam name="Attributes.SearchTitleText" Default="Search Store">
<cfparam name="Attributes.BackgroundShading" Default="Yes">
<cfparam name="Attributes.Size" Default="15">

<!---This will display the search form--->
<cfinclude template = "../queries/qrycompanyinfo.cfm">
<cfoutput query = "qryCompanyInfo"> 
  <cfset SearchButtonURL = '#SearchButtonURL#'>
</cfoutput> 

<table width="100%" border="5" cellspacing="0" cellpadding="4" <cfoutput>bordercolor="#qrySettings.TableBG#"</cfoutput>>
	<cfif Attributes.ShowTitle IS 'Yes'>
	<cfoutput>
	<tr> 
	<td height="22" width="100%" class="TableTitles"><div align="center" class="bodytxt"> 
        <b>#Attributes.SearchTitleText#</b></div></td>
	</tr>
	</cfoutput>
	</cfif>
    <tr> <cfoutput>
    <td height="5" valign="top" width="100%" Class="TableCells">
		</cfoutput>
      <form method="POST" <cfoutput>action="index.cfm?carttoken=#carttoken#"</cfoutput>><span class="bodytxt">
        <div align="center">
          <cfoutput><input type="text" name="SearchBox" size="#Attributes.Size#"></cfoutput>
          <input type="hidden" name="Action" value="Search">
          <cfif #SearchButtonURL# IS 'Standard'>
            <input type="submit" value="Go" name="B1">
          </cfif>
          <cfif NOT #SearchButtonURL# IS 'Standard'>
            <cfoutput> 
              <input type="image" name="SearchCatalog" src="photos/#SearchButtonURL#">
            </cfoutput>
          </cfif>
        </div>
      </form>
      <span class="bodytxt"></span> </td>
    </tr>
</table>







