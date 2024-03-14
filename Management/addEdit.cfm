<cftry>
     <cfparam name="book" default=""/>
     <cfparam name="qterm" default=""/>

     <cfset addEditFunctions = createObject("addEdit")/>
     <cfset addEditFunctions.processForms(form)/>

     <div class="row">
          <div id="main" class="col-9">
               <cfif book neq "">
                    <cfoutput>#mainForm()#</cfoutput>
               <cfelse>
                    <cfoutput>Please select a book from the list to edit</cfoutput>
               </cfif>

               <!--- <cfif book.len() gt 0>
                    <cfoutput>#mainForm()#</cfoutput>
               </cfif> ---> 
          </div>

          <div id="leftgutter" class="col-lg-3 order-first">
               <cfoutput>#sideNav()#</cfoutput>
          </div>
     </div>

     <cfcatch type="any">
          <cfoutput>
               #cfcatch#
          </cfoutput>
     </cfcatch>
</cftry>


<cffunction name="mainForm">
     <cfset thisBookDetails = addEditFunctions.bookDetails(book)/>
     <cfset allPublishers = addEditFunctions.allPublishers()/>

     <cfoutput>
          <form action="#cgi.script_name#?tool=addEdit&qterm=#qterm#" method="post" enctype="multipart/form-data">
               <div class="form-floating mb-3">
                    <input type="text" id="isbn13" name="isbn13" class="form-control" value="#thisBookDetails.isbn13[1]#" placeholder="Please enter the ISBN-13 of the book"/>
                    <label for="isbn13">ISBN 13:</label>
               </div>
               
               <div class="form-floating mb-3">
                    <input type="text" id="title" name="title" class="form-control" value="#thisBookDetails.title[1]#" placeholder="Please enter the Book Title"/>
                    <label for="title">Book Title:</label>
               </div>

               <div class="form-floating mb-3">
                    <input type="number" id="year" name="year" class="form-control" value="#thisBookDetails.year[1]#" placeholder="Please enter the Year of Publication of the book"/>
                    <label for="year">Year of Publication:</label>
               </div>

               <div class="form-floating mb-3">
                    <input type="number" id="weight" name="weight" step=".1" class="form-control" value="#thisBookDetails.weight[1]#" placeholder="Please enter the weight of the book"/>
                    <label for="weight">Book Weight (oz):</label>
               </div>

               <div class="form-floating mb-3">
                    <input type="text" id="isbn" name="isbn" class="form-control" value="#thisBookDetails.isbn[1]#" placeholder="Please enter the ISBN-10 of the book"/>
                    <label for="isbn">ISBN 10:</label>
               </div>

               <div class="form-floating mb-3">
                    <input type="number" id="pages" name="pages" class="form-control" value="#thisBookDetails.pages[1]#" placeholder="Please enter the number of Pages in the book"/>
                    <label for="pages">Number of Pages:</label>
               </div>

               <div class="form-floating mb-3">
                    <input type="text" id="binding" name="binding" class="form-control" value="#thisBookDetails.binding[1]#" placeholder="Please enter the type of book binding"/>
                    <label for="binding">Book Binding:</label>
               </div>

               <div class="form-floating mb-3">
                    <input type="text" id="language" name="language" class="form-control" value="#thisBookDetails.language[1]#" placeholder="Please enter the language of the book"/>
                    <label for="language">Language:</label>
               </div>

               <div class="form-floating mb-3">
                    <select class="form-select" id="publisher" name="publisher" aria-label="Publisher Select Control">
                         <option></option>
                         <cfloop query="allPublishers">
                              <option value="#PublisherID#" #PublisherID eq thisBookDetails.PublisherID ? "selected" : ""# >#name#</option>
                         </cfloop>
                    </select>
                    <label for="publisher">Publisher:</label>
               </div>

               <div class="row">
                    <div class="col">
                         <label for="uploadImage">Upload Cover</label>
                         <div class="input-group mb-3">
                              <input type="file" id="uploadImage" name="uploadImage" class="form-control"/>
                              <input type="hidden" name="name" value "#trim(thisBookDetails.image[1])#"/>
                         </div>
                    </div>

                    <div class="col">
                         <cfif thisBookDetails.image[1].len() gt 0> 
                              <img src="../images/#trim(thisBookDetails.image[1])#" style="width:200px"/>
                              <br/>
                         </cfif>
                    </div>
               </div>

               <div class="form-floating mb-3">
                    <div>
                         <label for="description">Description</label>
                    </div>

                    <textarea id="description" name="description">
                         <cfoutput>#thisBookDetails.description[1]#</cfoutput>
                    </textarea>
                    <script>
                         ClassicEditor
                              .create(document.querySelector('##description'))
                              .catch(error => {console.dir(error)});
                    </script>
               </div>

               <button type="submit" class="btn btn-primary" style="width: 100%; margin: 10px 0 10px 0">Add Book</button>
          </form>
     </cfoutput>
</cffunction>


<cffunction name="sideNav">
     <cfset allbooks = addEditFunctions.sideNavBooks(qterm)/>

     <div>
          Book List
     </div>

     <cfoutput>
          #findBookForm()#
          <ul class="nav flex-column">
               <li class="nav-item">
                    <a href="#cgi.script_name#?tool=addEdit&book=new" class="nav-link">Add A New Book</a>
               </li>

               <cfif qterm.len() == 0>
                    No Search Term Entered
               <cfelseif allbooks.recordcount == 0>
                    No Results Found
               <cfelse>
                    <cfloop query="allbooks">
                         <li class="nav-item">
                              <a class="nav-link" href="#cgi.script_name#?tool=addEdit&book=#isbn13#&qterm=#qterm#">#title#</a>
                         </li>
                    </cfloop>
               </cfif>
          </ul>
     </cfoutput>
</cffunction>

<cffunction name="findBookForm">
     <cfoutput>
          <form action="#cgi.script_name#?tool=#tool#" method="post">
               <div class="form-floating mb-3">
                    <input type="text" id="qterm" name="qterm" class="form-control" value="#qterm#" placeholder="Enter a search term to find a book to edit"/>
                    <label for="qterm">Search Inventory</label>
               </div>
          </form>
     </cfoutput>
</cffunction>