<cfset stateFunctions = createObject("stateInfo")/>
<!--- <cfset session.clear()/> --->
<cfif !session.keyExists("user")>
     <cfset session.user = stateFunctions.obtainUser()/>
     <!--- <cfset session["user"] = stateFunctions.obtainUser()/> --->
</cfif>

<cfif form.keyExists('firstname')>
     <cfset newAccountResult = bookStoreFunctions.processNewAccount(form)/>
     <!--- <cfset AccountMessage = newAccountResult.message/> --->
</cfif>