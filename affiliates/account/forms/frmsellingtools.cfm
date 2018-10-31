<cffile action = "read"
file = "#request.CatalogPath#affiliates#request.bslash#pages#request.bslash#sellingtools.cfm" 
variable = "PageContent"
>

<cfoutput>#pagecontent#</cfoutput>







