 <cfif NOT structKeyExists(session, "googleInfo")>

                <cfoauth  Type="google"
                    clientid="354798451421-2q1g8fd966em4pog7qp9g3cufpikff4p.apps.googleusercontent.com"  
                    secretkey="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"  
                    result="session.googleInfo"  
                    redirecturi="http://addressbook.org/googleLogin.cfm"
                    scope="email"> 
</cfif>


<cfset structGoogleUser["email"] = session.googleInfo.other.email>
<cfset structGoogleUser["userName"] = session.googleInfo.id>
<cfset structGoogleUser["fullName"] = session.googleInfo.name>
<cfset structGoogleUser["imagePath"] = session.googleInfo.other.picture>
 
<cfset result = application.obj.insertGoogleUser(structGoogleUser)>