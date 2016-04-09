<%@ page language="java"
    import="
      java.util.*,
      java.io.*,
      net.ontopia.topicmaps.entry.*,
      net.ontopia.topicmaps.core.*,
      net.ontopia.topicmaps.nav2.core.*,
      net.ontopia.topicmaps.nav2.utils.FrameworkUtils,
      net.ontopia.infoset.fulltext.core.*,
      net.ontopia.infoset.fulltext.impl.lucene.*,
      net.ontopia.infoset.fulltext.topicmaps.*,
      net.ontopia.topicmaps.nav.utils.comparators.TopicMapReferenceComparator"
      %>

<%@ taglib uri='/WEB-INF/jsp/nav2-logic.tld'     prefix='logic'     %>
<%@ taglib uri='/WEB-INF/jsp/nav2-template.tld'  prefix='template'  %>
<%@ taglib uri='/WEB-INF/jsp/nav2-framework.tld' prefix='framework' %>

<logic:context topicmap="opera.ltm" settm="topicmap">

<%

  NavigatorApplicationIF navApp = (NavigatorApplicationIF) application
                                  .getAttribute(NavigatorApplicationIF.NAV_APP_KEY);
  NavigatorConfigurationIF navConf = navApp.getConfiguration();
  UserStoreRegistry uregistry = navApp.getUserStoreRegistry();
  TopicMapRepositoryIF repository = uregistry.getStoreRegistry().getRepository();

  // ---------------------------------------------------------------
  // deal with actions
  String report = "";
  String action = (String) request.getParameter("action");
  String id = (String) request.getParameter("id");

  // check action
  if (action != null) {
    // Registry-based actions
    if (id != null && !id.equals("")) {
      String path = FrameworkUtils.getAbsoluteFileName("WEB-INF/indexes/" + id, pageContext);

      // === delete index
      if (action.equals("delete index") || action.equals("reindex")) {
    try {
      File file = new File(path);
      File[] files = file.listFiles();
          if (files != null) {
        // First delete all the files in the directory.
        for (int i = 0; i < files.length; i++) {
          files[i].delete();
        }
          }
          // Then delete the directory
      if (!file.delete()) report = "Could not delete index";
          else report = "Deleted the index for: " + id + "<br>";
        } catch (Exception e){
      report = "Failed to delete index: " + id + "<br>" +
           "<span class=error>" + e.getMessage() + "</span>";
    }
      }

      // === create new index
      if (action.equals("create index") || action.equals("reindex")) {
    try {
          // Create a Lucene indexer
          IndexerIF lucene_indexer = new LuceneIndexer(path, true);

          // Creates an instance of the default topic map indexer.
          DefaultTopicMapIndexer imanager = new DefaultTopicMapIndexer(lucene_indexer, false, "");

          TopicMapIF topicmap = navApp.getTopicMapById(id);

          // Indexes the topic map
          imanager.index(topicmap);

          // Close index manager
          imanager.close();
          report = "Indexed " + id + ".";
    }
    catch (java.lang.Exception e) {
      report = "Failed to index: " + id + "<br>" +
           "<span class=error>" + e.getMessage() + "</span>";
    }
      }

      // === check that action is valid
      if (!action.equals("delete index") &&
          !action.equals("create index") &&
          !action.equals("reindex")) {
    report = "Unrecognized action for an ID.";
      }
    } else {
      report = "Id not supplied for action.";
    }
  }

  %>


  <template:insert template='template.jsp'>
    <template:put name='title' body='true'>Full-text Index Administration</template:put>


    <template:put name='content' body='true'>

      <table cellpadding="5" cellspacing="0" border="0">
      <tr>
      <td colspan="3"></td>
      <td colspan="2" align="center" valign="middle">
      </td>
      </tr>

      <tr><td colspan="5"></td></tr>

      <%
        //Get the indexed topicmaps.
        String pathstr = FrameworkUtils.getAbsoluteFileName("WEB-INF/indexes", pageContext);
        File path = new File(pathstr);
        if (!path.exists())
      path.mkdir();
        Collection indexes = new ArrayList();
        File[] files = path.listFiles();
        if (files != null) {
      for (int i = 0; i < files.length; i++) {
        File index = files[i];
        indexes.add(index.getName());
      }
        }
        // get the refs
        Collection refs = repository.getReferences();
        if (!refs.isEmpty()) {
          List sortedRefs = new ArrayList(refs);
          Collections.sort(sortedRefs,new TopicMapReferenceComparator());

      Iterator iter = sortedRefs.iterator();
      while (iter.hasNext()) {
        TopicMapReferenceIF reference = (TopicMapReferenceIF)iter.next();
        String _id=reference.getId();
        String _title=reference.getTitle();

        if (indexes.contains(_id)) { %>
          <tr valign="middle">
          <td><img src="graphics/indexed.gif" alt="[Indexed]" title="Indexed" hspace="2"/></td>
          <td class="small"><strong><%= _title %></strong></td>
          <td>&nbsp;</td>
          <td>
        <form method="post" action="admin.jsp">
          <input type="submit" value=" Delete index " style="font-size:10px">
          <input type="hidden" name="action" value="delete index">
          <input type="hidden" name="id" value="<%=_id%>">
        </form>
          </td>
          <td>&nbsp;</td>
          <td>
        <form method="post" action="admin.jsp">
          <input type="submit" value=" Reindex " style="font-size:10px">
          <input type="hidden" name="action" value="reindex">
          <input type="hidden" name="id" value="<%=_id%>">
        </form>
          </td>
          <td width="100%">&nbsp;</td>
          </tr>
        <% } else { %>
          <tr valign="middle">
          <td><img src="graphics/index-missing.gif" alt="[No index]" title="No index" hspace="2" /></td>
          <td class="small"><strong><%= _title %></strong></td>
          <td>&nbsp;</td>
          <td class="small">
            <form method="post" action="admin.jsp">
          <input type="submit" value=" Create index " style="font-size:10px">
          <input type="hidden" name="action" value="create index">
          <input type="hidden" name="id" value="<%=_id%>">
            </form>
          </td>
          </tr>
        <% } %>
        <tr><td colspan="5"></td></tr>
          </tr>
       <% } %>
      </table>
      <% } else { %>
          <p>No topic maps found.</p>
          <p align="center">The directory does not contain any topic
          maps or pointers to any topic maps. Put your topic maps
          (with the file extension .xtm, .iso or .ltm) in this
          directory or update the configuration in the
          &lt;web-application&gt;/WEB-INF/config/tm-sources.xml file.</p>
          <% } %>

      <p>
      This page can be used to administrate the full-text indexes of your
      topic maps. Here you can create new indexes for topic maps, delete
      already existing indexes, and re-index topic maps. Below are
      explained the icons used to represent the states of the indexes.
      </p>

      <table>
      <tr><td><img src="graphics/indexed.gif">
          <td>Indexed
      <!--tr><td><img src="graphics/index-not-in-sync.gif">
          <td>Index out of date-->
      <tr><td><img src="graphics/index-missing.gif">
          <td>Not indexed
      </table>

      <br>

      <% if (!report.equals("")) { %>
        <table border="1" width="100%" cellpadding="10"><tr><td>
          <h3>Report</h3>
          <%= report %>
        </td></tr></table>
      <% } else { %>
        <hr />
      <% } %>

    </template:put>

  </template:insert>
</logic:context>
