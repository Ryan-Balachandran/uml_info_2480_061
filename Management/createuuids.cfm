<!--- 
<nav>
        <cfoutput>
                <cfloop from = "1" to = "20" index = "i">
                        <a class="nav-link #i eq 1 ? 'active' : ''# " >
                                <input value="#createuuid()#" size="35"/>
                        </a>
                </cfloop>
        </cfoutput>
</nav> --->


<ul>
        <br/>
        <cfoutput>
                <cfloop from = "1" to = "20" index = "I">
                        <a class="nav-link #i eq 1 ? 'active' : ''# ">
                                <input value="#createuuid()#" size="35"/>
                        </a>         
                </cfloop>
        </cfoutput>
</ul>

