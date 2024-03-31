<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Bookstore Home</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" 
              rel="stylesheet" 
              integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" 
              crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
                crossorigin="anonymous">
        </script>
    </head>

    <style>
        header, footer{
            text-align: center;
        }

        header{
            font-size: 2em;
            color: green;
        }
    </style>

    <body>
        <cfparam name = "p" default = "carousel"/>
        <cfset bookstoreFunctions = createObject("bookstore")/>
        <cfinclude template = "stateInfo.cfm"/>

        <div id="wrapper" class="container">
            <header id="topHeader" class="row">
                <cfinclude template = "header.cfm"/>
            </header>

            <div id="horizontalnav" class="row">
                <cfinclude template = "horizontalnav.cfm"/>
            </div>

            <div id="maincontent" class="row">
                <section id="center" class="col-sm-9 order-last">
                    <cfinclude template = "#p#.cfm"/>
                </section>
                
                <section id="left" class="col-sm-3 order-first">
                    <cfinclude template = "genrenav.cfm"/>
               </section>
            </div>

            <footer id="footer" class="row">
                <cfinclude template = "footer.cfm"/>
           </footer>
        </div>
    </body>
</html>
