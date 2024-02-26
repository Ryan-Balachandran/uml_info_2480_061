/***
 * addEdit takes form submitted input and inserts it into the database
 * 
 * @author Ryan Balachandran
 * @date 2/20/2024
**/
component {
     function processForms(required struct formData) {
          if(formData.keyExists("ISBN13")) {
               // writeDump(formData);
               // writeOutput("INSERT into BOOKS (isbn13, title) VALUES ('#formData.isbn13#', '#formData.title#')");

               var qs = new query(datasource = application.dsource);
               qs.setSql("insert into Book_Information (ISBN13, Title) values (:isbn13, :title)");
               qs.addParam(
                    name      = "isbn13", 
                    cfsqltype = "CF_SQL_NVARCHAR", 
                    value     = formData.isbn13
               );
               qs.addParam(
                    name      = "title", 
                    cfsqltype = "CF_SQL_NVARCHAR", 
                    value     = formData.title
               );
               qs.execute();
          }
     }

     function sideNavBooks() {
          try {
               var qs = new Query(datasource = application.dsource);
               qs.setSql("select * from Book_Information");
               return qs.execute().getResult();
          } catch(any err) {
               writeDump(err);
          }
          
     }
}


/* TAG SYNTAX
<cffunction name="processForms">
     <cfargument name="formData" type="struct" required="true">
     <cfdump var="#formData#">
</cffunction> 

<cfif></cfif>
*/