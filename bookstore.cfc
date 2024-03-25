/***
 * Controller for the front end of the website
 * 
 * @author Ryan Balachandran
 * @date 3/13/2024
**/
component {
     function obtainSearchResults(searchme) {
          var qs = new query(datasource = application.dsource);
          qs.setSql("select * FROM Book_Information 
               INNER JOIN Publishers on Book_Information.PublisherID = Publishers.PublisherID
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
     }
}