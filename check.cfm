<html>
    <head>

    </head>
    <body>
        <cfhtmltopdf>
            <cfoutput>
                <table style="border-spacing:30px">
                    <tr>
                        <th></th>
                        <th>
                            <h6 class="contactHeadingSpan" style="">NAME<h6>
                        </th>
                        <th>
                            <h6 class="contactHeadingSpan" style="">EMAIL ID<h6>
                        </th>
                        <th>
                            <h6 class="contactHeadingSpan">PHONE NUMBER<h6>
                        </th>
                    </tr>
            
                    <!--- Contact --->
                    <cfset local.obj = createObject("component", "components.addressBook")>
                    <cfset local.qryReadContact = local.obj.readContact()>

                        <cfloop query="local.qryReadContact">
                        
                            <tr>
                                <td>
                                    <img src="#local.qryReadContact.contactImage#" class="" alt="No image found" width="50" height="50">
                                </td>
                                    <td>#local.qryReadContact.firstname# #local.qryReadContact.lastname#</td>
                                    <td>#local.qryReadContact.emailId#</td>
                                    <td>#local.qryReadContact.phoneNo#</td>
                            </tr>
                            
                        </cfloop>
        
                </table>
            </cfoutput>
        </cfhtmltopdf>
    </body>
</html>

<!--- destination="./Assets/Docs/contact.pdf" overwrite="yes" --->


