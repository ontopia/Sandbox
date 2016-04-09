<%@ page import="net.ontopia.topicmaps.nav2.core.*,
                  net.ontopia.topicmaps.core.OccurrenceIF,
                  java.util.Collection"
%>
<%@ taglib uri='/WEB-INF/jsp/nav2-logic.tld'    prefix='logic'    %>
<%@ taglib uri='/WEB-INF/jsp/nav2-output.tld'   prefix='output'   %>
<%@ taglib uri='/WEB-INF/jsp/nav2-value.tld'    prefix='value'    %>
<%@ taglib uri='/WEB-INF/jsp/nav2-TMvalue.tld'  prefix='tm'       %>
<%@ taglib uri='/WEB-INF/jsp/nav2-template.tld' prefix='template' %>

<logic:context topicmap="opera.ltm" objparam="id" set="topic" settm="topicmap">
<template:insert template='template.jsp'>

<!-- TEMPLATE TITLE -->
<template:put name='title' body='true'>
  <output:name of="topic"/>
</template:put>

<!-- TEMPLATE CONTENT -->
<template:put name='content' body='true'>

<!-- SET ONTOLOGY VARIABLES -->
<logic:set name="illustration"><tm:lookup indicator="http://psi.ontopia.net/opera/illustration"/></logic:set>

<!-- GET ILLUSTRATIONS -->
<logic:set name="pic">
  <tm:filter instanceOf="illustration">
    <tm:occurrences of="topic"/>
  </tm:filter>
</logic:set>

<h1>
<logic:if name="pic">
<logic:then>
  <%
     // pull out occurrence from variable "pic"
     NavigatorPageIF ctxt = (NavigatorPageIF) pageContext.getAttribute(NavigatorApplicationIF.CONTEXT_KEY, PageContext.REQUEST_SCOPE);
     Collection result = (Collection) ctxt.getContextManager().getValue("pic");
     OccurrenceIF occ = (OccurrenceIF) result.iterator().next();

     String tempLoc = occ.getLocator().getAddress();
     int start = tempLoc.lastIndexOf("occurs");
     int stop = tempLoc.length();
     String descLoc = tempLoc.substring(start, stop);
  %>
  <img src="<%= descLoc %>">&nbsp;&nbsp;
</logic:then>
</logic:if>
<output:name of="topic"/></h1>

<logic:include file="/functions/country.jsm"/>

<logic:call name="country_function"></logic:call>

</template:put>
</template:insert>
</logic:context>
