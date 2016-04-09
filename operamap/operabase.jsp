<%@ page import="
    java.net.*,
    java.util.Calendar,
    java.util.ArrayList,
    java.util.Collection,
    java.io.InputStream,
    net.ontopia.topicmaps.nav2.plugins.URLRead,
    net.ontopia.topicmaps.nav2.core.*,
    net.ontopia.topicmaps.core.*,
    net.ontopia.utils.CollectionUtils,
    net.ontopia.utils.StringUtils"
%>
<%@ taglib uri='/WEB-INF/jsp/nav2-logic.tld'    prefix='logic'    %>
<%@ taglib uri='/WEB-INF/jsp/nav2-output.tld'   prefix='output'   %>
<%@ taglib uri='/WEB-INF/jsp/nav2-value.tld'    prefix='value'    %>
<%@ taglib uri='/WEB-INF/jsp/nav2-TMvalue.tld'  prefix='tm'       %>
<%@ taglib uri='/WEB-INF/jsp/nav2-template.tld' prefix='template' %>

<logic:context topicmap="opera.ltm" settm="topicmap">
<template:insert template='template.jsp'>

  <template:put name="content" body="true">
<%



    Calendar today = Calendar.getInstance();
    StringBuffer query = new StringBuffer("http://www.operabase.org/oplist.cgi?from=");

    // Append todays date.
    query.append(today.get(today.DAY_OF_MONTH));
    int month = today.get(today.MONTH);
    switch (month) {
    case 0:  query.append(".Jan."); break;
    case 1:  query.append(".Feb."); break;
    case 2:  query.append(".Mar."); break;
    case 3:  query.append(".Apr."); break;
    case 4:  query.append(".May."); break;
    case 5:  query.append(".Jun."); break;
    case 6:  query.append(".Jul."); break;
    case 7:  query.append(".Aug."); break;
    case 8:  query.append(".Sep."); break;
    case 9:  query.append(".Okt."); break;
    case 10: query.append(".Nov."); break;
    case 11: query.append(".Des."); break;
    }
    query.append(today.get(today.YEAR));

    // Append the correct topictype
    if (request.getParameter("composer") != null) {
      query.append("&by=");
      query.append(URLEncoder.encode(request.getParameter("composer")));
    }
    if (request.getParameter("opera") != null) {
      query.append("&is=");
      query.append(URLEncoder.encode(request.getParameter("opera")));
    }
    if (request.getParameter("location") != null) {
      query.append("&loc=");
      query.append(URLEncoder.encode(request.getParameter("location")));
    }

    query.append("&near=0&full=y&sort=");

    if (request.getParameter("sort") != null)
      query.append(URLEncoder.encode(request.getParameter("sort")));
    else
      query.append("V");


//    Sort order :
//
//    V = City
//    G = Country
//    C = Composer
//    T = Title
//    D = Date


   StringBuffer tempresult = new StringBuffer();
   String retur = StringUtils.replace(URLRead.read(query.toString()),
                                      "<a href=\"/", "<a href=\"http://www.operabase.org/");

%>

    <%= retur %>

  </template:put>

</template:insert>
</logic:context>
