<cftry>
     <cfparam name = "id" default = ""/>
     <cfset contentFunctions = createObject("content")/>
     
     <cfif form.keyExists("Title")>
          <cfset contentFunctions.processForms(form)/>
     </cfif>
     
     <cfset allArticles = contentFunctions.allArticles()/>
     
     <div class="row">
          <div id="main" class="col-9">
               <cfif id.len()>
                    <cfoutput>#mainForm()#</cfoutput>
               </cfif>
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

<cffunction name = "mainForm">
     <cfset thisArticle = contentFunctions.obtainArticle(id) />

     <cfoutput>
          <form action="#cgi.script_name#?tool=content" method="post">
               <input type="hidden" name="id" value="#thisArticle.contentid#"/>

               <div class="form-floating mb-3">
                    <input type="text" id="title" name="title" class="form-control" value="#thisArticle.title#" placeholder="Please enter the title of the article"/>
                    <label for="title">Article Title:</label>
               </div>
               
               <div class="form-floating mb-3">
                    <textarea id="description" name="description" class="form-control">
                         <cfoutput>#thisArticle.description#</cfoutput>
                    </textarea>

                    <script>
                         ClassicEditor
                              .create(document.querySelector('##description'))
                              .catch(error => {console.dir(error)});
                    </script>
               </div>

               <input type="submit" class="btn btn-primary" value="Save Article">
          </form>
     </cfoutput>
</cffunction>

<cffunction name = "sideNav">
     <ul class="nav flex-column">
          <cfoutput>
              <li class="nav-link">
                  <a href="#cgi.script_name#?tool=content&id=new">New Content</a>
              </li>
          </cfoutput>
  
          <cfoutput query="allArticles">
              <li class="nav-link">
                  <a href="#cgi.script_name#?tool=content&id=#contentid#">#trim(Title)#</a>
              </li>
          </cfoutput>
      </ul>
</cffunction>