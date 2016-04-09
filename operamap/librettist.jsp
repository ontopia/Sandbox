<%@ page import="net.ontopia.topicmaps.nav2.core.*,
                  net.ontopia.topicmaps.core.OccurrenceIF,
                  java.util.Collection"
%>
<%@ taglib uri='/WEB-INF/jsp/nav2-logic.tld'   prefix='logic' %>
<%@ taglib uri='/WEB-INF/jsp/nav2-output.tld'  prefix='output'%>
<%@ taglib uri='/WEB-INF/jsp/nav2-value.tld'   prefix='value' %>
<%@ taglib uri='/WEB-INF/jsp/nav2-TMvalue.tld' prefix='tm'    %>
<%@ taglib uri='/WEB-INF/jsp/nav2-template.tld' prefix='template' %>

<logic:context topicmap="opera.ltm" objparam="id" set="topic" settm="topicmap">
<template:insert template='template.jsp'>

<logic:set name="bio"><tm:lookup indicator="http://psi.ontopia.net/biography/biographical-article"/></logic:set>

<!-- GET BIO -->
<logic:set name="descr">
  <tm:filter instanceOf="bio">
    <tm:occurrences of="topic"/>
  </tm:filter>
</logic:set>

<!-- TEMPLATE CONTENT -->
<template:put name='content' body='true'>

<!-- TEMPLATE TITLE -->
<template:put name='title' body='true'>
  <output:name of="topic"/>
</template:put>

<logic:include file="/functions/librettist.jsm"/>

<logic:call name="librettist_function"></logic:call>

</template:put>

<logic:if name="descr">
<logic:then>
  <%
     // some init stuff
     // pull out occurrence from variable "descr"

     NavigatorPageIF ctxt = (NavigatorPageIF) pageContext.getAttribute(NavigatorApplicationIF.CONTEXT_KEY, PageContext.REQUEST_SCOPE);
     Collection result = (Collection) ctxt.getContextManager().getValue("descr");
     OccurrenceIF occ = (OccurrenceIF) result.iterator().next();

     String tempLoc = occ.getLocator().getAddress();
     int start = tempLoc.lastIndexOf("occurs");
     int stop = tempLoc.length();
     String descLoc = tempLoc.substring(start, stop);
  %>
  <template:put name="biography" content="<%= descLoc %>" />
</logic:then>
</logic:if>

</template:insert>
</logic:context>
