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
    <cffunction  name="logout" returntype="any">
        <cfset structClear(session)>
        <cflocation  url="Login.cfm" addToken="no">
        <cfreturn true>
    </cffunction>

</cfcomponent>