<cfcomponent>

<!--- SignUp --->
    <cffunction  name="signUpInput" returntype="string">
        <cfargument  name="structUserInfo" type="struct" required="true">

        <cfquery name="qryCheckUserExist">
           SELECT COUNT(userName) AS userCount
                ,COUNT(emailId) AS emailCount
            FROM userInfo
            WHERE userName = < cfqueryparam value = "#structUserInfo["userName"]#" cfsqltype = cf_sql_varchar >
                OR emailId = < cfqueryparam value = "#structUserInfo["emailId"]#" cfsqltype = cf_sql_varchar >;
        </cfquery>

        <cfif qryCheckUserExist.userCount GT 0>
            <cfset local.result = "User Name Already Exist">
        <cfelseif  qryCheckUserExist.emailCount GT 0>
            <cfset local.result = "Email Id Already Exist">
        <cfelse>
            <cfset structUserInfo["password"] = hash(structUserInfo["password"] , "SHA-256" , "UTF-8")>

            <cfquery name="qryUserSignUp">
                INSERT INTO userInfo (
                            fullName,
                            emailId,
                            userName,
                            password,
                            userImage
                        )
                VALUES (
                    < cfqueryparam value = "#structUserInfo["fullName"]#" cfsqltype = cf_sql_varchar >
                    ,< cfqueryparam value = "#structUserInfo["emailId"]#" cfsqltype = cf_sql_varchar >
                    ,< cfqueryparam value = "#structUserInfo["userName"]#" cfsqltype = cf_sql_varchar >
                    ,< cfqueryparam value = "#structUserInfo["password"]#" cfsqltype = cf_sql_varchar >
                    ,< cfqueryparam value = "#structUserInfo["imagePath"]#" cfsqltype = cf_sql_varchar >
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

        <cfquery name="qryUserLogin">
            SELECT userId,
                   fullName,
                   userName,
                   userImage,
                   emailId
            FROM userInfo 
            WHERE emailId = <cfqueryparam value="#arguments.userName#" cfsqltype="cf_sql_varchar">
                AND  password = <cfqueryparam value="#local.password#" cfsqltype="cf_sql_varchar">
        </cfquery>

        <cfif qryUserLogin.recordCount>
            <cfset session.structUserDetails["userId"] = qryUserLogin.userId>
            <cfset session.structUserDetails["fullName"] = qryUserLogin.fullName>
            <cfset session.structUserDetails["userName"] = qryUserLogin.userName>
            <cfset session.structUserDetails["userImage"] = qryUserLogin.userImage>
            <cfset session.structUserDetails["emailId"] = qryUserLogin.emailId>
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

        <cfquery name="qryPhnCheck">
            SELECT COUNT(phoneNo) AS 
                    phnCount
            FROM   contactTable
            WHERE phoneNo = <cfqueryparam value = "#arguments.structContactinfo["phoneNo"]#" cfsqltype = cf_sql_varchar >
                AND _createdby = <cfqueryparam value = "#session.structUserDetails["userId"]#" cfsqltype = cf_sql_varchar >
        </cfquery>

        <cfquery name="qryEmailCheck">
            SELECT COUNT(emailId) AS emailCount
            FROM contactTable
            WHERE emailId = <cfqueryparam value = "#arguments.structContactinfo["emailId"]#" cfsqltype = cf_sql_varchar >
                AND _createdby = <cfqueryparam value = "#session.structUserDetails["userId"]#" cfsqltype = cf_sql_varchar >
        </cfquery>

        <cfif qryPhnCheck.phnCount GT 0>
            <cfset local.result = "error">
        <cfelseif  qryEmailCheck.emailCount GT 0>
            <cfset local.result = "error1">
        <cfelse>
            <cfif arguments.structContactinfo["emailId"] == session.structUserDetails["emailId"]>
                <cfset local.result = "error2">
            <cfelse>
                <cfset local.date = dateFormat(now(),"dd-mm-yyyy")>
                <cfquery name="qryAddContact">
                   INSERT INTO contactTable (
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
                                _createdOn
                            )
                    VALUES (
                        <cfqueryparam value = "#arguments.structContactinfo["title"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structContactinfo[ "firstName"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structContactinfo["lastName"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structContactinfo["gender"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structContactinfo["dateOfBirth"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structContactinfo["contactImage"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structContactinfo["address"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structContactinfo["street"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structContactinfo["district"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structContactinfo["STATE"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structContactinfo["country"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structContactinfo["pincode"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structContactinfo["emailId"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#arguments.structContactinfo["phoneNo"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#session.structUserDetails["userId"]#" cfsqltype = cf_sql_varchar>,
                        <cfqueryparam value = "#local.date#" cfsqltype = cf_sql_date>
                        )
                </cfquery>
                <cfquery name="qryselectId">
                    SELECT contactId 
                    FROM contactTable
                    WHERE emailId = <cfqueryparam value = "#arguments.structContactinfo["emailId"]#" cfsqltype = cf_sql_varchar>
                    AND   _createdBy = <cfqueryparam value = "#session.structUserDetails["userId"]#" cfsqltype = cf_sql_varchar>
                </cfquery>
                <cfset local.contactId = qryselectId.contactId>
                <cfloop list="#arguments.structContactinfo["roleSelect"]#" item="item" delimiters=",">
                    <cfquery>
                        INSERT INTO userRole
                        VALUES ( <cfqueryparam value = "#item#" cfsqltype = cf_sql_varchar>,
                                 <cfqueryparam value = "#local.contactId#" cfsqltype = cf_sql_varchar>
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
            <cfset local.colName = "contactId">
            <cfset local.colValue = arguments.contactId>            
        <cfelse>
            <cfset local.colName = "_createdBy">
            <cfset local.colValue = session.structUserDetails["userId"]>
        </cfif>

        <cfquery name="qrySelectContact">
            SELECT contactId,
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
                    phoneNo
            FROM contactTable
            WHERE #local.colName# = < cfqueryparam value = "#local.colValue#" cfsqltype = cf_sql_varchar >
        </cfquery>

    <cfif structKeyExists(arguments,"contactId")>
        <cfset local.qrySelectRole = selectRoleById(arguments.contactId)>

        <cfset local.structContactUser["contactId"] = qrySelectContact.contactId>
        <cfset local.structContactUser["title"] = qrySelectContact.title>
        <cfset local.structContactUser["firstName"] = qrySelectContact.firstName>
        <cfset local.structContactUser["lastName"] = qrySelectContact.lastName>
        <cfset local.structContactUser["gender"] = qrySelectContact.gender>
        <cfset local.structContactUser["dob"] = dateFormat(qrySelectContact.dob , "yyyy-mm-dd")>
        <cfset local.structContactUser["contactImage"] = qrySelectContact.contactImage>
        <cfset local.structContactUser["address"] = qrySelectContact.address>
        <cfset local.structContactUser["street"] = qrySelectContact.street>
        <cfset local.structContactUser["district"] = qrySelectContact.district>
        <cfset local.structContactUser["state"] = qrySelectContact.state>
        <cfset local.structContactUser["country"] = qrySelectContact.country>
        <cfset local.structContactUser["pincode"] = qrySelectContact.pincode>
        <cfset local.structContactUser["emailId"] = qrySelectContact.emailId>
        <cfset local.structContactUser["phoneNo"] = qrySelectContact.phoneNo>
        <cfset local.structContactUser["roleSelect"]="">
        <cfset local.structContactUser["roleValues"] = []>
        <cfloop query="local.qrySelectRole">
            <cfset local.structContactUser["roleSelect"]=local.structContactUser["roleSelect"] & " " & local.qrySelectRole.roleName>
            <cfset arrayAppend(local.structContactUser["roleValues"], local.qrySelectRole.roleId)>
        </cfloop>
        
        <cfset local.result = local.structContactUser>
    <cfelse>
        <cfset local.result = qrySelectContact>
    </cfif>
    <cfreturn local.result>
    </cffunction>

<!--- Select Role By Id      --->
    <cffunction  name="selectRoleById">
        <cfargument  name="contactId">

         <cfquery name="local.qrySelectRole">
            SELECT userRole.roleId, roleTable.roleName
            FROM userRole
            INNER JOIN roleTable
            ON userRole.roleId = roleTable.roleId
            WHERE contactId = < cfqueryparam value = "#arguments.contactId#" cfsqltype = cf_sql_varchar >
        </cfquery>

        <cfreturn local.qrySelectRole>
    </cffunction>

<!---   Delete Contact   --->

    <cffunction  name="deleteContact" returntype="any" access="remote">
        <cfargument  name="conactId" type="string">

        <cfquery name="qrydeleteRoles">
            DELETE FROM userRole
            WHERE contactId = <cfqueryparam value="#arguments.contactId#" cfsqltype=cf_sql_varchar>
        </cfquery>

        <cfquery name="qryDeleteContact">
            DELETE FROM contactTable
            WHERE contactId=<cfqueryparam value="#arguments.contactId#" cfsqltype="cf_sql_varchar">
        </cfquery>

        <cfreturn true>
    </cffunction>
<!--- Edit Contact --->
  
    <cffunction  name="editContact" returntype="any">
        <cfargument  name="structContactinfo" type="struct">

         <cfquery name="qryPhnCheck">
           SELECT COUNT(phoneNo) AS phnCount
            FROM contactTable
            WHERE phoneNo = <cfqueryparam value = "#arguments.structContactinfo["phoneNo"]#" cfsqltype = cf_sql_varchar >
               AND _createdby = <cfqueryparam value = "#session.structUserDetails["userId"]#" cfsqltype = cf_sql_varchar >
               AND contactId != <cfqueryparam value="#arguments.structContactinfo["addContactHidden"]#" cfsqltype=cf_sql_varchar>
        </cfquery>

        <cfquery name="qryEmailCheck">
           SELECT COUNT(emailId) AS emailCount
            FROM contactTable
            WHERE emailId = <cfqueryparam value = "#arguments.structContactinfo["emailId"]#" cfsqltype = cf_sql_varchar >
               AND _createdby = <cfqueryparam value = "#session.structUserDetails["userId"]#" cfsqltype = cf_sql_varchar >
               AND contactId != <cfqueryparam value="#arguments.structContactinfo["addContactHidden"]#" cfsqltype=cf_sql_varchar>
        </cfquery>
        
       
        <cfif qryPhnCheck.phnCount GT 0>
            <cfset local.result = "error">
        <cfelseif  qryEmailCheck.emailCount GT 0>
            <cfset local.result = "error1">
        <cfelseif arguments.structContactinfo["emailId"] == session.structUserDetails["emailId"]>
            <cfset local.result = "error2">
        <cfelse>
            <cfset local.date = dateFormat(now(),"dd-mm-yyyy")>

            <cfquery name="qryEditContact">
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
            
            <cfquery name="qrydeleteRoles">
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

            <cfset local.result = "ok">
        </cfif>
        <cfreturn local.result>
    </cffunction>

<!---   Read data for spreadsheet   --->
    <cffunction  name="spreadsheetDownload" returntype="any" access="remote">

        <cfset local.qryReadContact = selectContactRoles()>
        <cfset local.fileName = createUUID() & ".xlsx" >
        <cfset  local.theFile= expandPath("../Assets/Docs/"&local.fileName)>
        <cfset local.theSheet = SpreadsheetNew(true)>
        <cfset spreadsheetAddRow(local.theSheet,"First Name,Last Name,Gender,Date of Birth,Address,Street,District,State,Country,Pincode,emailId,Phone Number,Roles")>
        <cfset spreadsheetAddRows(local.theSheet, local.qryReadContact)>
        <cfset spreadsheetFormatRow(local.theSheet, {bold=true,alignment='center'}, 1)>
        <cfspreadsheet action="write" filename="#local.theFile#" name="local.theSheet" sheetname="mock_data" overwrite=true>
        <cfreturn true>
    </cffunction>
    
<!--- Insert  Google User--->
    <cffunction  name="insertGoogleUser">
        <cfargument  name="structGoogleUser" type="struct">

        <cfquery name="qryCheckEmail">
            SELECT COUNT(emailId) 
            AS emailCount 
            FROM userInfo 
            WHERE emailId = <cfqueryparam value="#arguments.structGoogleUser["email"]#" cfsqltype="cf_sql_varchar"> 
        </cfquery>

        <cfif qryCheckEmail.emailCount EQ 1>

            <cfquery name="qrySelectUser">
                SELECT userId,
                        fullName,
                        userName,
                        userImage,
                        emailId
                FROM userInfo
                WHERE emailId = < cfqueryparam value = "#arguments.structGoogleUser["email"]#" cfsqltype = "cf_sql_varchar" >
            </cfquery>

            <cfset session.structUserDetails["userId"] = qrySelectUser.userId>
            <cfset session.structUserDetails["fullName"] = qrySelectUser.fullName>
            <cfset session.structUserDetails["userName"] = qrySelectUser.userName>
            <cfset session.structUserDetails["userImage"] = qrySelectUser.userImage>
            <cfset session.structUserDetails["emailId"] = qrySelectUser.emailId>
            <cflocation  url="Home.cfm" addToken="no">

        <cfelse>
                <cfquery name="qryUserSignUp">
                    INSERT INTO userInfo (
                                fullName,
                                emailId,
                                userName,
                                userImage,
                                loginType
                            )
                    VALUES (
                        < cfqueryparam value = "#arguments.structGoogleUser["fullName"]#" cfsqltype = cf_sql_varchar >,
                        < cfqueryparam value = "#arguments.structGoogleUser["email"]#" cfsqltype = cf_sql_varchar >,
                        < cfqueryparam value = "#arguments.structGoogleUser["userName"]#" cfsqltype = cf_sql_varchar >,
                        < cfqueryparam value = "#arguments.structGoogleUser["imagePath"]#" cfsqltype = cf_sql_varchar >,
                        < cfqueryparam value = "SSO" cfsqltype = cf_sql_varchar >
                        )
            </cfquery>

            <cfquery name="qrySelectUser">
                SELECT userId,
                       fullName,
                       userName,
                       userImage,
                       emailId 
                FROM userInfo
                WHERE emailId=<cfqueryparam value="#arguments.structGoogleUser["email"]#" cfsqltype="cf_sql_varchar">
            </cfquery>

            <cfset session.structUserDetails["userId"] = qrySelectUser.userId>
            <cfset session.structUserDetails["fullName"] = qrySelectUser.fullName>
            <cfset session.structUserDetails["userName"] = qrySelectUser.userName>
            <cfset session.structUserDetails["userImage"] = qrySelectUser.userImage>
            <cfset session.structUserDetails["emailId"] = qrySelectUser.emailId>
            <cflocation  url="Home.cfm" addToken="no">

        </cfif>
    </cffunction>
<!---  Birthday Wish    --->
     <cffunction  name="birthdayWish"> 
          
        <cfquery name="qryBday">
            SELECT firstName,
                   lastName,
                   dob,
                   emailId 
            FROM contactTable
        </cfquery>

        <cfset local.today = dateFormat(now(),"dd-mm")>
        
        <cfloop query="qryBday">
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


<!--- Select Contact Details and roles --->
    <cffunction  name="selectContactRoles">

        <cfquery name="local.qrySelectContactRoles">
            select	firstName,
                    lastName,
                    gender,
                    dob,
                    address,
                    street,
                    district,
                    STATE,
                    country,
                    pincode,
                    emailId,
                    phoneNo,
                    (
                    SELECT STRING_AGG(roleName,',')
                    FROM userRole
                    INNER JOIN roleTable
                    ON userRole.roleId = roleTable.roleId
                    WHERE userRole.contactId = contactTable.contactId 
                    )
                    AS roles
            FROM contactTable
        </cfquery>
        <cfreturn local.qrySelectContactRoles>
    </cffunction>

</cfcomponent>