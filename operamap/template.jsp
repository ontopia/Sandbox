<%@ taglib uri='/WEB-INF/jsp/nav2-template.tld' prefix='template' %>
<%@ taglib uri='/WEB-INF/jsp/nav2-framework.tld' prefix='framework' %>
<html>
<head>
  <title>OperaMap: <template:get name='title'/></title>
  <meta http-equiv="content-type" content="text/html; charset=iso-8859-1">
  <link rel='stylesheet' href='operamap.css' />
  <script language="JavaScript" src="mouseover.js"></script>
</head>
<body onLoad="loaded=true;">
  <table class="mainTable" border='0' cellspacing='0' cellpadding='10'>
    <tr>
      <td colspan="2"><a href="index.jsp"><img src="graphics/scala-header.gif" border="0"></a></td>
    </tr>
    <tr>
      <td class="navCell" valign="top">
  <table border='0' cellspacing='0' cellpadding='0'>
          <% String reqURI = request.getRequestURI(); %>
    <tr><td><a href="operas.jsp"
  <% if (!isAct(reqURI,0)) { %>onMouseOver="over(0)" onMouseOut="out(0)"<% } %>><img
  name="operas" border="0" src="<%= getImg(reqURI, 0) %>" /></a></td></tr>
    <tr><td><a href="composers.jsp"
  <% if (!isAct(reqURI,1)) { %>onMouseOver="over(1)" onMouseOut="out(1)"<% } %>><img
  name="composers" border="0" src="<%= getImg(reqURI, 1) %>" /></a></td></tr>
    <tr><td><a href="librettists.jsp"
  <% if (!isAct(reqURI,2)) { %>onMouseOver="over(2)" onMouseOut="out(2)"<% } %>><img
  name="librettists" border="0" src="<%= getImg(reqURI, 2) %>" /></a></td></tr>
    <tr><td><a href="writers.jsp"
  <% if (!isAct(reqURI,3)) { %>onMouseOver="over(3)" onMouseOut="out(3)"<% } %>><img
  name="writers" border="0" src="<%= getImg(reqURI, 3) %>" /></a></td></tr>
    <tr><td><a href="theatres.jsp"
  <% if (!isAct(reqURI,4)) { %>onMouseOver="over(4)" onMouseOut="out(4)"<% } %>><img
  name="theatres" border="0" src="<%= getImg(reqURI, 4) %>" /></a></td></tr>
    <tr><td><a href="cities-regions.jsp"
  <% if (!isAct(reqURI,5)) { %>onMouseOver="over(5)" onMouseOut="out(5)"<% } %>><img
  name="cities-regions" border="0" src="<%= getImg(reqURI, 5) %>" /></a></td></tr>
    <tr><td><a href="countries.jsp"
  <% if (!isAct(reqURI,6)) { %>onMouseOver="over(6)" onMouseOut="out(6)"<% } %>><img
  name="countries" border="0" src="<%= getImg(reqURI, 6) %>"/></a></td></tr>
    <tr><td>&nbsp;</td></tr>
    <tr><td>&nbsp;</td></tr>
    <tr><td>&nbsp;</td></tr>
    <tr><td>
      <table class="searchBox" width="100%"><tr><td align="center">
        <% String q = request.getParameter("query");
                 if (q == null) q = ""; %>
              <form method=post action="search.jsp">
                <input type="text" name="query" value="<%=q%>" size="13">
                <input type="submit" value="search">
              </form></td></tr></table>
    </td></tr>
    <tr><td>&nbsp;</td></tr>
    <tr><td>&nbsp;</td></tr>
    <tr><td>&nbsp;</td></tr>
    <tr><td><a href="about.jsp"
  <% if (!isAct(reqURI,7)) { %>onMouseOver="over(7)" onMouseOut="out(7)"<% } %>><img
  name="about" border="0" src="<%= getImg(reqURI,7) %>"/></a></td></tr>
  </table>
</td>
<td class="contentCell" valign="top">
  <table width="600"><tr><td>
    <template:get name='content'/>
  </td></tr><tr><td>
  <template:get name='biography'/>
  </td></tr></table>
</td>
    </tr>
  </table>
<table width="872">
<tr>
<td><template:get name='footer'/></td>
</tr>
</table>
</body>
</html>



<%!
  // ------------------------------------------------------
  /**
   * INTERNAL: Helper method for retrieving the proper
   * image name for the current page
   */
  public final boolean isAct(String reqURI, int i) {
    String page = reqURI.substring(reqURI.lastIndexOf("/")+1);
    switch (i) {
    case 0:
      return (page.indexOf("opera") != -1);
    case 1:
      return (page.indexOf("composer") != -1);
    case 2:
      return (page.indexOf("librettist") != -1);
    case 3:
      return (page.indexOf("writer") != -1);
    case 4:
      return (page.indexOf("theatre") != -1);
    case 5:
      return (page.indexOf("city-region") != -1 || page.indexOf("cities-regions") != -1);
    case 6:
      return (page.indexOf("country") != -1 || page.indexOf("countries") != -1);
    case 7:
      return (page.indexOf("about") != -1);
    }
    return false;
  }

  public final String getImg(String reqURI, int i) {
  String base = "graphics/";
  String extN = ".png";
  String extA = "-Act.png";

  switch (i) {
  case 0:
    if (isAct(reqURI, i)) return base + "operas" + extA;
    else return base + "operas" + extN;
  case 1:
    if (isAct(reqURI, i)) return base + "composers" + extA;
    else return base + "composers" + extN;
  case 2:
    if (isAct(reqURI, i)) return base + "librettists" + extA;
    else return base + "librettists" + extN;
  case 3:
    if (isAct(reqURI, i)) return base + "writers" + extA;
    else return base + "writers" + extN;
  case 4:
    if (isAct(reqURI, i)) return base + "theatres" + extA;
    else return base + "theatres" + extN;
  case 5:
    if (isAct(reqURI, i)) return base + "cities-regions" + extA;
    else return base + "cities-regions" + extN;
  case 6:
    if (isAct(reqURI, i)) return base + "countries" + extA;
    else return base + "countries" + extN;
  case 7:
    if (isAct(reqURI, i)) return base + "about" + extA;
    else return base + "about" + extN;
  }
  return "[Error: cannot resolve image name " + reqURI + "]";
  }
%>
