<h2><strong>Product Categories</strong></h2>

<!---Show the category tree--->
<cf_maincategorytreeexpanded Directory="/"
ShowCurrentView="Yes"
Datasource="#request.dsn#"
CartToken="#CartToken#"
ShowBullet="Yes">

<!---Show the site links--->
<cfinclude template = "../queries/qrylinks.cfm">
<h2><strong>Site Info</strong></h2>

<cfoutput query="qrylinks"> 
	<cfset carttokenstring = '?CartToken=#CartToken#'>
	  <cfif qrylinks.linkref contains '?'>
	    <cfset carttokenstring = '&CartToken=#CartToken#'>
	  </cfif>
      <cfif request.use_urlrewrite IS 'yes'>
      <a href = "#urlrw#" target="#LinkTarget#" style="padding-bottom: 5px;">#LinkTitle#</a><br />
      <cfelse>
      <a href="#Linkref##carttokenstring#" Target="#LinkTarget#" style="padding-bottom: 5px;">#LinkTitle#</a><br>
      </cfif>
</cfoutput>




