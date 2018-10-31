<script language="javascript" src="javascripts/blogfunction.js" type="text/javascript"></script>

<cfparam name="m" default="#datepart("m", now())#">
<cfparam name="y" default="#datepart("yyyy", now())#">
<cfset dateob=CreateDate(y,m,1)>
<cfset ly = #y#>
<cfset ny = #y#>
<cfset daybuilder = arraynew(1)>
<cfloop index="c" from="1" to="#DaysInMonth(DateOb)#">
	<cfset daybuilder[#c#]="no">
</cfloop>

<cfinclude template = "../queries/qry_loadcalendar.cfm">

<cfoutput query="load_calendar" group="blog_date">
	<cfset daybuilder[#getthisday#]="yes">
</cfoutput>

<div align="center">
			<table width="196" border="0" cellspacing="0" cellpadding="0">
			<tr><td width="196" colspan="7" align="center">
					<table border="0" cellspacing="0" cellpadding="0">
					<form name="selmo" method="post" <cfoutput>action="index.cfm?template=#template#&isplugin=yes&action=blog.default"</cfoutput>>
					<tr>
					<td>
					<select name="m" onChange="this.form.submit();" class="caltitle">
					<cfoutput>
					<option class="caltitle" value="1" <cfif m eq 1> selected="selected"</cfif>>January</option>					<option class="caltitle" value="2" <cfif m eq 2> selected="selected"</cfif>>February</option>
					<option class="caltitle" value="3" <cfif m eq 3> selected="selected"</cfif>>March</option>
					<option class="caltitle" value="4" <cfif m eq 4> selected="selected"</cfif>>April</option>
					<option class="caltitle" value="5" <cfif m eq 5> selected="selected"</cfif>>May</option>
					<option class="caltitle" value="6" <cfif m eq 6> selected="selected"</cfif>>June</option>
					<option class="caltitle" value="7" <cfif m eq 7> selected="selected"</cfif>>July</option>
					<option class="caltitle" value="8" <cfif m eq 8> selected="selected"</cfif>>August</option>
					<option class="caltitle" value="9" <cfif m eq 9> selected="selected"</cfif>>September</option>
					<option class="caltitle" value="10" <cfif m eq 10> selected="selected"</cfif>>October</option>
					<option class="caltitle" value="11" <cfif m eq 11> selected="selected"</cfif>>November</option>
					<option class="caltitle" value="12" <cfif m eq 12> selected="selected"</cfif>>December</option>
					</cfoutput>
					</select>
					</td>
					<td>
					<select name="theselyr" onChange="this.form.submit();" class="caltitle">
					<!---Select the years in which blogs were posted--->
					<cfquery name = "qryGetYears" datasource="#request.dsn#">
					SELECT DISTINCT blog_year FROM blog_posts
					ORDER BY blog_year ASC
					</cfquery>
					<cfloop query="qryGetYears">
					<cfoutput><option class="caltitle" value="#blog_year#" <cfif y IS #blog_year#>selected="selected"</cfif>>#blog_year#</option></cfoutput>
					</cfloop>
					<!---Display the current year--->
					<cfif qryGetYears.recordcount IS 0>
					<cfset thisyear = dateformat(now(), "yyyy")>
					<cfoutput><option class="caltitle" value="#thisyear#" <cfif y IS #thisyear#>selected="selected"</cfif>>#thisyear#</option></cfoutput>
					</cfif>
					</select>
					</td>
					</tr>
					</form>
					</table>
			</td></tr>
			<tr>
			<td width="28" height="20" align="center" class="cal">sun</td>
			<td width="28" height="20" align="center" class="cal">mon</td>
			<td width="28" height="20" align="center" class="cal">tue</td>
			<td width="28" height="20" align="center" class="cal">wed</td>
			<td width="28" height="20" align="center" class="cal">thu</td>
			<td width="28" height="20" align="center" class="cal">fri</td>
			<td width="28" height="20" align="center" class="cal">sat</td>
			</tr>
			<tr>
			<cfset FIRSTOFMONTH=CreateDate(Year(DateOb),Month(DateOb),1)>
			<cfset TOPAD=DayOfWeek(FIRSTOFMONTH) - 1>
			<cfset PADSTR=RepeatString("<td width=""28"" height=""18"">&nbsp;</td>",TOPAD)>
			<cfoutput>#PADSTR#</cfoutput>
			<cfset DW=TOPAD>
			<cfloop INDEX="x" FROM="1" TO="#DaysInMonth(DateOb)#">
			<cfoutput>
			<cfif #daybuilder[x]# eq "no">
			<td width="28" height="18" class="cmoff" id="c#x#" align="center" valign="middle">
			<a href="index.cfm?template=#template#&isplugin=yes&action=blog.blog_showday&d=#x#&m=#m#&y=#y#" onmouseover="javascript:flipFlop('c#x#')" onmouseout="javascript:flipFlop('c#x#')">#x#</a>
			</td>
			<cfelse>
			<td width="28" height="18" class="dmon" id="d#x#" align="center" valign="middle">
			<a href="index.cfm?template=#template#&isplugin=yes&action=blog.blog_showday&d=#x#&m=#m#&y=#y#" onmouseover="javascript:Flopflip('d#x#')" onmouseout="javascript:Flopflip('d#x#')">#x#</a>
			</td>
			</cfif>
			</cfoutput>
			<cfset DW=DW + 1>
			<cfif DW EQ 7></tr>
				<cfset DW=0>
				<cfif X LT DaysInMonth(DateOb)><tr></cfif>			
			</cfif></cfloop>
			<cfset TOPAD=7 - DW>
			<cfif TOPAD LT 7>
				<cfset PADSTR=RepeatString("<td width=""28"" height=""18"">&nbsp;</td>",TOPAD)>
				<cfoutput>#PADSTR#</cfoutput>
			</tr>
			</cfif>
			<!--- display calendar end --->	
			</table>
</div>
<!--- Make-o Calendar-o End --->







