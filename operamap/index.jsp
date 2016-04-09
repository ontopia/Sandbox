<%@ page import="net.ontopia.topicmaps.nav2.core.*,
                 net.ontopia.topicmaps.core.OccurrenceIF,
                 net.ontopia.utils.CollectionUtils,
                 java.util.Collection"
%>
<%@ taglib uri='http://psi.ontopia.net/jsp/taglib/template' prefix='template'%>
<%@ taglib uri='http://psi.ontopia.net/jsp/taglib/tolog' prefix='tolog'%>

<%@ taglib uri='/WEB-INF/jsp/nav2-logic.tld'    prefix='logic'    %>
<%@ taglib uri='/WEB-INF/jsp/nav2-output.tld'   prefix='output'   %>
<%@ taglib uri='/WEB-INF/jsp/nav2-value.tld'    prefix='value'    %>
<%@ taglib uri='/WEB-INF/jsp/nav2-TMvalue.tld'  prefix='tm'       %>

<logic:context topicmap="opera.ltm" settm="topicmap">
<template:insert template='template.jsp'>

<template:put name='title' body='true'>
 <tolog:out query="select $topic from topicmap($tm), reifies($topic, $tm)?"/>
</template:put>

<template:put name='content' body='true'>

<tolog:set var="composers" query='
  instance-of($COMPOSER, i"http://psi.ontopia.net/music/composer")?'/>

<logic:set name="operas">
  <tm:instances>
    <tm:lookup indicator="http://psi.ontopia.net/music/opera"/>
  </tm:instances>
</logic:set>

<p><table width="595" cellspacing="0" cellpadding="4" border="0">
<tr valign="top">
<td width="75%">

<p align="center"><b>About this site</b></p>
<p>The purpose of this web site is to demonstrate the use of topic maps
to drive web portals. The application is being built using the <a
href="http://www.ontopia.net/solutions/engine.html">Ontopia Knowledge
Suite</a> and the <a
href="http://www.ontopia.net/solutions/navigator.html">Ontopia Navigator
Framework</a>. It is not yet finished and is therefore not publicly
available, so please do not publicise the URLs.</p>

<p>The web site contains no static HTML pages. Instead, every page
(including all the links it contains) is generated on the fly, based on
information contained in the underlying topic map. The topic map used
for this demo is the Italian Opera topic map that is distributed with
Ontopia's free topic map browser, the <a target="_blank"
href="http://www.ontopia.net/download/freedownload.html">Omnigator</a>.
This topic map (opera.ltm) can also be browsed in the <a target="_blank"
href="http://www.ontopia.net/omnigator/models/topicmap_complete.jsp?tm=opera.ltm">online
version</a> of the Omnigator.</p>

<p>The chief difference between the present application and the
Omnigator is that the latter is a <i>generic topic map browser</i>,
whereas this one is specific to the Italian Opera topic map:</p>

<p><b>The Omnigator</b> is designed to be "omnivorous" and to "make
reasonable sense out of any reasonably sensible topic map"! It therefore
cannot be optimised for any particular topic map ontology: It has to
essentially treat all topics equally. This makes the Omnigator very
useful as a general purpose topic map browser, and especially as a
teaching aid, but it places severe restrictions on the kind of interface
that can be devised and consequently on its "user-friendliness".</p>

<p><b>This OperaMap Application</b>, on the other hand, is built around
a known ontology - that of the Italian Opera topic map - and can
therefore make assumptions that cannot be made by a generic application.
Some of these will be described and documented on the <b>About</b> page
when the application has been completed.</p>
</td>
<td>
<!-- ==================================================================== -->
<!-- Display random opera -->
<!-- NB: Unfortunately we cannot include this from an external file because
it is not possible to flush inside a custom tag: here template:put -->
<table>
<tr><td align="center"><h3>Random Opera</h3></td></tr>
<tr><td align="center">
<tolog:set query='
  select $pictures from
  instance-of($TOPIC, opera),
  occurrence($TOPIC, $pictures),
  type($pictures, illustration)?'/>
<%
// choose random occurrence from variable "picture"
NavigatorPageIF ctxt = (NavigatorPageIF) pageContext.getAttribute(NavigatorApplicationIF.CONTEXT_KEY, PageContext.REQUEST_SCOPE);
Collection result = (Collection) ctxt.getContextManager().getValue("pictures");
OccurrenceIF occ = (OccurrenceIF) CollectionUtils.getRandom(result);
ctxt.getContextManager().setValue("randIllustration", occ);

String tempLoc = occ.getLocator().getAddress();
int start = tempLoc.lastIndexOf("occurs");
int stop = tempLoc.length();
String descLoc = tempLoc.substring(start, stop);
%>

<tolog:set var="topic" query='occurrence($topic, %randIllustration%)?'/>
<a href='opera.jsp?id=<tolog:id var="topic"/>'><img src="<%= descLoc %>" border=0 width="150"></a>
</td><tr>

<logic:set name="normal">
<tm:lookup indicator="http://psi.ontopia.net/basename/normal"/>
</logic:set>

<!-- Composer -->
<tolog:set query='composed-by(%topic% : work, $composer : composer)?'/>
<tr><td align="center">
<h2><a href='opera.jsp?id=<tolog:id var="topic"/>'><output:name of="topic" basenameScope="composers"/></a></h2>
</td></tr>
<tr><td align="center">Composed by <a href="composer.jsp?id=<output:id of='composer'/>"><output:name
of="composer" basenameScope="normal"/></a>

<!-- Librettist -->
<tolog:set query='
  libretto-by(%topic% : opera, $librettists : librettist)
  order by $librettists?'/>
<logic:if
    name="librettists"><logic:then>
    to a libretto by
    <logic:if name="librettists" lessThan="2">
    <logic:then>
    <a href="librettist.jsp?id=<output:id/>"><output:name basenameScope="normal"/></a>,
  </logic:then>
  <logic:else>
    <logic:if name="librettists" lessThan="3">
    <logic:then>
  <logic:foreach separator=" and "><a href="librettist.jsp?id=<output:id/>"><output:name
   basenameScope="normal"/></a></logic:foreach>,
    </logic:then>
    <logic:else>
  <logic:foreach separator=", ">
  <logic:if name="sequence-last"><logic:then>and</logic:then></logic:if>
  <a href="librettist.jsp?id=<output:id/>"><output:name basenameScope="normal"/></a></logic:foreach>,
    </logic:else>
    </logic:if>
  </logic:else>
  </logic:if>
  </logic:then>
</logic:if>

<!-- Premiere date -->
and first performed <tolog:foreach separator='and' query='
  premiere-date(%topic%, $date),
  premiere(%topic% : work, $place : place)?'> on
<tolog:out var="date"/> at <a href="theatre.jsp?id=<tolog:id var="place"/>"><tolog:out var="place"/></a>
</tolog:foreach></td></tr>
</table>
</td>
</tr>
</table>
</template:put>

<template:put name='footer' body='true'>
<table width="100%">
<tr>
<td colspan="4" align="center">Links to external opera resources:</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
<td align="center" width="150"><a href="http://opera.stanford.edu/opera/"><img
src="graphics/OperaGlass.gif" height="50" width="150"></a></td>
<!--td width="2">&nbsp;</td-->
<td align="center" width="150"><a href="http://operabase.com/en/"><img
src="graphics/OperaBase.jpg" height="50" width="150"></a></td>
<!--td width="2">&nbsp;</td-->
<td align="center" width="150"><a href="http://www.r-ds.com/"><img
src="graphics/operaresource.gif" height="50" width="150"></a></td>
<!--td width="2">&nbsp;</td-->
<!--td align="center" width="150"><a href="http://www.operanews.com/"><img
src="graphics/opera_news.gif" height="50" width="150"></a></td-->
<!--td width="2">&nbsp;</td-->
<td width="150"><a href="http://www.opera.it/Operaweb/en/home.html"><img
src="graphics/opera_web.gif" height="50" width="150"></a></td>
</tr>
<tr>
<td align="center" width="150">Rick Bogart's OperaGlass web site</td>
<!--td width="2">&nbsp;</td-->
<td align="center" width="150">Mike Gibb's performance database</td>
<!--td width="2">&nbsp;</td-->
<td align="center" width="150">Anne Lawson's OperaResource</td>
<!--td width="2">&nbsp;</td-->
<td align="center" width="150">The Italian OperaWeb site</td>
</tr>
</table>
</template:put>
</template:insert>
</logic:context>
