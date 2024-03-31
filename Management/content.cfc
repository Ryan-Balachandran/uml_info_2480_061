/***
 * content to create articles for the bookstore
 * 
 * @author Ryan Balachandran
 * @date 3/30/2024
**/

component {
     function processForms(formData) {
          try {
               var newid = formdata.id.len() ? formData.id : createuuid();
               var qs = new query(datasource = application.dsource);

               qs.setSql('IF NOT EXISTS (SELECT * FROM Content WHERE contentID = :id)
                    INSERT INTO Content (contentID, Title, Description, dataWritten) 
                         VALUES (:newid, :title, :description, :dateWritten);
                    UPDATE Content SET
                         Title = :title,
                         Description = :description
                    WHERE contentID = :id
               ');

               qs.addParam(
                    name  = 'newid', 
                    value = newid
               );

               qs.addParam(
                    name  = 'id', 
                    // cfsqltype = 'CF_SQL_NVARCHAR', 
                    value = formData.id
               );

               qs.addParam(
                    name  = 'title', 
                    // cfsqltype = 'CF_SQL_NVARCHAR', 
                    value = formData.title
               );

               qs.addParam(
                    name  = 'descriptiom', 
                    // cfsqltype = 'CF_SQL_NVARCHAR', 
                    value = formData.description
               );

               qs.addParam(
                    name  = 'dataWritten', 
                    value = dateformat(now(), "yyyy-mm-dd")
               );

               qs.execute();
          } catch(any err) {
               writeDump(err);
          }
     }

     function allArticles() {
          var qs = new query(datasource = application.dsource);
          qs.setSql('Select * FROM Content ORDER BY Title');
          return qs.execute().getResult();
     }

     function obtainArticle(id) {
          var qs = new query(datasource = application.dsource);
          qs.setSql('Select * FROM Content WHERE contentID = :id');

          qs.addParam(
               name  = 'id', 
               value = arguments.id
          );

          return qs.execute().getResult();
     }
}