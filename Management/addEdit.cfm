<cftry>
     <cfset addEditFunctions = createObject("addEdit")/>

     <div class="row">
          <div id="main" class="col-9">
               Main Area
          </div>

          <div id="leftgutter" class="col-lg-3 order-first">
               Left Side
          </div>
     </div>

     <cfcatch type="any">
          <cfoutput>
               #cfcatch.Message#
          </cfoutput>
     </cfcatch>
</cftry>