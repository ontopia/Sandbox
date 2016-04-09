<%@ taglib uri='/WEB-INF/jsp/nav2-logic.tld'    prefix='logic'    %>
<%@ taglib uri='/WEB-INF/jsp/nav2-output.tld'   prefix='output'   %>
<%@ taglib uri='/WEB-INF/jsp/nav2-value.tld'    prefix='value'    %>
<%@ taglib uri='/WEB-INF/jsp/nav2-TMvalue.tld'  prefix='tm'       %>
<%@ taglib uri='/WEB-INF/jsp/nav2-template.tld' prefix='template' %>

<logic:context topicmap="opera.ltm" objparam="id" set="topic" settm="topicmap">
<template:insert template='template.jsp'>

<template:put name='title' body='true'>
  <output:name of="topic"/>
</template:put>

<template:put name='content' body='true'>

<logic:set name="written-by"><tm:lookup
  indicator="http://psi.ontopia.net/literature/written-by"/></logic:set>
<logic:set name="composed-by"><tm:lookup
  indicator="http://psi.ontopia.net/music/composed-by"/></logic:set>
<logic:set name="based-on"><tm:lookup
  indicator="http://psi.ontopia.net/opera/based-on"/></logic:set>
<logic:set name="normal"><tm:lookup
  indicator="http://psi.ontopia.net/basename/normal"/></logic:set>
<logic:set name="shortname"><tm:lookup
  indicator="http://psi.ontopia.net/basename/short-name"/></logic:set>

<logic:set name="written"><tm:associated type="written-by"/></logic:set>

<h1><output:name of="topic" basenameScope="normal"/></h1>

<p>Works and the operas that they inspired:</p>
<table class="shboxed" cellpadding="0">
<logic:foreach name="written" set="work">
<logic:set name="type"><tm:classesOf/></logic:set>
<tr valign="top"><td><b><output:name basenameScope="type"/></b>
(<output:name of="type"/>)</td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
<logic:set name="operas"><tm:associated type="based-on"/></logic:set>
<td><logic:foreach name="operas" set="opera" separator="<br />">
<logic:set name="composer"><tm:associated type="composed-by"/></logic:set>
<a href="composer.jsp?id=<output:id of="composer"/>"><output:name of="composer"
  basenameScope="shortname"/></a>:
<i><a href="opera.jsp?id=<output:id/>"><output:name basenameScope="composer"/></a></i>
</logic:foreach></td>
</logic:foreach>
</tr>
</table>
</template:put>
</template:insert>
</logic:context>
