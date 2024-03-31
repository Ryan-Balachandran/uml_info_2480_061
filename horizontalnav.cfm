<nav class="navbar navbar-expand-lg navbar-light bg-light">
     <a class="navbar-brand" href="#">
          <img src="images/rdb.png" alt="Read Dees Books Logo"/>
     </a>

     <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
               aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
     </button>

     <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <cfoutput>
               <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                         <a class="nav-link" href="index.cfm">Home<span class="sr-only">(current)</span></a>
                    </li>
     
                    <li class="nav-item">
                         <a class="nav-link" href="#cgi.scriptName#?p=content&id=B0ECB3CA-CACA-4CFB-90A31BFA98364DED">Store Information</a>
                    </li>
     
                    <li class="nav-item">
                         <a class="nav-link" href="#cgi.scriptName#?p=content&id=CDCE983E-7A40-43C4-866697ECE39F12F0">Highlighted Favorites</a>
                    </li>
                    
                    <li class="nav-item">
                         <a class="nav-link" href="#cgi.scriptName#?p=content&id=68F23A10-A20A-4441-B1116AA526833CED">Events</a>
                    </li>
               </ul>
          </cfoutput>

          <cfoutput>
               <form class="d-flex" action="#cgi.script_name#?p=details" method="post">
                    <input class="form-control me-2" type="search" name="searchme" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">Search</button>
               </form>

               <cfif session.user.isLoggedIn>
                    <ul class="navbar-nav mr-auto">
                         <li class="nav-item">
                              <span class="nav-link">Welcome #session.user.firstname#</span>
                         </li>

                         <li class="nav-item">
                              <a class="nav-link" href="#cgi.script_name#?p=logoff">Logout</a>
                         </li>
                    </ul>
               <cfelse>
                    <ul class="navbar-nav mr-auto">
                         <li class="nav-item">
                              <a class="nav-link" href="#cgi.script_name#?p=login">Login</a>
                         </li>
                    </ul>
               </cfif>

               <!--- <cfif session.user.isAdmin> --->
                    <ul class="navbar-nav mr-auto">
                         <li class="nav-item">
                              <a class="nav-link" href="Management/index.cfm">Management</a>
                         </li>
                    </ul>
               <!--- </cfif> --->
          </cfoutput>
     </div>
</nav>