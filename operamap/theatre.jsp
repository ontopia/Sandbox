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

  <template:put name='title' body='true'>
    <output:name of="topic"/>
  </template:put>

  <template:put name='content' body='true'>


  <logic:set name="illustration">
    <tm:lookup indicator="http://psi.ontopia.net/opera/illustration"/>
  </logic:set>

  <logic:set name="pic">
    <tm:filter instanceOf="illustration">
      <tm:occurrences of="topic"/>
    </tm:filter>
  </logic:set>

  <h1><output:name of="topic"/></h1>

  <logic:if name="pic">
  <logic:then>
    <%
       // some init stuff
       // pull out occurrence from variable "descr"

       NavigatorPageIF ctxt = (NavigatorPageIF) pageContext.getAttribute(NavigatorApplicationIF.CONTEXT_KEY, PageContext.REQUEST_SCOPE);
       Collection result = (Collection) ctxt.getContextManager().getValue("pic");
       OccurrenceIF occ = (OccurrenceIF) result.iterator().next();

       String tempLoc = occ.getLocator().getAddress();
       int start = tempLoc.lastIndexOf("occurs");
       int stop = tempLoc.length();
       String descLoc = tempLoc.substring(start, stop);
    %>
    <p align="center"><img src="<%= descLoc %>" width="594">
  </logic:then>
  </logic:if>

  <logic:set name="located-in">
    <tm:lookup indicator="http://psi.ontopia.net/geography/located-in"/>
  </logic:set>

  <logic:set name="city-type">
    <tm:lookup indicator="http://psi.ontopia.net/geography/city"/>
  </logic:set>

  <logic:set name="country-type">
    <tm:lookup indicator="http://psi.ontopia.net/geography/country"/>
  </logic:set>

  <logic:set name="premiere-type">
    <tm:lookup indicator="http://psi.ontopia.net/opera/premiere"/>
  </logic:set>

  <logic:set name="city">
    <tm:filter instanceOf="city-type">
      <tm:associated from="topic" type="located-in"/>
    </tm:filter>
  </logic:set>

  <logic:set name="country">
    <tm:filter instanceOf="country-type">
      <tm:associated from="city" type="located-in"/>
    </tm:filter>
  </logic:set>

  <logic:set name="premieres">
    <tm:associated from="topic" type="premiere-type"/>
  </logic:set>

   <p><output:name of="topic"/> is located in
     <logic:if name="city">
     <logic:then>
       <a href="city-region.jsp?id=<output:id/>"><output:name/></a>
       <logic:if name="country">
       <logic:then>
         <a href="country.jsp?id=<output:id/>">(<output:name/>)</a>
       </logic:then>
       </logic:if>
     </logic:then>
     <logic:else>
       [unknown location]
     </logic:else>
     </logic:if>

     <logic:if name="premieres">
     <logic:then>
     and hosted the first perfomance of the following opera(s):
     <ul>
       <logic:foreach name="premieres" set="opera">
         <li><a href="opera.jsp?id=<output:id/>"><output:name/></a></li>
       </logic:foreach>
     </ul>
     </logic:then>
     </logic:if>

    <logic:set name="homepage">
      <tm:lookup indicator="http://psi.ontopia.net/opera/homepage"/>
    </logic:set>
    <logic:set name="homepages">
      <tm:filter instanceOf="homepage"><tm:occurrences of="topic"/></tm:filter>
    </logic:set>

    <logic:if name="homepages">
      <logic:then>
        <p>Other sites:
        <ul>
        <logic:foreach name="homepages">
    <li><a href="<output:locator/>"><output:locator/></a></li>
  </logic:foreach>
  </ul>
</logic:then>
</logic:if>
</template:put>
</template:insert>
</logic:context>
