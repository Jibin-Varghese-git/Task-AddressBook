<cfcomponent>

    <cfset this.datasource="dataSource_addressBook">
    <cfset this.sessionmanagement = "true">

    <cffunction  name="onrequest" returntype="any">
        <cfargument name="requestpage">
        <cfset local.arrayExculdes = ["/AdressBook-Task/Login.cfm","/AdressBook-Task/Signup.cfm"]>
        <cfif arrayContains(local.arrayExculdes,arguments.requestpage)>
            <cfinclude  template="#arguments.requestpage#" >
        <cfelseif structKeyExists(session, "structUserDetails")>
            <cfinclude  template="#arguments.requestpage#">
        <cfelse>
            <cfinclude  template="Login.cfm" >
        </cfif>

    </cffunction>

</cfcomponent>