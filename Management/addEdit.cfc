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
                         image = :image,
                         Description = :description
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
                    value     = formData.weight,
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

               qs.addParam(
                    name      = 'description',
                    CFSQLTYPE = 'CF_SQL_NVARCHAR',
                    value     = trim(formData.description),
                    nullValue = trim(formData.description).len() == 0
               );
               
               qs.execute();

               if (formData.keyExists("genre")) {
                    deleteAllBookGenres(formData.isbn13);

                    formData.genre.listToArray().each(function(item){
                         insertGenre(item, formData.isbn13);
                    });
               }
          }
     }

     function sideNavBooks(qterm) {
          if (qterm.len() == 0) {
               return queryNew("title");
          }
          else {
               var qs = new query(datasource = application.dsource);
               qs.setSql('Select * FROM Book_Information WHERE Title LIKE :qterm ORDER BY Title');

               qs.addparam(
                    name  = 'qterm', 
                    value = '%#qterm#%'
               );

               return qs.execute().getResult();
          }
     }

     function bookDetails(required string isbn13) {
          var qs = new query(datasource = application.dsource);
          qs.setSql('Select * FROM Book_Information WHERE ISBN13 = :isbn13');

          qs.addparam(
               name      = 'isbn13',
               CFSQLTYPE = 'CF_SQL_NVARCHAR',
               value     = arguments.isbn13
          );

          return qs.execute().getResult();
     }

     function allPublishers(isbn13) {
          var qs = new query(datasource = application.dsource);
          qs.setSql('Select * FROM publishers ORDER BY name');
          return qs.execute().getResult(); 
     }

     function uploadBookCover() {
          var imageData = fileUpload(expandPath("../images/"), "uploadImage", "*", "makeUnique");
          return imageData.serverFile;
     }

     function allGenres() {
          var qs = new query(datasource = application.dsource);
          qs.setSql('Select * FROM Genre ORDER BY genreName');
          return qs.execute().getResult(); 
     }

     // Accepts the genre ID and book ID and inserts them into the genresToBooks table
     function insertGenre(genreID, isbn13) {
          var qs = new query(datasource = application.dsource);
          qs.setSql('Insert INTO genresToBooks (genreID, isbn13) VALUES (:genreid, :isbn13)');

          qs.addparam(
               name  = 'genreid',
               value = arguments.genreID
          );

          qs.addparam(
               name  = 'isbn13',
               value = arguments.isbn13
          );

          qs.execute();
     }

     function deleteAllBookGenres(isbn13) {
          var qs = new query(datasource = application.dsource);
          qs.setSql('Delete FROM GenresToBooks WHERE ISBN13 = :isbn13');

          qs.addparam(
               name  = 'isbn13',
               value = arguments.isbn13
          );

          qs.execute();
     }

     // function bookGenres(isbn13) {
     //      var qs = new query(datasource = application.dsource);
     //      qs.setSql('Select * FROM genresToBooks WHERE ISBN13 = :isbn13');

     //      qs.addparam(
     //           name  = 'isbn13',
     //           value = arguments.isbn13
     //      );

     //      return qs.execute().getResult(); 
     // }

     function bookGenres(book) {
          var qs = new query(datasource = application.dsource);
          qs.setSql('Select * FROM genresToBooks 
               INNER JOIN Genre ON genresToBooks.genreID = Genre.genreID 
               WHERE genresToBooks.ISBN13 = :isbn13
               ORDER BY genreName
          ');

          qs.addparam(
               name  = 'isbn13',
               value = arguments.book
          );

          return qs.execute().getResult(); 
     }
}