<!DOCTYPE html>
<html lang="en">
     <head>
          <meta charset="UTF-8">
          <title>Book Store</title>
          <link href = "https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
               rel = "stylesheet" 
               integrity = "sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" 
               crossorigin = "anonymous">

          <script src = "https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
               integrity = "sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
               crossorigin = "anonymous">
          </script>
     </head>

     <body>
          <cfparam name = "tool" default = "addEdit"/>

          <div class = "container">
               <div id = "navarea">
                    <cfoutput>
                         <a href = "#cgi.script_name#/?tool=addEdit">Book Inventory</a>
                         <a href = "#cgi.script_name#/?tool=createuuids">Create UUIDs</a>
                    </cfoutput>
               </div>

               <div id = "mainarea">
                    <cfinclude template = "#tool#.cfm">
               </div>
          </div>
     </body>
</html>