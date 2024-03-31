<cfparam name = "id" default = "4"/>

<cfset contentFunctions = createObject("content")/>
<cfset myContent = contentFunctions.obtainArticle(id)/>

<cfoutput>
     <h1>#myContent.title#</h1>
     <h4>#dateformat(myContent.dataWritten, "mm.dd.yyyy")#</h4>
     <p>#myContent.description#</p>
</cfoutput>