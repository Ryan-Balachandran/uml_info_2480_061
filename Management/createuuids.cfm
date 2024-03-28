<ul>
     <cfoutput>
             <cfloop from = "1" to = "20" index = "I">
                     <!--- <li>#createuuid()#</li> --->
                     <input type="text" value="#createuuid()#" size=35/><br/>
             </cfloop>
     </cfoutput>
</ul>