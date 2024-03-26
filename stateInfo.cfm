<cfset stateFunctions = createObject("stateInfo")/>
<!--- <cfset stateFunctions = new stateInfo()/> --->

<cfif url.keyExists("p") && url.p == 'logoff'>
     <cfset session.clear()/>
     <!--- <cfset session.user = stateFunctions.obtainerUser()/> --->
     <cfset p = "carousel"/>
</cfif>

<cfif !session.keyExists("user")>
     <cfset session.user = stateFunctions.obtainUser()/>
     <!--- <cfset session["user"] = stateFunctions.obtainUser()/> --->
</cfif>

<cfif form.keyExists('firstname')>
     <cfset newAccountResult = stateFunctions.processNewAccount(form)/>
     <cfset AccountMessage = newAccountResult.message/>
</cfif>

<cfif form.keyExists("loginpassword")>
     <cfset userData = stateFunctions.logMeIn(form.loginemail, form.loginpassword)/>

     <cfif userData.recordcount == 1>
          <cfset session.user = stateFunctions.obtainUser(
               isLoggedIn = 1,
               firstname = userData.firstname,
               lastname = userData.lastname,
               email = userData.email,
               acctNumber = userData.PersonID,
               isAdmin = userData.isAdmin
          )/>
          <cfset p = "carousel">

     <cfelse>
          <cfset loginMessage = "That login did not work."/>
     </cfif>
</cfif>