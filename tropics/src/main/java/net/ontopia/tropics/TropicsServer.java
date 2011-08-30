package net.ontopia.tropics;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import net.ontopia.topicmaps.entry.TopicMapRepositoryIF;
import net.ontopia.topicmaps.entry.TopicMaps;

import org.restlet.Component;
import org.restlet.data.Protocol;

public class TropicsServer {

  /* DEFAULTS */
  private static final int    DEFAULT_PORT    = 8182;
  private static final String DEFAULT_ADDRESS = "localhost";

  /* RESTLET */
  private final Component component;
  private final TropicsApplicationV1 tropicsApplicationV1;
  
  /**
   * @param args
   * @throws Exception
   */
  public static void main(String[] args) throws Exception {
    String propertiesFilename = (args.length > 0) ? args[0] : null;

    TropicsServer server = TropicsServer.create(propertiesFilename);
    server.start();
  }

  public static TropicsServer create(String propertiesFilename) {
    int port = DEFAULT_PORT;
    String address = DEFAULT_ADDRESS;

    if (propertiesFilename != null) {
      try {
        Properties tropicsProperties = new Properties();

        InputStream istream = new FileInputStream(propertiesFilename);
        tropicsProperties.load(istream);

        port = Integer.parseInt(tropicsProperties.getProperty("net.ontopia.tropics.Port"));
        address = tropicsProperties.getProperty("net.ontopia.tropics.Address");
      } catch (IOException e) {
        e.printStackTrace();
        return null;
      }
    }

    // Create a new Topic Maps Repository.
    TopicMapRepositoryIF tmRepository = TopicMaps.getRepository();

    // Create a new Component.
    Component component = new Component();

    // Add a new HTTP server listening on address (def.: localhost) and port (def.: 8182).
    component.getServers().add(Protocol.HTTP, address, port);

    // Attach the sample application.
    TropicsApplicationV1 tropicsApplicationV1 = new TropicsApplicationV1(tmRepository);
    component.getDefaultHost().attach("/api/v1", tropicsApplicationV1);

    return new TropicsServer(component, tropicsApplicationV1);
  }

  private TropicsServer(Component component, TropicsApplicationV1 tropicsApplicationV1) {
    this.component = component;
    this.tropicsApplicationV1 = tropicsApplicationV1;
  }

  public void start() throws Exception {
    component.start();
  }

  public void stop() throws Exception {
    component.stop();
  }
  
  public void addRoute(String route, Class<?> resource) {
    tropicsApplicationV1.getRouter().attach(route, resource);
  }
}
