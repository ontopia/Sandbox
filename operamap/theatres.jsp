<%@ taglib uri='/WEB-INF/jsp/nav2-logic.tld'    prefix='logic'    %>
<%@ taglib uri='/WEB-INF/jsp/nav2-output.tld'   prefix='output'   %>
<%@ taglib uri='/WEB-INF/jsp/nav2-value.tld'    prefix='value'    %>
<%@ taglib uri='/WEB-INF/jsp/nav2-TMvalue.tld'  prefix='tm'       %>
<%@ taglib uri='/WEB-INF/jsp/nav2-template.tld' prefix='template' %>

<logic:context topicmap="opera.ltm" settm="topicmap">

<!-- SET VARIABLES CITY, THEATRE, LOCATED-IN BY SUBJECT INDICATOR -->
<logic:set name="city">
  <tm:lookup indicator="http://psi.ontopia.net/geography/city"/>
</logic:set>
<logic:set name="theatre">
  <tm:lookup indicator="http://psi.ontopia.net/literature/theatre"/>
</logic:set>
<logic:set name="located-in">
  <tm:lookup indicator="http://psi.ontopia.net/geography/located-in"/>
</logic:set>

<template:insert template='template.jsp'>

<!-- TEMPLATE TITLE -->
<template:put name='title' body='true'>Index of Theatres</template:put>

<!-- TEMPLATE CONTENT -->
<template:put name='content' body='true'>

<h1>Index of Theatres</h1>

<!-- get all the countries -->
<logic:set name="countries">
  <tm:instances><tm:lookup indicator="http://psi.ontopia.net/geography/country"/></tm:instances>
</logic:set>

<table width="100%">
<tr valign="top">
  <td style="padding-right: 8; border-right: thin solid white">
<p><br/><i>By country:</i></p>
  <logic:foreach name="countries" set="country">

  <% boolean country_done = false; %>
  <logic:set name="cities">
    <tm:filter instanceOf="city">
        <tm:associated from="country" type="located-in"/>
    </tm:filter>
  </logic:set>

  <logic:foreach name="cities" set="city">

    <% boolean city_done = false; %>
    <logic:set name="theatres">
      <tm:filter instanceOf="theatre">
        <tm:associated from="city" type="located-in"/>
      </tm:filter>
    </logic:set>

    <logic:if name="theatres">
    <logic:then>
    <% if (!country_done) {
       %><p><b><output:name of="country"/></b><%
       country_done = true;
       }
       if (!city_done) {
       %><br /><output:name of="city"/><%
       city_done = true;
       }
    %>
    </logic:then>
    </logic:if>
    <logic:foreach name="theatres">*&nbsp;<a href="theatre.jsp?id=<output:id/>"><output:name/></a>
    </logic:foreach>
  </logic:foreach>
  </logic:foreach>
  </td>
  <td>&nbsp;</td>
  <td nowrap>
<p><br/><i>Alphabetically:</i></p>
  <logic:set name="theatres">
    <tm:instances><tm:lookup indicator="http://psi.ontopia.net/literature/theatre"/></tm:instances>
  </logic:set>
  <!-- TREAT EACH THEATRE IN TURN -->
  <logic:foreach name="theatres"><li>
    <a href="theatre.jsp?id=<output:objectid/>"><output:name/></a>
  </li></logic:foreach>
  </td>
</tr>
</table>
</template:put>
</template:insert>
</logic:context>
