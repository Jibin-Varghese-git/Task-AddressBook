<cfcomponent>

<!--- SignUp --->
    <cffunction  name="signUpInput" returntype="string">
        <cfargument  name="structUserInfo" type="struct" required="true">

        <cfquery name="local.qryCheckUserNameExist">
            SELECT 
                COUNT(userName) AS userCount
            FROM 
                userInfo
            WHERE 
                userName = <cfqueryparam value = "#structUserInfo["userName"]#" cfsqltype = cf_sql_varchar>
        </cfquery>

        <cfquery name="local.qryCheckEmailExist">
            SELECT 
                COUNT(emailId) AS emailCount
            FROM 
                userInfo
            WHERE  
                emailId = <cfqueryparam value = "#structUserInfo["emailId"]#" cfsqltype = cf_sql_varchar>;
        </cfquery>

        <cfif local.qryCheckUserNameExist.userCount GT 0>
            <cfset local.result = "User Name Already Exist">
        <cfelseif  local.qryCheckEmailExist.emailCount GT 0>
            <cfset local.result = "Email Id Already Exist">
        <cfelse>
            <cfset structUserInfo["password"] = hash(structUserInfo["password"] , "SHA-256" , "UTF-8")>

            <cfquery name="local.qryUserSignUp">
                INSERT INTO 
                    userInfo 
                        (
                        fullName,
                        emailId,
                        userName,
                        password,
                        userImage
                        )
                VALUES 
                    (
                    <cfqueryparam value = "#structUserInfo["fullName"]#" cfsqltype = cf_sql_varchar>
                    ,<cfqueryparam value = "#structUserInfo["emailId"]#" cfsqltype = cf_sql_varchar>
                    ,<cfqueryparam value = "#structUserInfo["userName"]#" cfsqltype = cf_sql_varchar>
                    ,<cfqueryparam value = "#structUserInfo["password"]#" cfsqltype = cf_sql_varchar>
                    ,<cfqueryparam value = "#structUserInfo["imagePath"]#" cfsqltype = cf_sql_varchar>
                    )
            </cfquery>

            <cfset local.result = "Data Added Successfully">
        </cfif>
        <cfreturn local.result>
    </cffunction>

<!--- user login --->
    <cffunction  name="userLogin" returntype="any">
        <cfargument  name="userName" type="string">
        <cfargument  name="password" type="string">

        <cfset local.password = hash(arguments.password , "SHA-256" , "UTF-8")>

        <cfquery name="local.qryUserLogin">
            SELECT 
                userId,
               fullName,
               userName,
               userImage,
               emailId
            FROM 
                userInfo 
            WHERE 
                emailId = <cfqueryparam value="#arguments.userName#" cfsqltype="cf_sql_varchar">
                AND  
                password = <cfqueryparam value="#local.password#" cfsqltype="cf_sql_varchar">
        </cfquery>

        <cfif local.qryUserLogin.recordCount>
            <cfset session.structUserDetails["userId"] = local.qryUserLogin.userId>
            <cfset session.structUserDetails["fullName"] = local.qryUserLogin.fullName>
            <cfset session.structUserDetails["userName"] = local.qryUserLogin.userName>
            <cfset session.structUserDetails["userImage"] = local.qryUserLogin.userImage>
            <cfset session.structUserDetails["emailId"] = local.qryUserLogin.emailId>
            <cfset local.result = true>
        <cfelse>
            <cfset local.result = false>
        </cfif>
        <cfreturn local.result>
    </cffunction>

<!--- User Logout --->
    <cffunction  name="logout" returntype="any" access="remote">
        <cfset structClear(session)>
        <cfreturn true>
    </cffunction>

<!---   Add Contact   --->
    <cffunction  name="addContact" returntype="string">
        <cfargument  name="structContactinfo" type="struct">
        <cfset local.actveValue = 1>

        <cfquery name="local.qryPhnCheck">
            SELECT 
                COUNT(phoneNo) AS 
                phnCount
            FROM   
                contactTable
            WHERE 
                phoneNo = <cfqueryparam value = "#arguments.structContactinfo["phoneNo"]#" cfsqltype = cf_sql_varchar>
                AND _createdby = <cfqueryparam value = "#session.structUserDetails["userId"]#" cfsqltype = cf_sql_varchar>
                AND active = <cfqueryparam value = "#local.actveValue#" cfsqltype = cf_sql_integer>
        </cfquery>

        <cfquery name="local.qryEmailCheck">
            SELECT 
                COUNT(emailId) AS emailCount
            FROM   
                contactTable
            WHERE 
                emailId = <cfqueryparam value = "#arguments.structContactinfo["emailId"]#" cfsqltype = cf_sql_varchar>
                AND _createdby = <cfqueryparam value = "#session.structUserDetails["userId"]#" cfsqltype = cf_sql_varchar>
                AND active = <cfqueryparam value = "#local.actveValue#" cfsqltype = cf_sql_integer>
        </cfquery>

        <cfif local.qryPhnCheck.phnCount GT 0>
            <cfset local.result = "error">
        <cfelseif  local.qryEmailCheck.emailCount GT 0>
            <cfset local.result = "error1">
        <cfelse>
            <cfif arguments.structContactinfo["emailId"] == session.structUserDetails["emailId"]>
                <cfset local.result = "error2">
            <cfelse>
                <cfset local.activeValue = 1>
                <cfset local.date = dateFormat(now(),"dd-mm-yyyy")>
                <cfquery name="local.qryAddContact" result="local.addContactResult">
                    INSERT INTO 
                        contactTable (
                            title,
                            firstName,
                            lastName,
                            gender,
                            dob,
                            contactImage,
                            address,
                            street,
                            district,
                            STATE,
                            country,
                            pincode,
                            emailId,
                            phoneNo,
                            _createdBy,
                            _createdOn,
                            active
                            )
                    VALUES (
                        <cfqueryparam value = "#arguments.structContactinfo["title"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structContactinfo[ "firstName"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structContactinfo["lastName"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structContactinfo["gender"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structContactinfo["dateOfBirth"]#" cfsqltype = cf_sql_date>,
                        <cfqueryparam value = "#arguments.structContactinfo["contactImage"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structContactinfo["address"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structContactinfo["street"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structContactinfo["district"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structContactinfo["STATE"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structContactinfo["country"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structContactinfo["pincode"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structContactinfo["emailId"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structContactinfo["phoneNo"]#" cfsqltype = cf_sql_bigint>,
                        <cfqueryparam value = "#session.structUserDetails["userId"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#local.date#" cfsqltype = cf_sql_date>,
                        <cfqueryparam value = "#local.activeValue#" cfsqltype = cf_sql_integer>
                        )
                </cfquery>
              
                <cfloop list="#arguments.structContactinfo["roleSelect"]#" item="item" delimiters=",">
                    
                    <cfquery>
                        INSERT INTO 
                            userRole
                        VALUES ( 
                            <cfqueryparam value = "#item#" cfsqltype = cf_sql_integer>,
                            <cfqueryparam value = "#local.addContactResult.generatedkey#" cfsqltype = cf_sql_integer>
                            )
                    </cfquery>

                </cfloop>
                <cfset local.result = "Data Added">
            </cfif>
        </cfif>
        
        <cfreturn local.result>
       
    </cffunction>


<!---   Select Contacts   --->
    <cffunction  name="selectContact" returnformat="json" access="remote">
        <cfargument  name="contactId" type="string">

        <cfif structKeyExists(arguments,"contactId")>
            <cfset local.colName = "ct.contactId">
            <cfset local.colValue = arguments.contactId>            
        <cfelse>
            <cfset local.colName = "ct._createdBy">
            <cfset local.colValue = session.structUserDetails["userId"]>
        </cfif>
        <cfset local.activeValue = 1>
        <cfquery name="local.qrySelectContact">
            SELECT    
                ct.contactId,
                ct.title,
                ct.firstName,
                ct.lastName,
                ct.gender,
                ct.dob,
                ct.contactImage,
                ct.address,
                ct.street,
                ct.district,
                ct.STATE,
                ct.country,
                ct.pincode,
                ct.emailId,
                ct.phoneNo,
                STRING_AGG(rt.roleName, ',') AS roleName,
                STRING_AGG(ur.roleId, ',') AS roleId
            FROM 
                contactTable AS ct
            LEFT JOIN 
                userRole AS ur ON ct.contactId = ur.contactId
            LEFT JOIN 
                roleTable AS rt ON rt.roleId = ur.roleId
            WHERE 
                #local.colName# = <cfqueryparam value="#local.colValue#" cfsqltype="cf_sql_varchar">
                AND 
                active = <cfqueryparam value="#local.activeValue#" cfsqltype="cf_sql_varchar">
            GROUP BY 
                ct.contactId, 
                ct.title,
                ct.firstName,
                ct.lastName,
                ct.gender,
                ct.dob,
                ct.contactImage,
                ct.address,
                ct.street,
                ct.district,
                ct.STATE,
                ct.country,
                ct.pincode,
                ct.emailId,
                ct.phoneNo
            </cfquery>


    <cfif structKeyExists(arguments,"contactId")>

        <cfset local.structContactUser["contactId"] = local.qrySelectContact.contactId>
        <cfset local.structContactUser["title"] = local.qrySelectContact.title>
        <cfset local.structContactUser["firstName"] = local.qrySelectContact.firstName>
        <cfset local.structContactUser["lastName"] = local.qrySelectContact.lastName>
        <cfset local.structContactUser["gender"] = local.qrySelectContact.gender>
        <cfset local.structContactUser["dob"] = dateFormat(local.qrySelectContact.dob , "yyyy-mm-dd")>
        <cfset local.structContactUser["contactImage"] = local.qrySelectContact.contactImage>
        <cfset local.structContactUser["address"] = local.qrySelectContact.address>
        <cfset local.structContactUser["street"] = local.qrySelectContact.street>
        <cfset local.structContactUser["district"] = local.qrySelectContact.district>
        <cfset local.structContactUser["state"] = local.qrySelectContact.state>
        <cfset local.structContactUser["country"] = local.qrySelectContact.country>
        <cfset local.structContactUser["pincode"] = local.qrySelectContact.pincode>
        <cfset local.structContactUser["emailId"] = local.qrySelectContact.emailId>
        <cfset local.structContactUser["phoneNo"] = local.qrySelectContact.phoneNo>
        <cfset local.structContactUser["roleName"] = local.qrySelectContact.roleName>
        <cfset local.structContactUser["roleValues"] = local.qrySelectContact.roleId>
        
        <cfset local.result = local.structContactUser>
    <cfelse>
        <cfset local.result = local.qrySelectContact>
    </cfif>
    <cfreturn local.result>
    </cffunction>



<!---   Delete Contact   --->

    <cffunction  name="deleteContact" returntype="any" access="remote">
        <cfargument  name="conactId" type="string">
        <cfset local.activeValue = 0>

        <cfquery name="qrydeleteRoles">
            UPDATE 
                contactTable
            SET 
                active = <cfqueryparam value="#local.activeValue#" cfsqltype=cf_sql_varchar>
            WHERE 
                contactId = <cfqueryparam value="#arguments.contactId#" cfsqltype=cf_sql_varchar>
        </cfquery>

        <cfreturn true>
    </cffunction>
<!--- Edit Contact --->
  
    <cffunction  name="editContact" returntype="any">
        <cfargument  name="structContactinfo" type="struct">
        <cfset local.activeValue = 1>

        <cfquery name="local.qryPhnCheck">
            SELECT 
                COUNT(phoneNo) AS phnCount
            FROM 
                contactTable
            WHERE 
                phoneNo = <cfqueryparam value = "#arguments.structContactinfo["phoneNo"]#" cfsqltype = cf_sql_varchar>
               AND _createdby = <cfqueryparam value = "#session.structUserDetails["userId"]#" cfsqltype = cf_sql_varchar>
               AND contactId != <cfqueryparam value="#arguments.structContactinfo["addContactHidden"]#" cfsqltype=cf_sql_varchar>
               AND active = <cfqueryparam value = "#local.actveValue#" cfsqltype = cf_sql_integer>
        </cfquery>

        <cfquery name="local.qryEmailCheck">
            SELECT 
                COUNT(emailId) AS emailCount
            FROM 
                contactTable
            WHERE 
                emailId = <cfqueryparam value = "#arguments.structContactinfo["emailId"]#" cfsqltype = cf_sql_varchar>
               AND _createdby = <cfqueryparam value = "#session.structUserDetails["userId"]#" cfsqltype = cf_sql_varchar>
               AND contactId != <cfqueryparam value="#arguments.structContactinfo["addContactHidden"]#" cfsqltype=cf_sql_varchar>
               AND active = <cfqueryparam value = "#local.actveValue#" cfsqltype = cf_sql_integer>
        </cfquery>
        
       
        <cfif local.qryPhnCheck.phnCount GT 0>
            <cfset local.result = "error">
        <cfelseif  local.qryEmailCheck.emailCount GT 0>
            <cfset local.result = "error1">
        <cfelseif arguments.structContactinfo["emailId"] == session.structUserDetails["emailId"]>
            <cfset local.result = "error2">
        <cfelse>
            <cfset local.date = dateFormat(now(),"dd-mm-yyyy")>

            <cfquery name="local.qryEditContact">
                UPDATE contactTable 
                SET title = <cfqueryparam value="#arguments.structContactinfo["title"]#" cfsqltype=cf_sql_varchar>,
                    firstName = <cfqueryparam value="#arguments.structContactinfo["firstName"]#" cfsqltype=cf_sql_varchar>,
                    lastName = <cfqueryparam value="#arguments.structContactinfo["lastName"]#" cfsqltype=cf_sql_varchar>,
                    gender = <cfqueryparam value="#arguments.structContactinfo["gender"]#" cfsqltype=cf_sql_varchar>,
                    dob = <cfqueryparam value="#arguments.structContactinfo["dateOfBirth"]#" cfsqltype=cf_sql_varchar>,
                    contactImage = <cfqueryparam value="#arguments.structContactinfo["contactImage"]#" cfsqltype=cf_sql_varchar>,
                    address = <cfqueryparam value="#arguments.structContactinfo["address"]#" cfsqltype=cf_sql_varchar>,
                    street = <cfqueryparam value="#arguments.structContactinfo["street"]#" cfsqltype=cf_sql_varchar>,
                    district = <cfqueryparam value="#arguments.structContactinfo["district"]#" cfsqltype=cf_sql_varchar>,
                    state = <cfqueryparam value="#arguments.structContactinfo["state"]#" cfsqltype=cf_sql_varchar>,
                    country = <cfqueryparam value="#arguments.structContactinfo["country"]#" cfsqltype=cf_sql_varchar>,
                    pincode = <cfqueryparam value="#arguments.structContactinfo["pincode"]#" cfsqltype=cf_sql_varchar>,
                    emailId = <cfqueryparam value="#arguments.structContactinfo["emailId"]#" cfsqltype=cf_sql_varchar>,
                    phoneNo = <cfqueryparam value="#arguments.structContactinfo["phoneNo"]#" cfsqltype=cf_sql_varchar>,
                    _updatedBy = <cfqueryparam value="#session.structUserDetails["userId"]#" cfsqltype=cf_sql_varchar>,
                    _updatedOn = <cfqueryparam value="#local.date#" cfsqltype=cf_sql_date>
                WHERE   contactId = <cfqueryparam value="#arguments.structContactinfo["addContactHidden"]#" cfsqltype=cf_sql_varchar>
            </cfquery>
            
            <cfquery name="local.qrydeleteRoles">
                DELETE FROM userRole
                WHERE contactId = <cfqueryparam value="#arguments.structContactinfo["addContactHidden"]#" cfsqltype=cf_sql_varchar>
            </cfquery>
        
            <cfloop list="#arguments.structContactinfo["roleSelect"]#" item="item" delimiters=",">
                <cfquery>
                    INSERT INTO userRole
                    VALUES ( <cfqueryparam value = "#item#" cfsqltype = cf_sql_varchar>,
                             <cfqueryparam value="#arguments.structContactinfo["addContactHidden"]#" cfsqltype=cf_sql_varchar>
                           )
                </cfquery>
            </cfloop>

            <cfset local.result = "Updated">
        </cfif>
        <cfreturn local.result>
    </cffunction>

<!---    spreadsheet   --->
    <cffunction  name="spreadsheetDownload" returntype="any" access="remote" returnformat="plain">

        <cfset local.qryReadContact = selectContact()>
        <cfset queryDeleteColumn(local.qryReadContact, "contactId")>
        <cfset queryDeleteColumn(local.qryReadContact, "title")>
        <cfset queryDeleteColumn(local.qryReadContact, "contactImage")>
        <cfset queryDeleteColumn(local.qryReadContact, "roleId")>
        <cfset local.today = dateTimeFormat(now(),"dd-mm-yy-HH.nn.SS")>
        <cfset local.filename = "#session.structUserDetails["fullName"]#" & "#local.today#"> 
        <cfset  local.theFile= "../Assets/Docs/#local.filename#.xls">
        <cfset local.theSheet = SpreadsheetNew(true)>
        <cfset spreadsheetAddRow(local.theSheet,"First Name,Last Name,Gender,Date of Birth,Address,Street,District,State,Country,Pincode,emailId,Phone Number,Roles")>
        <cfset spreadsheetAddRows(local.theSheet, local.qryReadContact)>
        <cfset spreadsheetFormatRow(local.theSheet, {bold=true,alignment='center'}, 1)>
        <cfspreadsheet action="write" filename="#local.theFile#" name="local.theSheet" sheetname="mock_data" overwrite=true>
        <cfreturn local.theFile>
    </cffunction>
    
<!--- Insert  Google User--->
    <cffunction  name="insertGoogleUser">
        <cfargument  name="structGoogleUser" type="struct">

        <cfquery name="local.qryCheckEmail">
            SELECT COUNT(emailId) 
            AS emailCount 
            FROM userInfo 
            WHERE emailId = <cfqueryparam value="#arguments.structGoogleUser["email"]#" cfsqltype="cf_sql_varchar"> 
        </cfquery>

        <cfif local.qryCheckEmail.emailCount EQ 1>

            <cfquery name="local.qrySelectUser">
                SELECT userId,
                        fullName,
                        userName,
                        userImage,
                        emailId
                FROM userInfo
                WHERE emailId = <cfqueryparam value = "#arguments.structGoogleUser["email"]#" cfsqltype = "cf_sql_varchar">
            </cfquery>

            <cfset session.structUserDetails["userId"] = local.qrySelectUser.userId>
            <cfset session.structUserDetails["fullName"] = local.qrySelectUser.fullName>
            <cfset session.structUserDetails["userName"] = local.qrySelectUser.userName>
            <cfset session.structUserDetails["userImage"] = local.qrySelectUser.userImage>
            <cfset session.structUserDetails["emailId"] = local.qrySelectUser.emailId>
            <cflocation  url="Home.cfm" addToken="no">

        <cfelse>
                <cfquery name="local.qryUserSignUp">
                    INSERT INTO userInfo (
                                fullName,
                                emailId,
                                userName,
                                userImage,
                                loginType
                            )
                    VALUES (
                        <cfqueryparam value = "#arguments.structGoogleUser["fullName"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structGoogleUser["email"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structGoogleUser["userName"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structGoogleUser["imagePath"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "SSO" cfsqltype = cf_sql_varchar>
                        )
            </cfquery>

            <cfquery name="local.qrySelectUser">
                SELECT userId,
                       fullName,
                       userName,
                       userImage,
                       emailId 
                FROM userInfo
                WHERE emailId=<cfqueryparam value="#arguments.structGoogleUser["email"]#" cfsqltype="cf_sql_varchar">
            </cfquery>

            <cfset session.structUserDetails["userId"] = local.qrySelectUser.userId>
            <cfset session.structUserDetails["fullName"] = local.qrySelectUser.fullName>
            <cfset session.structUserDetails["userName"] = local.qrySelectUser.userName>
            <cfset session.structUserDetails["userImage"] = local.qrySelectUser.userImage>
            <cfset session.structUserDetails["emailId"] = local.qrySelectUser.emailId>
            <cflocation  url="Home.cfm" addToken="no">

        </cfif>
    </cffunction>
<!---  Birthday Wish    ---> 
     <cffunction  name="birthdayWish"> 
          
        <cfquery name="local.qryBday">
            SELECT firstName,
                   lastName,
                   dob,
                   emailId 
            FROM contactTable
        </cfquery>

        <cfset local.today = dateFormat(now(),"dd-mm")>
        
        <cfloop query="local.qryBday">
            <cfset local.userDob = dateFormat(qryBday.dob,"dd-mm")>
            <cfdump  var="#local.today#">
            <cfdump  var="#local.userDob#">
            <cfif local.today EQ local.userDob> 
                <cfmail  from="jibinvarghese05101999@gmail.com"  subject="Happy Birthday"  to="#qryBday.emailId#">
                    Happy Birthday #local.firstName# #local.lastName#
                    <cfmailparam file="./Assets/Images/happyBday.jpg" disposition="attachment">
                </cfmail>
                <cfset local.result =" Email sent ">
            
            <cfelse>
            <cfset local.result =" Email not sent ">

            </cfif>
        </cfloop>
        <cfreturn local.result> 
    </cffunction> 

<!---  Select Role    --->
    <cffunction  name="selectRole">

        <cfquery name="local.qrySelectRole">
            SELECT roleId,
                   roleName
            FROM roleTable
        </cfquery>
        <cfreturn local.qrySelectRole>

    </cffunction>

<!--- PDF  --->
    <cffunction  name="pdfConvert" returnformat="plain" access="remote">
        <cfinclude  template="../pdfFile.cfm">
        <cfset local.fileUrl = "../Assets/Docs/#local.filename#.pdf">
        <cfreturn local.fileUrl>
    </cffunction>


</cfcomponent>