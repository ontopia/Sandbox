<%@ taglib uri='/WEB-INF/jsp/nav2-logic.tld'    prefix='logic'    %>
<%@ taglib uri='/WEB-INF/jsp/nav2-output.tld'   prefix='output'   %>
<%@ taglib uri='/WEB-INF/jsp/nav2-value.tld'    prefix='value'    %>
<%@ taglib uri='/WEB-INF/jsp/nav2-TMvalue.tld'  prefix='tm'       %>
<%@ taglib uri='/WEB-INF/jsp/nav2-template.tld' prefix='template' %>

<logic:context topicmap="opera.ltm" settm="topicmap">

<!-- SET VARIABLES COMPOSED-BY, BORN, DIED, ENGLISH BY SUBJECT INDICATOR -->
<logic:set name="composed-by"><tm:lookup indicator="http://psi.ontopia.net/music/composed-by"/></logic:set>
<logic:set name="born"><tm:lookup indicator="http://psi.ontopia.net/biography/date-of-birth"/></logic:set>
<logic:set name="died"><tm:lookup indicator="http://psi.ontopia.net/biography/date-of-death"/></logic:set>
<logic:set name="english"><tm:lookup indicator="http://www.topicmaps.org/xtm/1.0/language.xtm#en"/></logic:set>

<template:insert template='template.jsp'>

<!-- TEMPLATE TITLE -->
<template:put name='title' body='true'>Index of Composers</template:put>

<!-- TEMPLATE CONTENT -->
<template:put name='content' body='true'>

<h1>Index of Composers</h1>
<!-- GET COLLECTION OF TOPICS OF TYPE COMPOSER -->
<logic:set name="composers">
  <tm:instances><tm:lookup indicator="http://psi.ontopia.net/music/composer"/></tm:instances>
</logic:set>

<!-- TREAT EACH COMPOSER IN TURN -->
<logic:foreach name="composers" set="composer">

  <!-- SELECT OCCURRENCES OF TYPE "BORN" AND "DIED" FOR THIS COMPOSER -->
  <logic:set name="birth">
    <tm:filter instanceOf="born"><tm:occurrences of="composer"/></tm:filter>
  </logic:set>
  <logic:set name="death">
    <tm:filter instanceOf="died"><tm:occurrences of="composer"/></tm:filter>
  </logic:set>

  <p><b><a href="composer.jsp?id=<output:id/>"><output:name/></a></b>
  <!-- ADD DATES OF BIRTH AND DEATH -->
  <logic:if name="birth">
    <logic:then>&nbsp;&nbsp;b. <output:content of="birth"/>,</logic:then>
  </logic:if>
  <logic:if name="death">
    <logic:then>d. <output:content of="death"/></logic:then>
  </logic:if>
  <!-- LIST OPERAS BY THIS COMPOSER -->
  <logic:set name="composed">
    <tm:associated from="composer" type="composed-by"/>
  </logic:set>
  <br />
  <logic:foreach name="composed" separator=" * ">
    <i><a href="opera.jsp?id=<output:id/>"><output:name basenameScope="composer"/></a></i>
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
