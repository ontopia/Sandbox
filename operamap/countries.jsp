<%@ taglib uri='/WEB-INF/jsp/nav2-logic.tld'    prefix='logic'    %>
<%@ taglib uri='/WEB-INF/jsp/nav2-output.tld'   prefix='output'   %>
<%@ taglib uri='/WEB-INF/jsp/nav2-value.tld'    prefix='value'    %>
<%@ taglib uri='/WEB-INF/jsp/nav2-TMvalue.tld'  prefix='tm'       %>
<%@ taglib uri='/WEB-INF/jsp/nav2-template.tld' prefix='template' %>

<logic:context topicmap="opera.ltm" settm="topicmap">
<template:insert template='template.jsp'>

<template:put name='title' body='true'>List of Countries</template:put>

<template:put name='content' body='true'>

<table width="100%" cellspacing="0" cellpadding="4" border="0">
  <tr><td align="left"><h1>Indexes of Countries</h1></td></tr>
</table>

<logic:set name="countries">
  <tm:instances>
    <tm:lookup indicator="http://psi.ontopia.net/geography/country"/>
  </tm:instances>
</logic:set>

<p><table width="100%" cellspacing="0" cellpadding="4" border="0">
<tr><td>
  <ul><logic:foreach name="countries">
    <li><a href="country.jsp?id=<output:id/>"><output:name/></a></li>
  </logic:foreach></ul>
</td></tr>
</table>
</p>

</template:put>

</template:insert>
</logic:context>
