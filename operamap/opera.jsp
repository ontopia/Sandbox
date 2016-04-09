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
<template:put name='title' body='true'><tolog:out var="topic"/></template:put>

<!--
    TEMPLATE CONTENT
-->
<template:put name='content' body='true'>
<!--
    SET ONTOLOGY VARIABLES
-->
<logic:set name="normal"><tm:lookup indicator="http://psi.ontopia.net/basename/normal"/></logic:set>
<logic:set name="english"><tm:lookup indicator="http://www.topicmaps.org/xtm/1.0/language.xtm#en"/></logic:set>
<logic:set name="illustration"><tm:lookup indicator="http://psi.ontopia.net/opera/illustration"/></logic:set>
<!--
    SET SORTNAME
-->
<logic:set name="sortname">
  <tm:lookup indicator="http://www.topicmaps.org/xtm/1.0/core.xtm#sort"/>
</logic:set>

<logic:set name="topicsortname">
  <tm:filter inScopeOf="sortname">
    <tm:variants of="topic"/>
  </tm:filter>
</logic:set>

<tolog:set query='composed-by(%topic% : work, $composer : composer)?'/>
  <logic:set name="composersortname">
    <tm:filter inScopeOf="sortname"><tm:variants of="composer"/></tm:filter>
  </logic:set>

<tolog:set query='
select $name from
{topic-name(%topic%, $name),
 scope($name, %composer%) |
topic-name(%topic%, $name),
 not(scope($name, $scope))}
order by $name desc? Unqualified name will be at start of collection'/>
<!-- GET ILLUSTRATIONS -->
<tolog:set query='occurrence(%topic%, $pic), type($pic, illustration)?'/>
<h1>
<logic:if name="pic">
<logic:then><%
     // pull out occurrence from variable "pic"
     NavigatorPageIF ctxt = (NavigatorPageIF) pageContext.getAttribute(NavigatorApplicationIF.CONTEXT_KEY, PageContext.REQUEST_SCOPE);
     Collection result = (Collection) ctxt.getContextManager().getValue("pic");
     OccurrenceIF occ = (OccurrenceIF) result.iterator().next();

     String tempLoc = occ.getLocator().getAddress();
     int start = tempLoc.lastIndexOf("occurs");
     int stop = tempLoc.length();
     String descLoc = tempLoc.substring(start, stop);
  %><img src="<%= descLoc %>" height="234">&nbsp;&nbsp;</logic:then></logic:if
><tolog:out var="name"/></h1>
<logic:include file="/functions/opera.jsm"/><logic:call
   name="opera_function"></logic:call>
</template:put>
</template:insert>
</logic:context>
