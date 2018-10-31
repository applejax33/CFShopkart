<cfparam name="Attributes.ShowTitle" Default="No">
<cfparam name="Attributes.SearchTitleText" Default="Search Store">
<cfparam name="Attributes.BackgroundShading" Default="Yes">
<cfparam name="Attributes.Size" Default="15">

<!---This will display the search form--->
<cfinclude template = "../queries/qrycompanyinfo.cfm">
<cfoutput query = "qryCompanyInfo"> 
  <cfset SearchButtonURL = '#SearchButtonURL#'>
</cfoutput> 

<form method="POST" <cfoutput>action="index.cfm?CartToken=#CartToken#"</cfoutput>>
<TD width="50%" valign="middle" align="right">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="navbartxt">
	 <tr>
    <td align="right" style="padding-right: 4px;">
        <cfoutput>#Attributes.SearchTitleText#</font> 
        <input type="text" name="SearchBox" size="#Attributes.Size#"></cfoutput>
          <input type="hidden" name="Action" value="Search">
          <cfif #SearchButtonURL# IS 'Standard'>
            <input type="submit" value="Go" name="B1">
          </cfif>
          <cfif NOT #SearchButtonURL# IS 'Standard'>
            <cfoutput> 
              <input type="image" name="SearchCatalog" src="photos/#SearchButtonURL#">
            </cfoutput>
          </cfif>
      </td>
    </tr>
</table>
</td>
</form>






