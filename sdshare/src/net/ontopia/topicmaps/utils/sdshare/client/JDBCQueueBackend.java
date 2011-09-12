
package net.ontopia.topicmaps.utils.sdshare.client;

import java.util.List;
import java.util.Properties;
import java.io.IOException;
import java.sql.Driver;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.SQLException;

import com.hp.hpl.jena.rdf.arp.AResource;
import com.hp.hpl.jena.rdf.arp.ALiteral;
import com.hp.hpl.jena.rdf.arp.StatementHandler;

import net.ontopia.utils.OntopiaRuntimeException;
import net.ontopia.topicmaps.utils.rdf.RDFUtils;

/**
 * INTERNAL: Backend which stores list of changed URIs in a database
 * via JDBC so that another process can get them from there.
 *
 * <p>The handle is the JDBC URI. Configuration properties:
 * driver-class, username, password, and database (ie: which kind of
 * database). Only H2 and Oracle supported for now.
 */
public class JDBCQueueBackend extends AbstractBackend
  implements ClientBackendIF {
  //static Logger log = LoggerFactory.getLogger(JDBCQueueBackend.class.getName());
  
  public void loadSnapshot(SyncEndpoint endpoint, Snapshot snapshot) {
    InsertHandler handler = new InsertHandler(endpoint);
    try {
      // FIXME: should we delete contents first?
      String sourceuri = snapshot.getSnapshotURI();
      RDFUtils.parseRDFXML(sourceuri, handler);
      handler.close();
    } catch (IOException e) {
      throw new OntopiaRuntimeException(e);
    }
  }

  public void applyFragments(SyncEndpoint endpoint, List<Fragment> fragments) {
    DatabaseType dbtype = getDBType(endpoint);
    Statement stmt = getConnection(endpoint);
    try {
      try {
        for (Fragment f : fragments)
          writeResource(stmt,
                        f.getTopicSIs().iterator().next(),
                        findPreferredLink(f.getLinks()).getUri(),
                        dbtype);
        stmt.getConnection().commit();
      } finally {
        stmt.close();
      }
    } catch (SQLException e) {
      throw new RuntimeException(e);
    }
  }

  private void writeResource(Statement stmt, String topicsi, String datauri,
                             DatabaseType dbtype)
    throws SQLException {
    String idvalue;
    if (dbtype == DatabaseType.H2)
      idvalue = "NULL";
    else
      idvalue = "resource_seq.nextval";
    
    stmt.executeUpdate("insert into UPDATED_RESOURCES values (" +
                       "  " + idvalue + ", '" + escape(topicsi) + "', '" +
                       escape(datauri) + "')");
  }

  public int getLinkScore(AtomLink link) {
    MIMEType mimetype = link.getMIMEType();
    // FIXME: this is too simplistic. we could probably support more
    // syntaxes than just this one, but for now this will have to do.
    if (mimetype.getType().equals("application/rdf+xml"))
      return 100;
    return 0;
  }

  private Statement getConnection(SyncEndpoint endpoint) {
    String jdbcuri = endpoint.getHandle();
    String driverklass = endpoint.getProperty("driver-class");
    String username = endpoint.getProperty("username");
    String password = endpoint.getProperty("password");
    
    try {
      Class driverclass = Class.forName(driverklass);
      Driver driver = (Driver) driverclass.newInstance();
      Properties props = new Properties();
      if (username != null)
        props.put("user", username);
      if (password != null)
        props.put("password", password);
      Connection conn = driver.connect(jdbcuri, props);
      Statement stmt = conn.createStatement();
      
      // check that tables exist & create if not
      verifySchema(stmt, getDBType(endpoint));
      
      return stmt;
    } catch (SQLException e) {
      throw new RuntimeException(e);
    } catch (ClassNotFoundException e) {
      throw new RuntimeException(e);
    } catch (InstantiationException e) {
      throw new RuntimeException(e);
    } catch (IllegalAccessException e) {
      throw new RuntimeException(e);
    }
  }

  private void verifySchema(Statement stmt, DatabaseType dbtype)
    throws SQLException {
    String tablename;
    if (dbtype == DatabaseType.H2)
      tablename = "information_schema.tables";
    else if (dbtype == DatabaseType.ORACLE)
      tablename = "all_tables";
    else
      throw new OntopiaRuntimeException("Unknown database type: " + dbtype);
    
    ResultSet rs = stmt.executeQuery("select * from " + tablename + " where " +
                                     "table_name = 'UPDATED_RESOURCES'");
    boolean present = rs.next();
    rs.close();

    if (present)
      return;

    if (dbtype == DatabaseType.H2)
      stmt.executeUpdate("create table UPDATED_RESOURCES ( " +
                         "  id int auto_increment primary key, " +
                         "  uri varchar not null, " +
                         "  fragment_uri varchar )");
    else if (dbtype == DatabaseType.ORACLE) {
      // first we must create a sequence, so we can get autoincrement
      stmt.executeUpdate("create sequence resource_seq " +
                         "start with 1 increment by 1 nomaxvalue");

      // then we can create the table
      stmt.executeUpdate("create table UPDATED_RESOURCES ( " +
                         "  id int not null, " +
                         "  uri varchar(200) not null, " +
                         "  fragment_uri(400) varchar, " +
                         "CONSTRAINT updated_pk PRIMARY KEY (id))");
    }
  }

  private String escape(String strval) {
    return strval.replace("'", "''");
  }

  // ===== Writing INSERT-format triples

  public class InsertHandler implements StatementHandler {
    private Statement stmt;
    private DatabaseType dbtype;
    
    public InsertHandler(SyncEndpoint endpoint) {
      this.stmt = getConnection(endpoint);
      this.dbtype = getDBType(endpoint);
    }

    public void statement(AResource sub, AResource pred, ALiteral lit) {
      try {
        // FIXME: this doesn't handle blank nodes
        writeResource(stmt, sub.getURI(), null, dbtype);
      } catch (SQLException e) {
        throw new RuntimeException(e);
      }
    }

    public void statement(AResource sub, AResource pred, AResource obj) {
      try {
        // FIXME: this doesn't handle blank nodes
        writeResource(stmt, sub.getURI(), null, dbtype);
      } catch (SQLException e) {
        throw new RuntimeException(e);
      }
    }
     
    public void close() {
      try {
        stmt.getConnection().commit();
        stmt.close();
      } catch (SQLException e) {
        throw new RuntimeException(e);
      }
    }
  }
 
  // ===== ENUM FOR DATABASE TYPE

  private static DatabaseType getDBType(SyncEndpoint endpoint) {
    return getDBType(endpoint.getProperty("database"));
  }
  
  private static DatabaseType getDBType(String dbtype) {
    if (dbtype.equals("h2"))
      return DatabaseType.H2;
    else if (dbtype.equals("oracle"))
      return DatabaseType.ORACLE;
    else
      throw new OntopiaRuntimeException("Unknown database type: " + dbtype);
  }
  
  public enum DatabaseType {
    H2, ORACLE
  }
}