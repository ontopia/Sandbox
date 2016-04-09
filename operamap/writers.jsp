<%@ taglib uri='/WEB-INF/jsp/nav2-logic.tld'    prefix='logic'    %>
<%@ taglib uri='/WEB-INF/jsp/nav2-output.tld'   prefix='output'   %>
<%@ taglib uri='/WEB-INF/jsp/nav2-value.tld'    prefix='value'    %>
<%@ taglib uri='/WEB-INF/jsp/nav2-TMvalue.tld'  prefix='tm'       %>
<%@ taglib uri='/WEB-INF/jsp/nav2-template.tld' prefix='template' %>

<logic:context topicmap="opera.ltm" settm="topicmap">

<!-- SET VARIABLES WRITTEN-BY, BORN, DIED, PLAY, ENGLISH BY SUBJECT INDICATOR -->
<logic:set name="written-by"><tm:lookup indicator="http://psi.ontopia.net/literature/written-by"/></logic:set>
<logic:set name="born"><tm:lookup indicator="http://psi.ontopia.net/biography/date-of-birth"/></logic:set>
<logic:set name="died"><tm:lookup indicator="http://psi.ontopia.net/biography/date-of-death"/></logic:set>
<logic:set name="play"><tm:lookup indicator="http://psi.ontopia.net/literature/play"/></logic:set>
<logic:set name="english"><tm:lookup indicator="http://www.topicmaps.org/xtm/1.0/language.xtm#en"/></logic:set>

<template:insert template='template.jsp'>

<!-- TEMPLATE TITLE -->
<template:put name='title' body='true'>Index of Writers</template:put>

<!-- TEMPLATE CONTENT -->
<template:put name='content' body='true'>

<h1>Index of Writers</h1>
<!-- GET COLLECTION OF TOPICS OF TYPE WRITER -->
<logic:set name="writers">
  <tm:instances><tm:lookup indicator="http://psi.ontopia.net/literature/writer"/></tm:instances>
</logic:set>
<p>
<!-- TREAT EACH WRITER IN TURN -->
<logic:foreach name="writers" set="writer">

  <!-- SELECT OCCURRENCES OF TYPE "BORN" AND "DIED" FOR THIS WRITER -->
  <logic:set name="birth">
    <tm:filter instanceOf="born"><tm:occurrences of="writer"/></tm:filter>
  </logic:set>
  <logic:set name="death">
    <tm:filter instanceOf="died"><tm:occurrences of="writer"/></tm:filter>
  </logic:set>

  <p><b><a href="writer.jsp?id=<output:id/>"><output:name/></a></b>
  <!-- ADD DATES OF BIRTH AND DEATH -->
  <logic:if name="birth">
    <logic:then>&nbsp;&nbsp;b. <output:content of="birth"/>,</logic:then>
  </logic:if>
  <logic:if name="death">
    <logic:then>d. <output:content of="death"/></logic:then>
  </logic:if>

  <!-- LIST WORKS BY THIS WRITER -->
  <logic:set name="written">
    <tm:associated from="writer" type="written-by"/>
  </logic:set>
  <br />

  <logic:foreach name="written" separator=" * ">
    <i><output:name basenameScope="play" /></i>
    <!-- OUTPUT NAME OF OPERA IN SCOPE "ENGLISH" (IF ANY) -->
    <logic:set name="english-name">
      <tm:filter inScopeOf="english"><tm:names/></tm:filter>
    </logic:set>
    <logic:if name="english-name"><logic:then>(<output:name/>)</logic:then></logic:if>
  </logic:foreach>

</logic:foreach>
</template:put>
</template:insert>
</logic:context>


