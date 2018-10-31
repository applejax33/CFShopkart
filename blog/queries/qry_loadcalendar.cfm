<cfquery name="load_calendar" datasource="#request.dsn#">
SELECT      blog_date,(day(blog_date)) AS getthisday
FROM        blog_posts 
WHERE	(blog_date >= #CreateDate(Year(DateOb),Month(DateOb),1)#) and (blog_date <= #CreateDate(Year(DateOb),Month(DateOb),DaysInMonth(DateOb))#)
</cfquery>







