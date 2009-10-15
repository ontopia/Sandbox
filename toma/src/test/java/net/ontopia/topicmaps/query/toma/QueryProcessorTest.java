package net.ontopia.topicmaps.query.toma;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import net.ontopia.topicmaps.core.TopicIF;
import net.ontopia.topicmaps.query.core.InvalidQueryException;
import net.ontopia.topicmaps.query.impl.basic.QueryMatches;

@SuppressWarnings("unchecked")
public class QueryProcessorTest extends AbstractTomaQueryTestCase {
  
  public QueryProcessorTest(String name) {
    super(name);
  }

  /// context management

  public void setUp() {
    QueryMatches.initialSize = 1;
  }

  public void tearDown() {
    closeStore();
  }

  /// column bound tests
  
  public void testTwoColumnsBound() throws InvalidQueryException, IOException {
    load("full.ltm");

    List matches = new ArrayList();
    TopicIF t = getTopicById("tn");
    addMatch(matches, "$T", t, "$T.NAME", t.getTopicNames().iterator().next());
    t = getTopicById("lmg");
    addMatch(matches, "$T", t, "$T.NAME", t.getTopicNames().iterator().next());
    
    verifyQuery(matches, "select $t, $t.name where $t.type = person;");
  }

  public void testTwoColumnsUnbound() throws InvalidQueryException, IOException {
    load("full.ltm");

    List matches = new ArrayList();
    TopicIF ltm = getTopicById("ltm");
    TopicIF xtm = getTopicById("xtm");
    Object tn = getTopicById("tn").getTopicNames().iterator().next();
    Object lmg = getTopicById("lmg").getTopicNames().iterator().next();
    
    addMatch(matches, "$T", ltm, "$P.NAME", tn);
    addMatch(matches, "$T", ltm, "$P.NAME", lmg);
    addMatch(matches, "$T", xtm, "$P.NAME", tn);
    addMatch(matches, "$T", xtm, "$P.NAME", lmg);
    
    verifyQuery(matches,
        "select $t, $p.name where $t.type = format and $p.type = person;");
  }
  
  public void testThreeColumnsMixed() throws InvalidQueryException, IOException {
    load("full.ltm");

    List matches = new ArrayList();
    TopicIF ltm = getTopicById("ltm");
    Object ltmName = ltm.getTopicNames().iterator().next();
    TopicIF xtm = getTopicById("xtm");
    Object xtmName = xtm.getTopicNames().iterator().next();
    Object tn = getTopicById("tn").getTopicNames().iterator().next();
    Object lmg = getTopicById("lmg").getTopicNames().iterator().next();
    
    addMatch(matches, "$T", ltm, "$T.NAME", ltmName, "$P.NAME", tn);
    addMatch(matches, "$T", ltm, "$T.NAME", ltmName, "$P.NAME", lmg);
    addMatch(matches, "$T", xtm, "$T.NAME", xtmName, "$P.NAME", tn);
    addMatch(matches, "$T", xtm, "$T.NAME", xtmName, "$P.NAME", lmg);
    
    verifyQuery(matches,
        "select $t, $t.name, $p.name where $t.type = format and $p.type = person;");
  }
  
  /// limit and offset tests
  
  public void testLimit() throws InvalidQueryException, IOException {
    load("family.ltm");

    List matches = new ArrayList();
    addMatch(matches, "$T", getTopicById("asle"));
    addMatch(matches, "$T", getTopicById("edvin"));
    addMatch(matches, "$T", getTopicById("kfg"));
    
    verifyQueryOrder(matches, "select $t where $t.type = father order by 1 limit 3;");
  }
  
  public void testOffset() throws InvalidQueryException, IOException {
    load("family.ltm");

    List matches = new ArrayList();
    addMatch(matches, "$T", getTopicById("edvin"));
    addMatch(matches, "$T", getTopicById("kfg"));
    
    verifyQueryOrder(matches, "select $t where $t.type = father order by 1 limit 2 offset 1;");
  }
}
