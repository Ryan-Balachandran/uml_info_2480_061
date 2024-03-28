<cfset genreList = bookstoreFunctions.genreList()/>

<h3>Search By Genre</h3>
<ul class="nav flex-column">
     <cfoutput query = "genreList">
          <li class="nav-item">
               <a class="nav-link" href="#cgi.script_name#?p=details&genre=#genreID#">#genreName#</a>
          </li>
     </cfoutput>
</ul>