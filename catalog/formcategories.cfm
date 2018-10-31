<!---This displays a drop down list of the categories--->

<cfoutput>
<script language="JavaScript">

var navigationUrl = "##";
function jmpPAGE(site) {
window.location.href = "index.cfm?carttoken=#carttoken#&action=ViewCategory&Category=" + site
}
</script>
</cfoutput>

<cfinclude template = "../queries/qrycategories.cfm">
<div class="CategoryJumpBoxDiv"><select Name="Category" onChange="jmpPAGE(this.value)" class="CategoryJumpBox">
<option value="0">SELECT CATEGORY</option>
<cf_CategoryTree Directory="/"
    ShowCurrentView="Yes"
    SelectedItem=""
    Datasource="#request.dsn#"
    FirstIndent="2">
</select></div>



