<%@ taglib uri='/WEB-INF/jsp/nav2-logic.tld'    prefix='logic'    %>
<%@ taglib uri='/WEB-INF/jsp/nav2-output.tld'   prefix='output'   %>
<%@ taglib uri='/WEB-INF/jsp/nav2-value.tld'    prefix='value'    %>
<%@ taglib uri='/WEB-INF/jsp/nav2-TMvalue.tld'  prefix='tm'       %>
<%@ taglib uri='/WEB-INF/jsp/nav2-template.tld' prefix='template' %>

<logic:context topicmap="opera.ltm" settm="topicmap" objparam="id" set="topic">
<template:insert template='template.jsp'>

<!-- TEMPLATE TITLE -->
<template:put name='title' body='true'>
  <output:name of="topic"/>
</template:put>

<!-- TEMPLATE CONTENT -->
<template:put name='content' body='true'>

<logic:include file="/functions/city-region.jsm"/>
<table width="100%">
<tr valign="top">
  <td><logic:call name="city-region_function"/></td>
  <td>
<logic:set name="operas" comparator="off">
  <tm:tolog query='{ i"http://psi.ontopia.net/opera/premiere"(
                       $OPERA : i"http://psi.ontopia.net/music/opera",
                       %topic% : i"http://psi.ontopia.net/geography/place" ) |
                     i"http://psi.ontopia.net/opera/premiere"(
                       $OPERA : i"http://psi.ontopia.net/music/opera",
                       $THEATRE : i"http://psi.ontopia.net/geography/place" ),
                     i"http://psi.ontopia.net/geography/located-in"(
                       $THEATRE : i"http://psi.ontopia.net/geography/containee",
                       %topic% : i"http://psi.ontopia.net/geography/container")
                   }
                   order by $OPERA?' select="OPERA"/>
</logic:set>
<logic:if name="operas"><logic:then>
  <logic:if name="operas"  lessThan="2"><logic:then>
  <p>Only <output:count of="operas"/> opera was premiered in <output:name of="topic"/>:</p>
  </logic:then><logic:else>
  <p><output:count of="operas"/> operas were premiered in <output:name of="topic"/>:</p>
  </logic:else></logic:if>
  <ol>
  <logic:foreach name="operas">
    <li><a href="opera.jsp?id=<output:id/>"><output:name/></a></li>
  </logic:foreach>
  </ol>
</logic:then></logic:if>
</td></tr></table>

<!--
  <p>
  <br/>Search OperaBase for performances in <output:name/>:
Search the OperaBase :
<form method="get" action="operabase.jsp">
  <input type="hidden" name="location" value="<output:name of="topic"/>">

Order by:
  <input type="radio" name="sort" value="C">Composer
  <input type="radio" name="sort" value="T">Title
  <input type="radio" name="sort" value="D" checked>Date

  <input type="submit" value="search">
</form>
-->

</template:put>
</template:insert>
</logic:context>
