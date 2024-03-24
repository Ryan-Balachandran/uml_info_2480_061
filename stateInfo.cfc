/***
 * Controller for the state of the website
 * 
 * @author Ryan Balachandran
 * @date 3/15/2024
**/
component {
     function obtainUser(
          isLoggedIn = false,
          firstname  = "",
          lastname   = "",
          email      = "",
          acctNumber = ""
     ) {
          return {
               isLoggedIn : arguments.isLoggedIn,
               firstname  : arguments.firstname,
               lastname   : arguments.lastname,
               email      : arguments.email,
               acctNumber : arguments.acctNumber
          };
     }

     function emailisUnique(required string email) {
          var qs = new query(datasource = application.dsource);
          qs.setSql("Select * FROM People WHERE Email = :email");
          qs.addparam(
               name  = "email",
               value = arguments.email
          );

          return qs.execute().getResult().recordcount == 0;
     }

     function processNewAccount(formData) {
          var result = {
               success: false,
               message: ""
          }

          if (emailisUnique(formData.email)) {
               var newid = createuuid();

               if(addPassword(newid, formData.password)) {
                    addAccount(newid, formData.title, formData.firstname, formData.lastname, formData.email);
                    result.success = true;
                    result.message = "Account Made. Go Login!";
               } else {
                    result.message = "We encountered a problem! Please resubmit";
               }
          } else {
               result.message = "That email is already in our system. Please login.";
          }
          return result;
     }

     function addPassword(id, password) {
          try {
               var qs = new query(datasource = application.dsource);
               qs.setSql("Insert INTO Passwords (personid, password) 
                         VALUES (:personid, :password)");
               qs.addparam(
                    name  = "personid",
                    value = arguments.id
               );

               qs.addparam(
                    name  = "password",
                    value = hash(arguments.password, "SHA-256")
               );
               qs.execute();
               return true;
          }
          catch (ary err) {
               return false;
          }
     }

     function addAccount(
          required string id, 
                   string title, 
          required string firstname, 
          required string lastname, 
          required string email, 
                   numeric isAdmin = 0
     ) {
          var qs = new query(datasource = application.dsource);
          qs.setSql("Insert INTO People (personID, Title, [First Name], [Last Name], Email, isAdmin) 
                    VALUES (:personid, :title, :firstname, :lastname, :email, :isAdmin)");
          qs.addparam(
               name  = "personid",
               value = arguments.id
          );

          qs.addparam(
               name  = "title",
               value = arguments.title
          );

          qs.addparam(
               name  = "firstname",
               value = arguments.firstname
          );

          qs.addparam(
               name  = "lastname",
               value = arguments.lastname
          );

          qs.addparam(
               name  = "email",
               value = arguments.email
          );

          qs.addparam(
               name  = "isAdmin",
               value = arguments.isAdmin
          );
          qs.execute();
     }

     function logMeIn(username, password) {
          var qs = new query(datasource = application.dsource);
          qs.setSql("
               Select * FROM People
               INNER JOIN Passwords ON People.personID = Passwords.personid
               WHERE Email = :email AND password = :password"
          );
          qs.addparam(
               name  = "email",
               value = arguments.username
          );

          qs.addparam(
               name  = "password",
               value = hash(form.loginpassword,"SHA-256")
          );
          return qs.execute().getResult();
     }
}