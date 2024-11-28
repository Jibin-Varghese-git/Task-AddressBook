 <cfif NOT structKeyExists(session, "googleInfo")>

                
</cfif>

<cfdump  var="#session.googleInfo#">

<cfset local.structGoogleUser["email"] = session.googleInfo.other.email>
<cfset local.structGoogleUser["userName"] = session.googleInfo.id>
<cfset local.structGoogleUser["fullName"] = session.googleInfo.name>
<cfset local.structGoogleUser["imagePath"] = session.googleInfo.other.picture>

<cfdump  var="#structGoogleUser["imagePath"]#">
<cfset local.result = application.obj.insertGoogleUser(local.structGoogleUser)>