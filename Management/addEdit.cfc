/***
 * addEdit takes form submitted input and inserts it into the database
 * 
 * @author Ryan Balachandran
 * @date 2/20/2024
**/
component {
     function processForms(required struct formData) {
          if (formData.keyExists('ISBN13') && formData.isbn13.len() == 13 && formData.keyExists('Title') && formData.title.len() > 0) {
               if (formData.keyExists("uploadImage") && formData.uploadImage.len() > 0) {
                    // formData.image = uploadBookCover();
                    arguments.formData.image = uploadBookCover();
               }

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
                         Language = :language,
                         PublisherID = :publisher,
                         image = :image
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

               qs.addParam(
                    name      = 'publisher',
                    CFSQLTYPE = 'CF_SQL_NVARCHAR',
                    value     = trim(formData.publisher),
                    nullValue = trim(formData.publisher).len() != 35
               );

               qs.addParam(
                    name      = 'image',
                    CFSQLTYPE = 'CF_SQL_NVARCHAR',
                    value     = trim(formData.image),
                    nullValue = trim(formData.image).len() == 0
               );

               qs.execute();
          }
     }

     function sideNavBooks() {
          try {
               var qs = new query(datasource = application.dsource);
               qs.setSql('Select * from Book_Information');
               return qs.execute().getResult();
          } catch(any err) {
               writeDump(err);
          }
     }

     function bookDetails(required string isbn13) {
          var qs = new query(datasource = application.dsource);
          qs.setSql('select * FROM Book_Information WHERE ISBN13 = :isbn13');
          qs.addparam(
               name      = 'isbn13',
               CFSQLTYPE = 'CF_SQL_NVARCHAR',
               value     = arguments.isbn13
          );
          
          return qs.execute().getResult();
     }

     function allPublishers(isbn13) {
          var qs = new query(datasource = application.dsource);
          qs.setSql('select * from publishers order by name');
          return qs.execute().getResult(); 
     }

     function uploadBookCover() {
          var imageData = fileUpload(expandPath("../images/"), "uploadImage", "*", "makeUnique");
          return imageData.serverFile;
     }
}