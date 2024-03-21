<cfparam name = "searchme" default = "">

<cfoutput>
     <cfset bookInfo = bookstoreFunctions.obtainSearchResults(searchme)/>

     <cfif bookInfo.recordcount == 0>
          #noResults()#
     <cfelseif bookInfo.recordcount == 1>
          #oneResult()#
     <cfelse>
          #manyResults()#
     </cfif>
</cfoutput>


<cffunction name="noResults">
     There were no results to be found. Please try again.
</cffunction>

<cffunction name="oneResult">
     <cfoutput>
          <div class="row">
               <img src="images/#bookInfo.image[1]#" style="float: left; width:250px; height:250px"/>
               <div class="col">
                    <span>Title: #bookInfo.title[1]#</span><br/>
                    <span>ISBN-13: #bookInfo.isbn13[1]#</span><br/>
                    <span>Publisher: #bookInfo.name[1]#</span><br/>
                    <span>Year: #bookInfo.year[1]#</span><br/>
                    <span>Pages: #bookInfo.pages[1]#</span>
               </div>
          </div>
     </cfoutput>
</cffunction>

<cffunction name="manyResults">
     There were more than one result, here is the list.

     <ol class="nav flex-column">
          <cfoutput query = "bookInfo">
               <li class="nav-item">
                    <a class="nav-link" href="#cgi.script_name#?p=details&searchme=#trim(isbn13)#">#trim(title)#</a>
               </li>
          </cfoutput>
     </ol>
</cffunction>