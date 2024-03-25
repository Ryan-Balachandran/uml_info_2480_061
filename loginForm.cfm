<cfparam name = "LoginMessage" default = ""/>

<cfoutput>
     <h1>Login to Account</h1>

     <form action="#cgi.script_name#?p=login" method="post">
          <div class="form-floating mb-3">
               <input type="email" id="loginemail" name="loginemail" class="form-control" placeholder="Please enter your email" required/>
               <label for="loginemail">Email</label>
          </div>

          <div class="form-floating mb-3">
               <input type="password" id="loginpassword" name="loginpassword" class="form-control" placeholder="Please enter your password" required/>
               <label for="loginpassword">Password</label>
          </div>
          
          <button id="login" class="btn btn-warning" type="button">Login</button>     
          <input type="submit" id="login" style="display: none"/>     
     </form>

     <div id="LoginMessage" style="font-size: 1.5em;">
          <cfoutput>#LoginMessage#</cfoutput>
     </div>
</cfoutput>