<%@ page import="net.ontopia.topicmaps.nav2.core.*,
                  net.ontopia.topicmaps.core.OccurrenceIF,
                  java.util.Collection"
%>
<%@ taglib uri='http://psi.ontopia.net/jsp/taglib/tolog' prefix='tolog'%>
<%@ taglib uri='/WEB-INF/jsp/nav2-logic.tld'    prefix='logic'    %>
<%@ taglib uri='/WEB-INF/jsp/nav2-output.tld'   prefix='output'   %>
<%@ taglib uri='/WEB-INF/jsp/nav2-value.tld'    prefix='value'    %>
<%@ taglib uri='/WEB-INF/jsp/nav2-TMvalue.tld'  prefix='tm'       %>
<%@ taglib uri='/WEB-INF/jsp/nav2-template.tld' prefix='template' %>

<logic:context topicmap="opera.ltm" objparam="id" set="topic" settm="topicmap">
<template:insert template='template.jsp'>
<!--
    TEMPLATE TITLE
-->
<template:put name='title' body='true'>
<tolog:out query='
  topic-name(%topic%, $name),
  scope($name, short-name)?'/>
</template:put>
<!--
    TEMPLATE CONTENT
-->
<template:put name='content' body='true'>
<logic:include file="/functions/composer.jsm"/>
<!--
    GET ILLUSTRATIONS
-->
<tolog:set query='occurrence(%topic%, $pic), type($pic, illustration)?'/>
<h1><%
     // pull out occurrence from variable "pic"
     NavigatorPageIF ctxt = (NavigatorPageIF) pageContext.getAttribute(NavigatorApplicationIF.CONTEXT_KEY, PageContext.REQUEST_SCOPE);
     Collection result = (Collection) ctxt.getContextManager().getValue("pic");
     OccurrenceIF occ = (OccurrenceIF) result.iterator().next();

     String tempLoc = occ.getLocator().getAddress();
     int start = tempLoc.lastIndexOf("occurs");
     int stop = tempLoc.length();
     String descLoc = tempLoc.substring(start, stop);
    %><img src="<%= descLoc %>" height="234">&nbsp;&nbsp;<tolog:out query='
  topic-name(%topic%, $name),
  scope($name, normal)?'/></h1>
<logic:call name="composer_function"></logic:call><br/>
<hr/>
<p>Search OperaBase for performances of operas by <tolog:out query='
  topic-name(%topic%, $name),
  scope($name, normal)?'/>:<br/><br/>
<form method="get" action="operabase.jsp">
  <input type="hidden" name="composer" value="<tolog:out query='
topic-name(%topic%, $name),
scope($name, short-name)?'/>">
  <input type="radio" name="sort" value="V">City
  <input type="radio" name="sort" value="G">Country
  <input type="radio" name="sort" value="T">Title
  <input type="radio" name="sort" value="D" checked>Date
  <input type="submit" value="search">
</form>
</p>
</template:put>
</template:insert>
</logic:context>
