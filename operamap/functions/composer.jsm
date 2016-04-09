
<module>

<function name="composer_function" params="topic">
<p>Italian composer<tolog:if query='
  instance-of(%topic%, librettist)?'> and <output:element name="a"><output:attribute
  name="href"><output:link of="topicmap" template="librettist.jsp?id="/><tolog:id
  var="topic"/></output:attribute>librettist</output:element></tolog:if>.
Born <tolog:out query='date-of-birth(%topic%, $out)?'/> in <tolog:set
  query='born-in(%topic% : person, $place : place)?'/><output:element
  name="a"><output:attribute name="href"><output:link of="topicmap"
  template="city-region.jsp?id="/><tolog:id
  var="place"/></output:attribute><tolog:out var="place"/></output:element>;
died <tolog:out query='date-of-death(%topic%, $out)?'/> in <tolog:set
  query='died-in(%topic% : person, $place : place)?'/><output:element
  name="a"><output:attribute name="href"><output:link of="topicmap"
  template="city-region.jsp?id="/><tolog:id
  var="place"/></output:attribute><tolog:out var="place"/></output:element>.</p>
<!-- Description -->
<tolog:if query='descr(%topic%, $description)?'><p><tolog:out
  var="description"/></p></tolog:if>
<!-- Notes -->
<tolog:foreach query='note(%topic%, $note)?'><p><i>Note: <tolog:out
  var="note"/></i></p></tolog:foreach>
<p><b>Operas:</b></p>
<ul>
<tolog:foreach query='
  composed-by($opera : work, %topic% : composer),
  premiere-date($opera, $date)
  order by $date?'><li><output:element
  name="a"><output:attribute name="href"><output:link of="topicmap"
  template="opera.jsp?id="/><tolog:id var="opera"/></output:attribute><output:name
  of="opera" basenameScope="topic"/></output:element>&#x00a0;&#x00a0;&#x00a0;(<tolog:out
  var="date"/>)</li>
  </tolog:foreach></ul>
<!-- Websites -->
<tolog:if query='
  website(%topic%, $web)? order by $web?'><p><b>Web sites:</b></p>
  <ul>
  <tolog:foreach query='
  website(%topic%, $web)?
  order by $web?'><li><output:element name="a"><output:attribute
  name="href"><tolog:out var="web"/></output:attribute><tolog:out var="web"/></output:element></li>
  </tolog:foreach></ul></tolog:if>
<!-- Web pages -->
<tolog:if query='
  webpage(%topic%, $web)?'><p><b>Web pages:</b></p>
  <ul>
  <tolog:foreach query='
  webpage(%topic%, $web)?
  order by $web?'><li><output:element name="a"><output:attribute
  name="href"><tolog:out var="web"/></output:attribute><tolog:out var="web"/></output:element></li>
  </tolog:foreach></ul></tolog:if>
<!-- Bibliography -->
<tolog:if query='
  bibref(%topic%, $bib)?'><p><b>Bibliography:</b></p>
  <ul>
  <tolog:foreach query='
  bibref(%topic%, $bib)
  order by $bib?'><li><tolog:out var="bib"/></li>
  </tolog:foreach></ul></tolog:if>
</function>

</module>
