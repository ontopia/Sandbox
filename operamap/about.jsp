<%@ taglib uri='/WEB-INF/jsp/nav2-template.tld' prefix='template' %>
<%@ taglib uri='http://psi.ontopia.net/jsp/taglib/tolog' prefix='tolog'%>
<%@ taglib uri='/WEB-INF/jsp/nav2-logic.tld'    prefix='logic'    %>

<logic:context topicmap="opera.ltm" settm="topicmap">
<template:insert template='template.jsp'>

  <template:put name='title' body='true'>OperaMap: About page</template:put>

  <template:put name='content' body='true'>

<h1>Topic Maps as Information Architecture</h1>

<p>The purpose of the <b>OperaMap</b> web site is to demonstrate how
Topic Maps can be used as an information architecture in web delivery
applications.</p>

<p>The site is driven entirely by a topic map. What this means is
that:</p>

<ul>
<li>pages are not hand-coded (they are generated on-the-fly by
extracting information from the topic map);</li>
<li>the site is extremely <q>subject-centric</q> (each page corresponds
to a single topic and acts as a point of <q>colocation</q> for
everything that is known about that topic);</li>
<li>most links are not hand-coded (navigation paths between pages are
based on associations between topics);</li>
<li>the site is not organized hierarchically (instead, a rich
associative structure allows users to locate and discover information
from many possible directions).</li>
</ul>

<p>The topic map used for this site is the <i>Italian Opera Topic
Map</i>, which is distributed free along the <b>Omnigator</b> (Ontopia's
free Topic Maps browser). The topic map may also be browsed in the <u><a
href="http://www.ontopia.net/omnigator/models/topicmap_complete.jsp?tm=opera.ltm">online
version</a></u> of the <b>Omnigator</b>.</p>

<p>This article contrasts these two applications in order to convey an
understanding of the potential of topic map-driven web sites.</p>

<p>The chief difference between the present application and the
<b>Omnigator</b> is that the latter is a <i>generic</i> topic map
browser: it can be used with any conforming topic map; <b>OperaMap</b>,
on the other hand, is an application specific to the <i>Italian Opera
Topic Map</i> and cannot be used (at least not <q>as is</q> with other
topic maps.</p>

<p>The <b>Omnigator</b> is designed to be <q>omnivorous</q> and to
<q>make reasonable sense out of any reasonably sensible topic map</q>!
It therefore cannot be optimised for any particular topic map ontology:
It has to essentially treat all topics equally. This makes the
<b>Omnigator</b> very useful as a general purpose topic map browser,
especially for prototyping and as a teaching aid, but it places certain
restrictions on the kind of user interface that can be devised: this in
turn impacts <q>user-friendliness</q> and means that every topic map
looks pretty much the same. While this might be acceptable in a
prototype, it is clearly not desirable in a real world application.</p>

<p>In contrast, the <b>OperaMap</b> application has been built around a
known ontology &ndash; that of the Italian Opera topic map. It was
therefore possible to make assumptions that cannot be made by a generic
application.</p>

<h4>Welcome page</h4>

<p>@@@TBD</p>

<h4>Index pages</h4>

<p>@@@TBD</p>

<h4>Topic pages</h4>

<p>@@@TBD</p>

<%--
<ul>
<li>different types, different pages</li>
</ul>

<p><br/><br/><br/><br/><br/><br/>

<p>Like those applications, <i>OperaMap</i> was built using the
Ontopia Knowledge Suite and the Ontopia Navigator Framework.

<table><tolog:foreach groupBy= 'COMPOSER' query='
select $COMPOSER, $OPERA, $RECORDING from
  composed-by($OPERA : work, $COMPOSER : composer),
  not(audio-recording($OPERA, $RECORDING))
  order by $COMPOSER, $OPERA, $RECORDING?'>
<tr><td><b><tolog:out var="COMPOSER"/></b></td>
<tolog:foreach>
<tr><td></td><td><tolog:out var="OPERA"/><tolog:if query='
video-recording(%OPERA%, $video)?'> (*)</tolog:if></td></tr></tolog:foreach></tolog:foreach>
</table>
--%>

</template:put>

</template:insert>
</logic:context>

