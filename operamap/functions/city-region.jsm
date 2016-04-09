
<module>

  <function name="city-region_function" params="topic">


    <!-- SET ONTOLOGY VARIABLES -->
    <logic:set name="opera"><tm:lookup indicator="http://psi.ontopia.net/music/opera"/></logic:set>
    <logic:set name="country"><tm:lookup indicator="http://psi.ontopia.net/geography/country"/></logic:set>
    <logic:set name="theatre"><tm:lookup indicator="http://psi.ontopia.net/literature/theatre"/></logic:set>
    <logic:set name="composer"><tm:lookup indicator="http://psi.ontopia.net/music/composer"/></logic:set>
    <logic:set name="writer"><tm:lookup indicator="http://psi.ontopia.net/literature/writer"/></logic:set>
    <logic:set name="librettist"><tm:lookup indicator="http://psi.ontopia.net/music/librettist"/></logic:set>

    <logic:set name="normal"><tm:lookup indicator="http://psi.ontopia.net/basename/normal"/></logic:set>

    <logic:set name="located-in"><tm:lookup indicator="http://psi.ontopia.net/geography/located-in"/></logic:set>
    <logic:set name="setting"><tm:lookup indicator="http://psi.ontopia.net/opera/takes-place-in"/></logic:set>
    <logic:set name="born-in"><tm:lookup indicator="http://psi.ontopia.net/biography/born-in"/></logic:set>
    <logic:set name="died-in"><tm:lookup indicator="http://psi.ontopia.net/biography/died-in"/></logic:set>

    <logic:set name="location">
      <tm:filter instanceOf="country">
        <tm:associated from="topic" type="located-in"/>
      </tm:filter>
    </logic:set>
    <logic:set name="type">
      <tm:classesOf/>
    </logic:set>
    <h1><output:name/></h1>
    <p><output:name/> is a <output:name of="type"/> located in
      <logic:foreach name="location" separator=" and ">
        <output:element name="a"><output:attribute name="href"><output:link of="topicmap"
        template="country.jsp?id="/><output:objectid/></output:attribute>
        <output:name/></output:element></logic:foreach>.
    </p>
    <!-- output the operas that this is the setting for -->
    <logic:set name="operas">
      <tm:associated from="topic" type="setting"/>
    </logic:set>
    <logic:if name="operas">
    <logic:then>
      It is the setting for the opera(s):
      <ul>
      <logic:foreach name="operas">
        <li><output:element name="a"><output:attribute name="href"><output:link of="topicmap"
        template="opera.jsp?id="/><output:objectid/></output:attribute>
        <output:name/></output:element></li>
      </logic:foreach>
      </ul>
    </logic:then>
    </logic:if>

    <!-- output opera houses -->
    <logic:set name="theatres">
      <tm:filter instanceOf="theatre"><tm:associated from="topic" type="located-in"/></tm:filter>
    </logic:set>
    <logic:if name="theatres">
    <logic:then>
      <p><i>It contains the following theatre(s):</i>
      <ul>
      <logic:foreach name="theatres" set="theatre">
      <li><output:element name="a"><output:attribute name="href"><output:link of="topicmap"
      template="theatre.jsp?id="/><tolog:id var="theatre"/></output:attribute>
      <output:name of="theatre"/></output:element></li>
      </logic:foreach>
      </ul>
      </p>
    </logic:then>
    </logic:if>

    <!-- output people born here -->
<tolog:if query="born-in($persons : person, %topic% : place)?">
<p><i>These people were born here:</i>
<ul><tolog:foreach query="born-in($persons : person, %topic% : place) order by $persons?">
<tolog:choose>
<tolog:when query="instance-of(%persons%, composer)?">
          <li><output:element name="a"><output:attribute name="href"><output:link of="topicmap"
          template="composer.jsp?id="/><tolog:id var="persons" /></output:attribute>
          <output:name of="persons" basenameScope="normal"/></output:element></li>
</tolog:when>
<tolog:when query="instance-of(%persons%, librettist)?">
          <li><output:element name="a"><output:attribute name="href"><output:link of="topicmap"
          template="librettist.jsp?id="/><tolog:id var="persons" /></output:attribute>
          <output:name of="persons" basenameScope="normal"/></output:element></li>
</tolog:when>
<tolog:otherwise>
          <li><output:element name="a"><output:attribute name="href"><output:link of="topicmap"
          template="writer.jsp?id="/><tolog:id var="persons" /></output:attribute>
          <output:name of="persons" basenameScope="normal"/></output:element></li>
</tolog:otherwise>
</tolog:choose>
</tolog:foreach></ul></p>
</tolog:if>

    <!-- output the persons who died here -->
<tolog:if query="died-in($persons : person, %topic% : place)?">
<p><i>These people died here:</i>
<ul><tolog:foreach query="died-in($persons : person, %topic% : place) order by $persons?">
<tolog:choose>
<tolog:when query="instance-of(%persons%, composer)?">
          <li><output:element name="a"><output:attribute name="href"><output:link of="topicmap"
          template="composer.jsp?id="/><tolog:id var="persons" /></output:attribute>
          <output:name of="persons" basenameScope="normal"/></output:element></li>
</tolog:when>
<tolog:when query="instance-of(%persons%, librettist)?">
          <li><output:element name="a"><output:attribute name="href"><output:link of="topicmap"
          template="librettist.jsp?id="/><tolog:id var="persons" /></output:attribute>
          <output:name of="persons" basenameScope="normal"/></output:element></li>
</tolog:when>
<tolog:otherwise>
          <li><output:element name="a"><output:attribute name="href"><output:link of="topicmap"
          template="writer.jsp?id="/><tolog:id var="persons" /></output:attribute>
          <output:name of="persons" basenameScope="normal"/></output:element></li>
</tolog:otherwise>
</tolog:choose>
</tolog:foreach></ul></p>
</tolog:if>

  </function>

</module>
