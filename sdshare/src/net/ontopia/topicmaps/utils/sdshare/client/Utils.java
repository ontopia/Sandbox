
package net.ontopia.topicmaps.utils.sdshare.client;

import javax.servlet.http.HttpServletRequest;

public class Utils {

  public static String getWebappName(HttpServletRequest request) {
    // we need a unique name for this webapp instance. using first part
    // of document path inside server.
    String url = request.getRequestURL().toString();
    int lastslash = url.lastIndexOf('/');
    int secondlast = url.lastIndexOf('/', lastslash - 1);

    if (secondlast < 7) // means we're looking at http://
      return "ROOT";
    else
      return url.substring(secondlast + 1, lastslash);
  }

  public static int getLinkScore(AtomLink link) {
    MIMEType mimetype = link.getMIMEType();
    if (mimetype == null)
      return 0;
    if (!mimetype.getType().equals("application/x-tm+xml"))
      return 0; // we support only XTM at the moment

    if (mimetype.getVersion() == null)
      return 1; // don't know what version, so use only if necessary
    else if (mimetype.getVersion().equals("1.0"))
      return 2; // doesn't support name types, so not preferred
    else if (mimetype.getVersion().equals("2.0"))
      return 99; // has everything, so this is fine
    else if (mimetype.getVersion().equals("2.1"))
      return 100; // best support for fragments, so prefer this
    else
      return 0; // unknown version, so we don't dare to use it
  } 
}