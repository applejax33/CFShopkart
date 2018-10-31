
<!--- 
Surefire Commerce Inc. : FirePay custom tag solution
This tag is for Coldfusion version 5.x+
--->

<cftry>
	
	<!--- Initializing required variables --->
	<cfparam name="attributes.account" 			default="">
	<cfparam name="attributes.amount" 			default="">
	<cfparam name="attributes.cardNumber" 		default="">
	<cfparam name="attributes.cardMonth" 		default="">
	<cfparam name="attributes.cardYear" 		default="">
	<cfparam name="attributes.cardType" 		default="">
	<cfparam name="attributes.customerName" 	default="">
	<cfparam name="attributes.streetAddr" 		default="">
	<cfparam name="attributes.streetAddr2" 	default="">
	<cfparam name="attributes.phone" 			default="">
	<cfparam name="attributes.email" 			default="">
	<cfparam name="attributes.city" 				default="">
	<cfparam name="attributes.province" 		default="">
	<cfparam name="attributes.country" 			default="">
	<cfparam name="attributes.zip" 				default="">
	<cfparam name="attributes.merchantTxn" 	default="">
	<cfparam name="attributes.merchantId" 		default="">
	<cfparam name="attributes.merchantPwd" 	default="">
	<cfparam name="attributes.operation" 		default="P">
	<cfparam name="attributes.clientVersion" 	default="1.03">
	<cfparam name="attributes.debug" 			default="false">
	<cfparam name="attributes.returnvariable" default="response">
	<cfparam name="attributes.onError" 			default="">
	<cfparam name="attributes.addToken" 		default="false">
	
	<!--- Initialize structure for response --->
	<cfset "caller.#attributes.returnvariable#" = structNew()>
	
	<!--- 
	If Debug is enabled this tag will POST to the FirePay test site 
	--->
	<cfif attributes.debug>
		<cfset firepayUrl = "realtime.test.firepay.com/servlet/DPServlet">
	<cfelse>
		<cfset firepayUrl = "realtime.firepay.com/servlet/DPServlet">
	</cfif>
	
	<cfset start = getTickCount()>
	
	<cftry>
		<!--- POST transaction parameters to FirePay --->
		<cfhttp url="https://#firepayUrl#" method="POST" port="443" resolveurl="false" timeout="45" throwonerror="yes">
			<cfhttpparam type="FORMFIELD" name="account" 		value="#trim(attributes.account)#">
			<cfhttpparam type="FORMFIELD" name="amount" 			value="#trim(attributes.amount)#">
			<cfhttpparam type="FORMFIELD" name="cardNumber" 	value="#trim(attributes.cardNumber)#">
			<cfhttpparam type="FORMFIELD" name="cardExp" 		value="#trim(attributes.cardMonth)#/#trim(attributes.cardYear)#">
			<cfhttpparam type="FORMFIELD" name="cardType" 		value="#trim(attributes.cardType)#">
			<cfhttpparam type="FORMFIELD" name="operation" 		value="#ucase(attributes.operation)#">
			<cfhttpparam type="FORMFIELD" name="clientVersion" value="#attributes.clientVersion#">
			<cfhttpparam type="FORMFIELD" name="custName1" 		value="#trim(attributes.customerName)#">
			<cfhttpparam type="FORMFIELD" name="streetAddr" 	value="#trim(attributes.streetAddr)#">
			<cfhttpparam type="FORMFIELD" name="streetAddr2" 	value="#trim(attributes.streetAddr2)#">
			<cfhttpparam type="FORMFIELD" name="phone" 			value="#trim(attributes.phone)#">
			<cfhttpparam type="FORMFIELD" name="email" 			value="#trim(attributes.email)#">
			<cfhttpparam type="FORMFIELD" name="city" 			value="#trim(attributes.city)#">
			<cfhttpparam type="FORMFIELD" name="province" 		value="#trim(attributes.province)#">
			<cfhttpparam type="FORMFIELD" name="zip" 				value="#trim(attributes.zip)#">
			<cfhttpparam type="FORMFIELD" name="country" 		value="#trim(attributes.country)#">
			<cfhttpparam type="FORMFIELD" name="merchantTxn" 	value="#trim(attributes.merchantTxn)#">
			<cfhttpparam type="FORMFIELD" name="merchantId" 	value="#trim(attributes.merchantId)#">
			<cfhttpparam type="FORMFIELD" name="merchantPwd" 	value="#trim(attributes.merchantPwd)#">
		</cfhttp>
		<cfcatch>
			<cfdump var="#attributes#" label="Call Failed: Values passed into the FirePay component">
			<cfoutput>#cfcatch.message#</cfoutput>
			<cflog text="#cfcatch.message#" type="Error" thread="yes" date="yes" time="yes" application="yes">
			<cfabort>
		</cfcatch>
	</cftry>
	
	<!--- Calculate Transaction Time --->
	<cfset "caller.#attributes.returnvariable#.transactionTime" = (getTickCount() - start) / 1000 & "sec">
	
	<!--- Decipher FirePay response into a Coldfusion structure for easier handling --->
	<cfloop index="x" list="#cfhttp.filecontent#" delimiters="&">
		<cftry>
			<cfset "caller.#attributes.returnvariable#.#listGetAt( x , 1 , "=" )#" = listGetAt( x , 2 , "=" )>
			<cfcatch></cfcatch>
		</cftry>
	</cfloop>
	
	<!--- Show local time of authorization--->
	<cftry>
		<cfif ucase(attributes.operation) EQ "P" OR ucase(attributes.operation) EQ "A">
			<cfset utcTime = DateAdd("s", evaluate("caller.#attributes.returnvariable#.authtime") , "January 1 1970 00:00:00")>
			<cfset "caller.#attributes.returnvariable#.UTC2LocalTime" = dateConvert( "utc2local" , utcTime )>
		</cfif>
		<cfcatch></cfcatch>
	</cftry>
	
	<!--- Log activity --->
	<cfif attributes.debug>
		<cflog 
			text="FirePay Response [ DEBUG MODE | #evaluate("caller.#attributes.returnvariable#.transactionTime")# ]: #cfhttp.filecontent#" 
			log="APPLICATION" 
			file="firepay" 
			type="Information" 
			thread="yes" 
			date="yes" 
			time="yes" 
			application="yes">
		<cfset "caller.#attributes.returnvariable#.debug" = attributes>
		<cfdump var="#evaluate("caller.#attributes.returnvariable#")#">
	<cfelse>
		<cflog 
			text="FirePay Response [ #evaluate("caller.#attributes.returnvariable#.transactionTime")# ]: #cfhttp.filecontent#" 
			log="APPLICATION" 
			file="firepay" 
			type="Information" 
			thread="yes" 
			date="yes" 
			time="yes" 
			application="yes">
	</cfif>

	
	<!--- Component error handling --->
	<cfcatch>
	
		<cflog 
			text="#cfcatch.message# " 
			log="APPLICATION" 
			file="firepay" 
			type="Error" 
			thread="yes" 
			date="yes" 
			time="yes" 
			application="yes">
			
			<!--- Forward to an error page if it's defined and not in DEBUG mode --->
			<cfif trim(attributes.onError) NEQ "" AND NOT attributes.debug>
				<cfif attributes.addToken>
					<cflocation url="#attributes.onError#" addtoken="Yes">
				<cfelse>
					<cflocation url="#attributes.onError#" addtoken="No">
				</cfif>
			<cfelse>
				<cfoutput>#cfcatch.message#</cfoutput>
			</cfif>
			
	</cfcatch>
	
</cftry>








