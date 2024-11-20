<cfcomponent>

<!--- SignUp --->
    <cffunction  name="signUpInput" returntype="string">
        <cfargument  name="structUserInfo" type="struct" required="true">

        <cfquery name="qryCheckUserExist">
            SELECT COUNT(userName) AS userCount ,
                  COUNT(emailId) AS emailCount 
            FROM userInfo
            WHERE userName = <cfqueryparam value="#structUserInfo["userName"]#" cfsqltype=cf_sql_varchar>
            OR emailId = <cfqueryparam value="#structUserInfo["emailId"]#" cfsqltype=cf_sql_varchar>;
        </cfquery>

        <cfif qryCheckUserExist.userCount GT 0>
            <cfset local.result = "User Name Already Exist">
        <cfelseif  qryCheckUserExist.emailCount GT 0>
            <cfset local.result = "Email Id Already Exist">
        <cfelse>
            <cfset structUserInfo["password"] = hash(structUserInfo["password"] , "SHA-256" , "UTF-8")>

            <cfquery name="qryUserSignUp">
                INSERT INTO userInfo 
                (fullName,emailId,userName,password,userImage)
                VALUES (
                <cfqueryparam value="#structUserInfo["fullName"]#" cfsqltype=cf_sql_varchar>,
                <cfqueryparam value="#structUserInfo["emailId"]#" cfsqltype=cf_sql_varchar>,
                <cfqueryparam value="#structUserInfo["userName"]#" cfsqltype=cf_sql_varchar>,
                <cfqueryparam value="#structUserInfo["password"]#" cfsqltype=cf_sql_varchar>,
                <cfqueryparam value="#structUserInfo["imagePath"]#" cfsqltype=cf_sql_varchar>
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
                   userImage 
            FROM userInfo 
            WHERE emailId = <cfqueryparam value="#arguments.userName#" cfsqltype="cf_sql_varchar">
            AND  password = <cfqueryparam value="#local.password#" cfsqltype="cf_sql_varchar">
        </cfquery>

        <cfif qryUserLogin.recordCount>
            <cfset session.structUserDetails["userId"] = qryUserLogin.userId>
            <cfset session.structUserDetails["fullName"] = qryUserLogin.fullName>
            <cfset session.structUserDetails["userName"] = qryUserLogin.userName>
            <cfset session.structUserDetails["userImage"] = qryUserLogin.userImage>
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
    <cffunction  name="addContact" returntype="any">
        <cfargument  name="structContactinfo" type="struct">

        <cfquery name="qryContactCheck">
            SELECT COUNT(phoneNo) AS phnCount 
            FROM contactTable 
            WHERE phoneNo=<cfqueryparam value="#arguments.structContactinfo["phoneNo"]#" cfsqltype=cf_sql_varchar>
            AND   _createdBy=<cfqueryparam value="#session.structUserDetails["userId"]#" cfsqltype=cf_sql_varchar>
        </cfquery>

        <cfif qryContactCheck.phnCount GT 0>
            <cfset local.result = "Already Exists">
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
                    state,
                    country,
                    pincode,
                    emailId,
                    phoneNo,
                    _createdBy,
                    _createdOn,
                    _updatedBy,
                    _updatedOn)
                VALUES (<cfqueryparam value="#arguments.structContactinfo["title"]#" cfsqltype=cf_sql_varchar>,
                        <cfqueryparam value="#arguments.structContactinfo["firstName"]#" cfsqltype=cf_sql_varchar>,
                        <cfqueryparam value="#arguments.structContactinfo["lastName"]#" cfsqltype=cf_sql_varchar>,
                        <cfqueryparam value="#arguments.structContactinfo["gender"]#" cfsqltype=cf_sql_varchar>,
                        <cfqueryparam value="#arguments.structContactinfo["dateOfBirth"]#" cfsqltype=cf_sql_varchar>,
                        <cfqueryparam value="#arguments.structContactinfo["contactImage"]#" cfsqltype=cf_sql_varchar>,
                        <cfqueryparam value="#arguments.structContactinfo["address"]#" cfsqltype=cf_sql_varchar>,
                        <cfqueryparam value="#arguments.structContactinfo["street"]#" cfsqltype=cf_sql_varchar>,
                        <cfqueryparam value="#arguments.structContactinfo["district"]#" cfsqltype=cf_sql_varchar>,
                        <cfqueryparam value="#arguments.structContactinfo["state"]#" cfsqltype=cf_sql_varchar>,
                        <cfqueryparam value="#arguments.structContactinfo["country"]#" cfsqltype=cf_sql_varchar>,
                        <cfqueryparam value="#arguments.structContactinfo["pincode"]#" cfsqltype=cf_sql_varchar>,
                        <cfqueryparam value="#arguments.structContactinfo["emailId"]#" cfsqltype=cf_sql_varchar>,
                        <cfqueryparam value="#arguments.structContactinfo["phoneNo"]#" cfsqltype=cf_sql_varchar>,
                        <cfqueryparam value="#session.structUserDetails["userId"]#" cfsqltype=cf_sql_varchar>,
                        <cfqueryparam value="#local.date#" cfsqltype=cf_sql_date>,
                        <cfqueryparam value="#session.structUserDetails["userId"]#" cfsqltype=cf_sql_varchar>,
                        <cfqueryparam value="#local.date#" cfsqltype=cf_sql_date>
                )
            </cfquery>

            <cfset local.result = "Data Added">
        </cfif>
       <cfreturn local.result>
       <cflocation  url="Home.cfm" addToken="no">
    </cffunction>

<!--- Read Contact --->
    <cffunction  name="readContact" returntype="any">
        
        <cfquery name="qryReadContact">
            SELECT contactId
                    ,title
                    ,firstName
                    ,lastName
                    ,gender
                    ,dob
                    ,contactImage
                    ,address
                    ,street
                    ,district
                    ,state
                    ,country
                    ,pincode
                    ,emailId
                    ,phoneNo
            FROM  contactTable 
            WHERE _createdBy =<cfqueryparam value="#session.structUserDetails["userId"]#" cfsqltype=cf_sql_varchar>
        </cfquery>
        <cfreturn qryReadContact>
    </cffunction>

<!---   Delete Contact   --->
    <cffunction  name="deleteContact" returntype="any" access="remote">
        <cfargument  name="conactId" type="string">

        <cfquery name="qryDeleteContact">
            DELETE FROM contactTable
            WHERE contactId=<cfqueryparam value="#arguments.contactId#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfreturn true>
    </cffunction>

<!---   View Contact   --->
    <cffunction  name="viewContact" returnformat="json" access="remote">
        <cfargument  name="contactId" type="string">

        <cfquery name="qrySelectContact">
            SELECT  title
                    ,firstName
                    ,lastName
                    ,gender
                    ,dob
                    ,contactImage
                    ,address
                    ,street
                    ,district
                    ,state
                    ,country
                    ,pincode
                    ,emailId
                    ,phoneNo
            FROM  contactTable 
            WHERE contactId =<cfqueryparam value="#arguments.contactId#" cfsqltype=cf_sql_varchar>
        </cfquery>

        <cfset local.structContactUser["title"] = qrySelectContact.title>
        <cfset local.structContactUser["firstName"] = qrySelectContact.firstName>
        <cfset local.structContactUser["lastName"] = qrySelectContact.lastName>
        <cfset local.structContactUser["gender"] = qrySelectContact.gender>
        <cfset local.structContactUser["dob"] = dateFormat(qrySelectContact.dob , "dd-mm-yyyy")>
        <cfset local.structContactUser["contactImage"] = qrySelectContact.contactImage>
        <cfset local.structContactUser["address"] = qrySelectContact.address>
        <cfset local.structContactUser["street"] = qrySelectContact.street>
        <cfset local.structContactUser["district"] = qrySelectContact.district>
        <cfset local.structContactUser["state"] = qrySelectContact.state>
        <cfset local.structContactUser["country"] = qrySelectContact.country>
        <cfset local.structContactUser["pincode"] = qrySelectContact.pincode>
        <cfset local.structContactUser["emailId"] = qrySelectContact.emailId>
        <cfset local.structContactUser["phoneNo"] = qrySelectContact.phoneNo>
        
        <cfreturn local.structContactUser>
    </cffunction>

<!---   Select Contact   --->
     <cffunction  name="selectContact" returnformat="json" access="remote">
        
        <cfquery name="qrySelectContact">
            SELECT   contactId
                    ,title
                    ,firstName
                    ,lastName
                    ,gender
                    ,dob
                    ,contactImage
                    ,address
                    ,street
                    ,district
                    ,state
                    ,country
                    ,pincode
                    ,emailId
                    ,phoneNo
            FROM  contactTable 
            WHERE contactId=<cfqueryparam value="#arguments.contactId#" cfsqltype=cf_sql_varchar>
        </cfquery>

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
        <cfreturn local.structContactUser>
    </cffunction>

<!--- Edit Contact --->
  
    <cffunction  name="editContact" returntype="any">
        <cfargument  name="structContactinfo" type="struct">

        <cfquery name="qryCheck">
            SELECT COUNT(phoneNo) AS phnCount 
            FROM contactTable 
            WHERE phoneNo = <cfqueryparam value='#arguments.structContactinfo["phoneNo"]#' cfsqltype=cf_sql_varchar>
            AND    contactId != <cfqueryparam value='#session.structUserDetails["contactId"]#' cfsqltype=cf_sql_varchar>
        </cfquery>

        <cfif qryCheck.phnCount GT 0>
            <cfset local.result = "Already Exists">
        <cfelse>
            <cfset local.date = dateFormat(now(),"dd-mm-yyyy")>
        </cfif>

            <cfquery name="qryAddContact">
                UPDATE contactTable 
                SET
                    title = <cfqueryparam value="#arguments.structContactinfo["title"]#" cfsqltype=cf_sql_varchar>,
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
                WHERE   contactId = <cfqueryparam value="#arguments.structContactinfo["contactId"]#" cfsqltype=cf_sql_varchar>
               
            </cfquery>
    </cffunction>

</cfcomponent>