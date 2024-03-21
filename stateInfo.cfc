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
               isLoggedIn = arguments.isLoggedIn,
               firstname  : arguments.firstname,
               lastname   : arguments.lastname,
               email      : arguments.email,
               acctNumber : arguments.acctNumber
          };
     }

     function emailisUnique(required string email) {
          var qs = new query(datasource = application.dsource);
          qs.setSql("Select * from People where email = :email");
          qs.addparam(
               name  = "email",
               value = arguments.email
          );

          return qs.execute().getResult().recordcount == 0;
     }

     function processNewAccount(formData) {
          if (emailisUnique(formData.email)) {
               var newid = createuuids();

               if(addPassword(newid, formData.password)) {
                    addAccount(newid, formData.title, formData.firstname, formData.lastname, formData.email, formData.isAdmin);
                    return {
                         success: true,
                         message: "Account Made. Go Login!"
                    }
               } else {
                    return {
                         success: false,
                         message: "We encountered a problem! Please resubmit"
                    }
               }
          } else {
               return {
                    success: false,
                    message: "That email is already in our system. Please login."
               }
          }
     }

     function addPassword(id, password) {
          try {
               var qs = new query(datasource = application.dsource);
               qs.setSql("Insert INTO Passwords (personid, password) VALUES (:personid, :password)");
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
          numberic isAdmin = 0
     ) {
          var qs = new query(datasource = application.dsource);
          qs.setSql("Insert INTO People (personID, Title, Firstname, Lastname, Email, isAdmin) 
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
}