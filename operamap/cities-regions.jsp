<%@ taglib uri='/WEB-INF/jsp/nav2-logic.tld'   prefix='logic' %>
<%@ taglib uri='/WEB-INF/jsp/nav2-output.tld'  prefix='output'%>
<%@ taglib uri='/WEB-INF/jsp/nav2-value.tld'   prefix='value' %>
<%@ taglib uri='/WEB-INF/jsp/nav2-TMvalue.tld' prefix='tm'    %>
<%@ taglib uri='/WEB-INF/jsp/nav2-template.tld' prefix='template' %>

<logic:context topicmap="opera.ltm" settm="topicmap">
<template:insert template='template.jsp'>

<template:put name='title' body='true'>Cities and Regions</template:put>

<template:put name='content' body='true'>

<table width="100%" cellspacing="0" cellpadding="4" border="0">
<tr><td align="left"><h1>Indexes of Cities and Regions</h1></td></tr>
</table>

<logic:set name="places">
  <value:union>
    <tm:instances><tm:lookup indicator="http://psi.ontopia.net/geography/city"/></tm:instances>
    <tm:instances><tm:lookup indicator="http://psi.ontopia.net/geography/region"/></tm:instances>
  </value:union>
</logic:set>
<logic:set name="names" comparator="nameComparator">
  <tm:names of="places"/>
</logic:set>
<logic:set name="splittedNames">
  <tm:splitter of="names"/>
</logic:set>

<!-- OUTPUT FIRST LETTER NAVIGATION BAR -->
<table>
<tr><td>&nbsp;</td></tr>
<tr>
<logic:foreach name="splittedNames">
  <td><b><output:element name="a"><output:attribute
  name="href">#<output:name
  stringifier="net.ontopia.topicmaps.nav2.impl.framework.FirstUpperCaseStringifier"/></output:attribute><output:name
  stringifier="net.ontopia.topicmaps.nav2.impl.framework.FirstUpperCaseStringifier"/></output:element>
  </b>&nbsp;</td>
</logic:foreach>
</tr>
<tr><td>&nbsp;</td></tr>
</table>

<table>
<logic:foreach name="splittedNames">
  <tr><td>
  <output:element name="a"><output:attribute name="name"><output:name
  stringifier="net.ontopia.topicmaps.nav2.impl.framework.FirstUpperCaseStringifier"/></output:attribute><output:name
  stringifier="net.ontopia.topicmaps.nav2.impl.framework.FirstUpperCaseStringifier"/></output:element>
  </td></tr>
  <logic:foreach><tr>
      <logic:set name="obj-id"><tm:topics/></logic:set>
      <td></td>
      <td><a href="city-region.jsp?id=<output:id of="obj-id"/>"><output:name/></a></td>
    </tr></logic:foreach>
</logic:foreach>
</table>

</template:put>
</template:insert>
</logic:context>
