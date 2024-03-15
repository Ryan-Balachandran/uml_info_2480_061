<cfoutput>
     <cfset bookInfo = bookstoreFunctions.obtainSearchResults(form.searchme)/>

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
          <img src="images/#bookInfo.image[1]#" style="float: left; width: 250px;"/>

          Title: #bookInfo.title[1]#<br/>
          ISBN-13: #bookInfo.isbn13[1]#<br/>
          Publisher: #bookInfo.name[1]#<br/>
          Year: #bookInfo.year[1]#<br/>
          Pages: #bookInfo.pages[1]#
     </cfoutput>
</cffunction>

<cffunction name="manyResults">
     There were more than one result, here is the list.
     
     <ol class="nav flex-column">
          <cfoutput query = "bookInfo">
               <li class="nav-item">
                    <a class="nav-link" hfref="#cgi.script_name#?p=details&searchme=#trim(isbn13)#">#trim(title)#</a>
               </li>
          </cfoutput>
     </ol>
</cffunction>