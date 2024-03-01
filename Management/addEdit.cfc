/***
 * addEdit takes form submitted input and inserts it into the database
 * 
 * @author Ryan Balachandran
 * @date 2/20/2024
**/
component {
     function processForms(required struct formData) {
          if (formData.keyExists('ISBN13') && formData.isbn13.len() == 13 && formData.keyExists('Title') && formData.title.length() > 0) {
               // writeDump(formData);
               // writeOutput("insert into Book_Information (ISBN13, Title) values ('#formData.isbn13#', '#formData.title#')");

               var qs = new query(datasource = application.dsource);
               qs.setSql('IF NOT EXISTS (SELECT * FROM Book_Information WHERE ISBN13 = :isbn13)
                    INSERT INTO Book_Information (ISBN13, Title) VALUES (:isbn13, :title);
                    UPDATE Book_Information SET
                         Title = :title,
                         Year = :year,
                         Weight = :weight,
                         ISBN = :isbn,
                         Pages = :pages,
                         Binding = :binding,
                         Langauge = :language
                    WHERE ISBN13 = :isbn13
               ');

               qs.addParam(
                    name      = 'isbn13', 
                    cfsqltype = 'CF_SQL_NVARCHAR', 
                    value     = trim(formData.isbn13),
                    nullValue = formData.isbn13.len() != 13
               );

               qs.addParam(
                    name      = 'title', 
                    cfsqltype = 'CF_SQL_NVARCHAR', 
                    value     = trim(formData.title),
                    nullValue = formData.title.len() == 0
               );

               qs.addParam(
                    name      = 'year',
                    CFSQLTYPE = 'CF_SQL_INTEGER',
                    value     = trim(formData.year),
                    nullValue = !isValid('numeric', formData.year)
               );
               
               qs.addParam(
                    name      = 'weight',
                    CFSQLTYPE = 'CF_SQL_INTEGER',
                    value     = trim(formData.weight),
                    nullValue = !isValid('numeric', formData.weight)
               );

               qs.addParam(
                    name      = 'isbn',
                    CFSQLTYPE = 'CF_SQL_NVARCHAR',
                    value     = trim(formData.isbn),
                    nullValue = formData.isbn.len() != 10
               );

               qs.addParam(
                    name      = 'pages',
                    CFSQLTYPE = 'CF_SQL_INTEGER',
                    value     = trim(formData.pages),
                    nullValue =! isValid('numeric', formData.pages)
               );

               qs.addParam(
                    name      = 'binding',
                    CFSQLTYPE = 'CF_SQL_NVARCHAR',
                    value     = trim(formData.binding)
               );

               qs.addParam(
                    name      = 'language',
                    CFSQLTYPE = 'CF_SQL_NVARCHAR',
                    value     = trim(formData.language)
               );

               qs.execute();
          }
     }


     function sideNavBooks() {
          try {
               var qs = new query(datasource = application.dsource);
               qs.setSql('select * from Book_Information');
               return qs.execute().getResult();
          } catch(any err) {
               writeDump(err);
          }
     }

     function bookDetails(isbn13) {
          var qs = new query(datasource = application.dsource);
          qs.setSql('select * from Book_Information where ISBN13 = :isbn13');
          qs.addparam(
               name      = 'isbn13',
               CFSQLTYPE = 'CF_SQL_NVARCHAR',
               value     = arguments.isbn13
          );
          
          return qs.execute().getResult();
     }
}