 <cfif NOT structKeyExists(session, "googleInfo")>

                <cfoauth  Type="google"
                    clientid="354798451421-2q1g8fd966em4pog7qp9g3cufpikff4p.apps.googleusercontent.com"  
                    secretkey="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"  
                    result="session.googleInfo"  
                    redirecturi="http://addressbook.org/googleLogin.cfm"
                    scope="email"> 
</cfif>

<!--- <cfdump  var="#session.googleInfo#"> --->

<cfset local.structGoogleUser["email"] = session.googleInfo.other.email>
<cfset local.structGoogleUser["userName"] = session.googleInfo.id>
<cfset local.structGoogleUser["fullName"] = session.googleInfo.name>
<cfset local.structGoogleUser["imagePath"] = session.googleInfo.other.picture>

<!--- <cfdump  var="#structGoogleUser["imagePath"]#"> --->
<cfset local.result = application.obj.insertGoogleUser(local.structGoogleUser)>