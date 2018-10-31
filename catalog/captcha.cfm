<cfsilent>
<!---create the array for CAPTCHA--->
<cfset arrValidChars = ListToArray("A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z," & "2,3,4,5,6,7,8,9" ) />

<!---shuffle the array--->
<cfset CreateObject("java", "java.util.Collections").Shuffle(arrValidChars) />

<!---grap the first 5 characters of the array--->
<cfset strCaptcha = (arrValidChars[ 1 ] & arrValidChars[ 2 ] & arrValidChars[ 3 ] & arrValidChars[ 4 ] & arrValidChars[ 5 ]) />

<cfset captcha_check = Encrypt(strCaptcha, "bots-aint-sexy", "CFMX_COMPAT", "HEX") />
</cfsilent>

<cfimage action="captcha" height="75" width="363" text="#strCaptcha#" difficulty="#qryContactSettings.captcha_difficulty#" fonts="verdana,arial,times new roman,courier" fontsize="28" />



