<cfparam name = "AccountMessage" default = ""/>

<script type="text/javascript">
     function validateNewAccount() {
          let originalPassword = document.getElementById('password').value;
          let confirmPassword = document.getElementById('confirmPassword').value;

          // originalPassword.length
          if(originalPassword !== '' && originalPassword === confirmPassword) {
               document.getElementById('submitNewAccountForm').click();
               document.getElementById('AccountMessage').innerHTML = "";
          } else {
               document.getElementById('AccountMessage').innerHTML = "Please make sure that you have entered your password correctly";
          }
     }
</script>

<cfoutput>
     <h1>Create New Account</h1>

     <form action="#cgi.script_name#?p=login" method="post">
          <div class="form-floating mb-3">
               <input type="text" id="title" name="title" class="form-control" placeholder="Please enter your title"/>
               <label for="title">Title</label>
          </div>

          <div class="form-floating mb-3">
               <input type="text" id="firstname" name="firstname" class="form-control" placeholder="Please enter your first name" required/>
               <label for="firstname">First Name</label>
          </div>

          <div class="form-floating mb-3">
               <input type="text" id="lastname" name="lastname" class="form-control" placeholder="Please enter your last name" required/>
               <label for="lastname">Last Name</label>
          </div>

          <div class="form-floating mb-3">
               <input type="email" id="email" name="email" class="form-control" placeholder="Please enter your email" required/>
               <label for="email">Email</label>
          </div>

          <div class="form-floating mb-3">
               <input type="password" id="password" name="password" class="form-control" placeholder="Please enter your password" required/>
               <label for="password">Password</label>
          </div>

          <div class="form-floating mb-3">
               <input type="password" id="confirmPassword" class="form-control" placeholder="Please enter your password again" required/>
               <label for="confirmPassword">Confirm Password</label>
          </div>

          <div>
               <button type="button" id="newAccountButton" class="btn btn-warning" onclick="validateNewAccount()" style="width: 100%">Make New Account</button>     
               <input type="submit" id="submitNewAccountForm" style="display: none"/>   
          </div>  
     </form>

     <div id="AccountMessage" style="font-size: 1.5em;">
          <cfoutput>#AccountMessage#</cfoutput>
     </div>
</cfoutput>