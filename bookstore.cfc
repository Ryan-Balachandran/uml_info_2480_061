/***
 * Controller for the front end of the website
 * 
 * @author Ryan Balachandran
 * @date 3/13/2024
**/
component {
     function obtainSearchResults(searchme, genre) {
          if (searchme.len() != 0)
          {
               var qs = new query(datasource = application.dsource);
               qs.setSql("Select * FROM Book_Information 
                    INNER JOIN Publishers ON Book_Information.PublisherID = Publishers.PublisherID
                    WHERE Title LIKE :searchme OR ISBN13 LIKE :isbn13;
               ");
     
               qs.addParam(
                    name      = 'searchme', 
                    value     = '%#searchme#%'
               );
     
               qs.addParam(
                    name      = 'isbn13', 
                    value     = '#searchme#%'
               );
     
               return qs.execute().getResult();
          } else if (genre.len() != 0) {
               var qs = new query(datasource = application.dsource);
               qs.setSql("Select * FROM Book_Information 
                    INNER JOIN genresToBooks ON Book_Information.isbn13 = GenresToBooks.isbn13
                    INNER JOIN Publishers ON Book_Information.PublisherID = Publishers.PublisherID
                    WHERE genresToBooks.genreID = :genreid;
               ");
     
               qs.addParam(
                    name  = 'genreid', 
                    value = arguments.genre
               );
     
               return qs.execute().getResult();
          }
     }

     function genreList() {
          var qs = new query(datasource = application.dsource);
          qs.setSql("Select DISTINCT Genre.genreID, genreName FROM GenresToBooks 
               INNER JOIN Genre ON Genre.genreID = GenresToBooks.genreID 
               ORDER BY genreName;
          ");

          return qs.execute().getResult();
     }

     function resultsHeader(searchme, genre) {
          if (searchme.len() > 0) {
               return 'Keyword: #searchme#';
          } else {
               return 'Genre: #obtainGenreNameById(arguments.genre)#';
          }
     }

     function obtainGenreNameById(genreid) {
          var qs = new query(datasource = application.dsource);
          qs.setSql("Select genreName FROM Genre WHERE genreID = :genreid");
          qs.addParam(
               name  = 'genreid', 
               value = arguments.genreid
          );
          
          return qs.execute().getResult().genrename;
      }
}