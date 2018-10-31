<!---Main configuration--->
<cfset request.storename= 'cfshopkart'><!---Unique storename is required per installation--->
<CFSET request.dsn = 'cfhowto_cfsk'><!---Coldfusion DSN for database--->
<cfset request.dbtype = 'mysql'> <!---valid options are 'mysql' or 'msaccess'--->
<cfset request.seedstring = '$cfshopkart551'><!---IMPORTANT: Change this to something only you will know.  It is used to encrypt sensitive data.  Do NOT change it once it is set.--->
<cfset request.secretkey = 'cfshopkart55123'><!---this is used only for store owners who are allowed to and need to store credit card information.  The secret key is needed to retrieve the data--->
<cfset request.bslash = '\'><!---set this so that if you are using windows '\', if you are using linux use '/'.  It is used when referencing files/folders--->
<cfset request.absolutepath = "/"><!---if it's in a subfolder, make sure you set this to /yourfolder/--->
<cfset request.homeURL = "http://cfskdemo.cfhowto.com/"><!---IMPORTANT: must end with a "/": This is the full URL to your store---->
<cfset request.secureURL = "http://cfskdemo.cfhowto.com/"><!---IMPORTANT: must end with a "/": This is the URL for using ssl (https)---->
<cfset request.downloadspath = "D:\home\cfhowto.com\downloads\"> <!--- full path where electronic products are stored, should be outside your web root, but accessible to Coldfusion.--->

<!---variables below are auto configed, but you can change these if you need to--->
<cfset request.AdminPath = '#request.absolutepath#admin/'><!---absolute path or full url to admin--->
<cfset request.catalogpath = "D:\home\cfhowto.com\subdomains\cfskdemo\"><!---path on server to store.  End with "\" (or "/" if Linux server). Leave default if this works.--->
<cfset request.imagespath = "#request.catalogpath#photos#request.bslash#"><!---IMPORTANT: must end with a "\" or "/": This is the full path to your product images---->
<cfset request.securepath = "#request.catalogpath#"><!---IMPORTANT:  end path with "\" (or "/" if Linux), usually same as catalogpath.--->

<cfset request.folder_accesslist = "docs,docs_backup,docs_deleted,images,media,photos"><!---Determines which folders are visible in the filemanage.---->
<cfset request.debug = "On"> <!---On/off=When on: errors displayed on screen and overrides index.cfm check; IMPORTANT:  disable on live sites to prevent url hacking attempts.  If off, friendly error page is shown.--->

<!---extra optional variables that can be used for custom coding, left here for other uses--->
<!---Can be used if you want to put company info at the bottom of a website.--->
<cfset request.powered_by = "Your Company">
<cfset request.powered_by_link = "##">
<cfset request.powered_by_logo = ""> <!---image file if you want to use an image file--->

<!---Site information variables you can use if you need to.  You don't have to set these, I just lef them here to save me the time of putting them back in when I set up certain websites.--->
<cfset request.sitedomain = ''>
<cfset request.sitefullname = ''>
<cfset request.sitecode = ''>

<!---You should leave this alone unless you are told to change it.  This is where updates come from, where the documentation is, and where error reports are sent.--->
<cfset request.supporturl = "http://support.cfhowto.com/">