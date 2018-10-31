<cfinclude template = '../queries/qrycompanyinfo.cfm'>
<cfoutput query = "qryCompanyInfo"> 
  <h4 align = "Center">Contact Information</h4>
  <p align = "Center"><strong>#CompanyName#<br>
    </strong> #Address# #Apt#<br>
    #city#, #State#&nbsp; #Zip#<br>
    #PhoneNumber1#<br>
    #PhoneNumber2#</p>
  <p align = "Center"><a href="mailto:%20#EmailAddress#">#EmailAddress#</a></p>
  </center>
  </cfoutput>



