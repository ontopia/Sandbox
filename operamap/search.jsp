<%@ page language="java"
    import="
    java.io.*,
    java.util.*,
    java.net.URLEncoder,
    net.ontopia.utils.*,
    net.ontopia.topicmaps.core.*,
    net.ontopia.topicmaps.entry.*,
    net.ontopia.topicmaps.utils.*,
    net.ontopia.topicmaps.nav2.core.*,
    net.ontopia.topicmaps.nav2.impl.basic.*,
    net.ontopia.topicmaps.nav2.utils.FrameworkUtils,
    net.ontopia.infoset.fulltext.core.*,
    net.ontopia.topicmaps.nav2.plugins.PluginIF,
    net.ontopia.infoset.fulltext.impl.lucene.*"
%>

<%@ taglib uri='/WEB-INF/jsp/nav2-template.tld'  prefix='template'  %>
<%@ taglib uri='/WEB-INF/jsp/nav2-framework.tld' prefix='framework' %>
<%@ taglib uri='/WEB-INF/jsp/nav2-output.tld'    prefix='output'    %>
<%@ taglib uri='/WEB-INF/jsp/nav2-logic.tld'     prefix='logic'     %>
<%@ taglib uri='/WEB-INF/jsp/nav2-value.tld'     prefix='value'     %>
<%@ taglib uri='/WEB-INF/jsp/nav2-TMvalue.tld'   prefix='tm'        %>

<logic:context topicmap="opera.ltm" settm="topicmap">

  <template:insert template='template.jsp'>
    <template:put name='title' body='true'>[Operamap] Fulltext search</template:put>

    <template:put name='heading' body='true'>
      <h1 class="boxed">Fulltext search</h1>
    </template:put>


    <logic:set name="composer">
      <tm:lookup indicator="http://psi.ontopia.net/music/composer"/>
    </logic:set>

    <logic:set name="opera">
      <tm:lookup indicator="http://psi.ontopia.net/music/opera"/>
    </logic:set>

    <logic:set name="writer">
      <tm:lookup indicator="http://psi.ontopia.net/literature/writer"/>
    </logic:set>

    <logic:set name="librettist">
      <tm:lookup indicator="http://psi.ontopia.net/opera/librettist"/>
    </logic:set>

    <logic:set name="theatre">
      <tm:lookup indicator="http://psi.ontopia.net/literature/theatre"/>
    </logic:set>

    <logic:set name="country">
      <tm:lookup indicator="http://psi.ontopia.net/geography/country"/>
    </logic:set>

    <logic:set name="city">
      <tm:lookup indicator="http://psi.ontopia.net/geography/city"/>
    </logic:set>

    <logic:set name="region">
      <tm:lookup indicator="http://psi.ontopia.net/geography/region"/>
    </logic:set>


    <%
     NavigatorApplicationIF navApp = (NavigatorApplicationIF) application
       .getAttribute(NavigatorApplicationIF.NAV_APP_KEY);

     HashMap topictypes = new HashMap();
     topictypes.put("composer", "<a href='composers.jsp'>composer</a>");
     topictypes.put("librettist", "<a href='librettists.jsp'>librettist</a>");
     topictypes.put("writer", "<a href='writers.jsp'>writer</a>");
     topictypes.put("opera", "<a href='operas.jsp'>opera</a>");
     topictypes.put("country", "<a href='countries.jsp'>country</a>");
     topictypes.put("city", "<a href='cities-regions.jsp'>city</a>");
     topictypes.put("region", "<a href='cities-regions.jsp'>region</a>");
     topictypes.put("theatre", "<a href='theatres.jsp'>theatre</a>");

     String query = "";
     if (request.getParameter("query") != null) query = request.getParameter("query");
     String tmid = "opera.ltm";
     String path = pageContext.getServletContext().getRealPath("") +
       "/../omnigator/WEB-INF" + File.separator + "indexes" + File.separator + tmid;

     TopicMapIF topicmap = navApp.getTopicMapById(tmid);
     StringifierIF topic_stringifier = TopicStringifiers.getBaseNameStringifier(Collections.EMPTY_SET);


     NavigatorPageIF ctxt = (NavigatorPageIF) pageContext.getAttribute(NavigatorApplicationIF.CONTEXT_KEY, PageContext.REQUEST_SCOPE);

     Collection local_variable = (Collection) ctxt.getContextManager().getValue("composer");
     TopicIF composer = (TopicIF) local_variable.iterator().next();

     local_variable = (Collection) ctxt.getContextManager().getValue("writer");
     TopicIF writer = (TopicIF) local_variable.iterator().next();

     local_variable = (Collection) ctxt.getContextManager().getValue("librettist");
     TopicIF librettist = (TopicIF) local_variable.iterator().next();

     local_variable = (Collection) ctxt.getContextManager().getValue("theatre");
     TopicIF theatre = (TopicIF) local_variable.iterator().next();

     local_variable = (Collection) ctxt.getContextManager().getValue("opera");
     TopicIF opera = (TopicIF) local_variable.iterator().next();

     local_variable = (Collection) ctxt.getContextManager().getValue("city");
     TopicIF city = (TopicIF) local_variable.iterator().next();

     local_variable = (Collection) ctxt.getContextManager().getValue("country");
     TopicIF country = (TopicIF) local_variable.iterator().next();

     local_variable = (Collection) ctxt.getContextManager().getValue("region");
     TopicIF region = (TopicIF) local_variable.iterator().next();

     %>

  <template:put name="content" body="true">

    <%


    if (!(new File(path).exists())) {
      %> No index found in '<i><%= path %></i>'.<%
    }
    else if (!query.equals("")) {

      SearcherIF sengine = new LuceneSearcher(path);
      SearchResultIF result = sengine.search(query);
      Set topicsFound = new HashSet();
      %>

      <%-- p>Your search found <%= result.hits() %> hits.</p --%>

      <table width='100%' class=text>
      <tr>
        <th align='left' width='40%'>Topic</th>
        <th align='left'>Type</th>
        <th align='left'>Match in</th>
        <th align='left'>Score</th>
      </tr>
      <%
      int size = result.hits();
      for (int i=0; i < size; i++) {
        DocumentIF doc = result.getDocument(i);
        String klass = doc.getField("class").getValue();
        String object_id = doc.getField("object_id").getValue();

        TMObjectIF tmobject = topicmap.getObjectById(object_id);

        String title="&lt;none&gt;";
        String type = "";
        TopicIF topic = null;
        if (tmobject instanceof BaseNameIF) {
          topic = ((BaseNameIF)tmobject).getTopic();
          type = "basename";
        }
        else if (tmobject instanceof VariantNameIF) {
          topic = ((VariantNameIF)tmobject).getTopic();
          type = "variant";
        }
        else if (tmobject instanceof OccurrenceIF) {
          topic = ((OccurrenceIF)tmobject).getTopic();
          type = "occurrence";
        } else if (tmobject instanceof TopicIF) {
            topic = ((TopicIF)tmobject);
            type = "topic";
        }
        else if (tmobject instanceof FacetValueIF) {
          topic = ((FacetValueIF)tmobject).getFacet().getType();
          type = "facet value";
        } else {
          title = tmobject.toString();
          type = klass;
        }


        boolean found_link = false;
        String result_link = "&lt;none&gt;";
        String result_end = "'>";
        if (topic != null && topic.getTypes().size() > 0) {
          Collection types = topic.getTypes();
          if (types.contains(opera)) {
            result_link = "<a href='opera.jsp?id=";
            found_link = true;
          } else if (types.contains(composer)) {
            result_link = "<a href='composer.jsp?id=";
            found_link = true;
          } else if (types.contains(writer)) {
            result_link = "<a href='writer.jsp?id=";
            found_link = true;
          } else if (types.contains(librettist)) {
            result_link = "<a href='librettist.jsp?id=";
            found_link = true;
          } else if (types.contains(theatre)) {
            result_link = "<a href='theatre.jsp?id=";
            found_link = true;
          } else if (types.contains(city)) {
            result_link = "<a href='city-region.jsp?id=";
            found_link = true;
          } else if (types.contains(country)) {
            result_link = "<a href='country.jsp?id=";
            found_link = true;
          } else if (types.contains(region)) {
            result_link = "<a href='city-region.jsp?id=";
            found_link = true;
          }
        }


        if (topicsFound.contains(topic))
          continue;
        topicsFound.add(topic);

        %>

        <logic:set name="found">
          <tm:lookup objectid="<%= object_id %>"/>
        </logic:set>

        <logic:set name="topics">
          <tm:topics of="found"/>
        </logic:set>

        <%

        if (found_link) {
          title = result_link +  topic.getObjectId() + "'>" +
                  topic_stringifier.toString(topic) + "</a>";
        } else {
          title = topic_stringifier.toString(topic);
        }

        String output_type = "&lt;none&gt;";
        if (topic != null && topic.getTypes().size() > 0) {
          Iterator it = topic.getTypes().iterator();
          output_type = "";
          while (it.hasNext()) {
            TopicIF t_type = (TopicIF)it.next();
            String topic_type = topic_stringifier.toString(t_type);
            String value = (String)topictypes.get(topic_type);
            if (value == null) {
              output_type += topic_type + " | ";
            } else {
              output_type += value + " | ";
            }
          }
          output_type = output_type.substring(0, output_type.length()-3);
        }

        String content = "";
        if (doc.getField("content") == null &&
            doc.getField("address") != null) {
          String address = doc.getField("address").getValue();
          String _title = "<none>";

          if (tmobject instanceof OccurrenceIF) {
            if (((OccurrenceIF)tmobject).getType() != null)
              _title = topic_stringifier.toString(((OccurrenceIF)tmobject).getType());
          } else if (tmobject instanceof FacetValueIF) {
            if (((FacetValueIF)tmobject).getValue() != null)
              _title = topic_stringifier.toString(((FacetValueIF)tmobject).getValue());
          }

          content = "<a href='" + address + "'>" + _title + "</a>";
        }
        int score = (int)(result.getScore(i) * 100);
        out.write("<tr><td>" + title + "&nbsp;&nbsp;&nbsp;</td>" +
                  "<td>" + output_type + "&nbsp;&nbsp;&nbsp;</td>" +
                  "<td><i>" + type + " " + content + "</i></td>" +
                  "<td>" + score + "%</td></tr>\n");
      }
      out.write("</table>");
    }
    %>

  </template:put>
  </template:insert>
</logic:context>
