<cfcomponent>

    <cfset this.datasource="dataSource_addressBook">
    <cfset this.sessionmanagement = "true">
    <cfset application.obj = createObject("component", "components.addressBook")>
    <cfset this.ormEnabled = true>
    <cfset this.ormSettings = {cflocation="fetchUserOrm",dbcreate ="update"}>

    <cffunction  name="onrequest" returntype="any">
        <cfargument name="requestpage">
        <cfset local.arrayExculdes = ["/Login.cfm","/Signup.cfm","/googleDummy.cfm","/birthdayFunction.cfm"]>
        <cfif arrayContains(local.arrayExculdes,arguments.requestpage)>
            <cfinclude  template="#arguments.requestpage#" >
        <cfelseif structKeyExists(session, "structUserDetails")>
            <cfinclude  template="#arguments.requestpage#">
        <cfelse>
            <cfinclude  template="Login.cfm">
        </cfif>

    </cffunction>

</cfcomponent>