<cfset local.today = dateTimeFormat(now(),"dd-mm-yy-HH.nn.SS")>
<cfset local.filename = "#session.structUserDetails["fullName"]#" & "#local.today#"> 
<cfdocument  format="PDF" filename="Assets/Docs/#local.filename#.pdf" overwrite="true">  
    <table style="border-spacing:30px" border="2">
        <tr>
            <th>
                <h6 class="contactHeadingSpan" style="">NAME<h6>
            </th>
            <th>
                <h6 class="contactHeadingSpan" style="">EMAIL ID<h6>
            </th>
            <th>
                <h6 class="contactHeadingSpan">PHONE NUMBER<h6>
            </th>
            <th>
                <h6 class="contactHeadingSpan">ROLES<h6>
            </th>
        </tr>

        <!--- Contact Listing --->
        <cfoutput>
        <cfset local.obj = createObject("component", "components.addressBook")>
        <cfset qryReadContact = local.obj.selectContact()>
            <cfloop query="qryReadContact">
                <tr>
                    <td>#qryReadContact.firstname# #qryReadContact.lastname#</td>
                    <td>#qryReadContact.emailId#</td>
                    <td>#qryReadContact.phoneNo#</td>
                    <td>#qryReadContact.roleName#</td>
                </tr>
            </cfloop>
        </cfoutput>
    </table>
</cfdocument >