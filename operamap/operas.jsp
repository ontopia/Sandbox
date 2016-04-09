<%@ taglib uri='http://psi.ontopia.net/jsp/taglib/template' prefix='template'%>
<%@ taglib uri='http://psi.ontopia.net/jsp/taglib/tolog' prefix='tolog'%>

<%@ taglib uri='/WEB-INF/jsp/nav2-logic.tld'    prefix='logic'    %>
<%@ taglib uri='/WEB-INF/jsp/nav2-output.tld'   prefix='output'   %>
<%@ taglib uri='/WEB-INF/jsp/nav2-value.tld'    prefix='value'    %>
<%@ taglib uri='/WEB-INF/jsp/nav2-TMvalue.tld'  prefix='tm'       %>

<logic:context topicmap="opera.ltm" settm="topicmap">

<!-- SET VARIABLES BY SUBJECT INDICATOR -->
<logic:set name="english"><tm:lookup indicator="http://www.topicmaps.org/xtm/1.0/language.xtm#en"/></logic:set>
<logic:set name="shortname"><tm:lookup indicator="http://psi.ontopia.net/basename/short-name"/></logic:set>
<logic:set name="composed-by"><tm:lookup indicator="http://psi.ontopia.net/music/composed-by"/></logic:set>
<logic:set name="premiere"><tm:lookup indicator="http://psi.ontopia.net/opera/premiere"/></logic:set>
<logic:set name="premiere-date"><tm:lookup indicator="http://psi.ontopia.net/opera/premiere-date"/></logic:set>

<template:insert template='template.jsp'>

<!-- TEMPLATE TITLE -->
<template:put name='title' body='true'>Index of Operas</template:put>

<!-- TEMPLATE CONTENT -->
<template:put name='content' body='true'>
<h1>Index of Operas</h1>

<!-- GET COLLECTION OF TOPICS OF TYPE OPERA -->
<logic:set name="operas">
  <tm:instances><tm:lookup indicator="http://psi.ontopia.net/music/opera"/></tm:instances>
</logic:set>

<!-- GET COLLECTION OF OPERA NAMES AND SPLIT THEM BY LETTER -->
<!-- fixme: should only get names in unconstrained scope (unless there is a
     name scoped by the composer) and names in the scope English -->
<logic:set name="names" comparator="nameComparator">
  <tm:names of="operas"/>
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

<!-- OUTPUT LIST OF OPERAS GROUPED BY FIRST LETTER -->
<table>
<!-- loop over each letter -->
<logic:foreach name="splittedNames">
  <tr><td>
  <b><output:element name="a"><output:attribute name="name"><output:name
  stringifier="net.ontopia.topicmaps.nav2.impl.framework.FirstUpperCaseStringifier"/></output:attribute><output:name
  stringifier="net.ontopia.topicmaps.nav2.impl.framework.FirstUpperCaseStringifier"/></output:element>
  </b></td></tr>
  <!-- loop over each opera -->
  <logic:foreach comparator="nameComparator">
    <logic:set name="obj-id"><tm:topics/></logic:set>
    <logic:set name="composer"><tm:associated from="obj-id" type="composed-by"/></logic:set>
    <logic:set name="premiere-location"><tm:associated from="obj-id" type="premiere"/></logic:set>
    <logic:set name="premiere-data">
      <tm:filter instanceOf="premiere-date"><tm:occurrences of="obj-id"/></tm:filter>
    </logic:set>
    <%-- output opera with composer and date of first performance. fixme: should only output year. --%>
    <tr><td></td><td>
    <b><a href="opera.jsp?id=<output:id of="obj-id"/>"><output:name/></a></b>
    &nbsp;&nbsp;-&nbsp;&nbsp;
    <a href="composer.jsp?id=<output:id of="composer"/>"><i><output:name of="composer"
    basenameScope="shortname"/><logic:if name="premiere-data"><logic:then>,
    <output:content of="premiere-data"/></logic:then></logic:if></i></a>
    </td></tr>
  </logic:foreach>
</logic:foreach>
<tr height="800"></tr>
</table>
</template:put>
</template:insert>
</logic:context>
