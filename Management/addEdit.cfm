<cftry>
     <cfset addEditFunctions = createObject("addEdit")/>
     <cfset addEditFunctions.processForms(form)/>

     <div class="row">
          <div id="main" class="col-9">
               <cfoutput>#mainForm()#</cfoutput>
          </div>

          <div id="leftgutter" class="col-lg-3 order-first">
               <cfoutput>#sideNav()#</cfoutput>
          </div>
     </div>

     <cfcatch type = "any">
          <cfoutput>
               #cfcatch.Message#
          </cfoutput>
     </cfcatch>
</cftry>


<cffunction name = "mainForm">
     <cfoutput>
          <form action = "#cgi.script_name#?tool=addEdit" method = "post">
               <div class = "form-floating mb-3">
                    <input type="text" id="isbn13" name="isbn13" class="form-control" value="" placeholder="Please enter the ISBN-13 of the book"/>
                    <label for="isbn13">ISBN 13:</label>
               </div>
               
               <div class = "form-floating mb-3">
                    <input type="text" id="title" name="title" class="form-control" value="" placeholder="Please enter the Book Title"/>
                    <label for="title">Book Title:</label>
               </div>

               <div class = "form-floating mb-3">
                    <input type="number" id="year" name="year" class="form-control" value="" placeholder="Please enter the Year of Publication of the book"/>
                    <label for="year">Year of Publication:</label>
               </div>

               <div class = "form-floating mb-3">
                    <input type="number" id="weight" name="weight" step=".1" class="form-control" value="" placeholder="Please enter the weight of the book"/>
                    <label for="weight">Book Weight (oz):</label>
               </div>

               <div class = "form-floating mb-3">
                    <input type="text" id="isbn" name="isbn" class="form-control" value="" placeholder="Please enter the ISBN-10 of the book"/>
                    <label for="isbn">ISBN 10:</label>
               </div>

               <div class = "form-floating mb-3">
                    <input type="number" id="pages" name="pages" class="form-control" value="" placeholder="Please enter the number of Pages in the book"/>
                    <label for="pages">Number of Pages:</label>
               </div>

               <div class = "form-floating mb-3">
                    <input type="text" id="binding" name="binding" class="form-control" value="" placeholder="Please enter the type of book binding"/>
                    <label for="binding">Book Binding:</label>
               </div>

               <div class = "form-floating mb-3">
                    <input type="text" id="language" name="language" class="form-control" value="" placeholder="Please enter the language of the book"/>
                    <label for="language">Language:</label>
               </div>

               <button type="submit" class="btn btn-primary" style="width: 100%">Add Book</button>
          </form>
     </cfoutput>
</cffunction>


<cffunction name = "sideNav">
     <cfset allbooks = addEditFunctions.sideNavBooks()>
     <div>
          Book List
     </div>

     <cfoutput>
          <ul class="nav flex-column">
               <li class="nav-item">
                    <a href="#cgi.script_name#?tool=addEdit&book=new" class="nav-link">New Book</a>
               </li>
               
               <cfloop query="allbooks">
                    <li class="nav-item">
                         <a class="nav-link" href="#cgi.script_name#?tool=addEdit&book=#isbn13#">#trim(title)#</a>
                    </li>
               </cfloop>
          </ul>
     </cfoutput>
</cffunction>