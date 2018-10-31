<cfif qryBrochures.recordcount GT 0>
	<cfoutput>
	  <div align="left"><a href = "#request.HomeURL#/brochures/#itemid#/brochure.html" target="_blank">
      <img src = "#request.HomeURL#/brochures/#itemid#/SMbrochure.jpg" border="0"><br>
		View  Brochure</a></div>
	</cfoutput>
</cfif>



