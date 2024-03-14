<!--- <!DOCTYPE html>
<html lang="en">
     <head>
          <meta charset="UTF-8">
          <title>Search Results</title>
     </head>

     <style>

     </style>

     <body> --->
          <!--- <cfdump var="#form#"> --->
          <cfset bookInfo = bookstoreFunctions.obtainSearchResults(form.searchme)/>
          <cfparam name="searchme" default="">
          
          <cfif bookInfo.recordcount == 0>
               <cfoutput>
                    #bookstoreFunctions.noResults()#
               </cfoutput>
          <cfelseif bookInfo.recordcount == 1>
               <cfoutput>
                    #bookstoreFunctions.oneResult()#
                    <img src="images/#bookInfo.image[1]#" style="float: left; width: 350px;"/>
                    <span>Title: #bookInfo.title[1]#</span>
                    <span>Publisher: #bookInfo.name[1]#</span>
               </cfoutput>
          <cfelse>
               <cfoutput>
                    #bookstoreFunctions.manyResults()#
               </cfoutput>
               
               <ol class="nav flex-column">
                    <cfoutput query = "bookInfo">
                         <li class="nav-item">
                              <a class="nav-link" hfred="#cgi.script_name#?p=details&searchme=#trim(isbn13)#">#trim(title)#</a>
                         </li>
                    </cfoutput>
               </ol>
          </cfif>
     <!--- </body>
</html> --->
