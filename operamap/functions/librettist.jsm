
<module>

  <function name="librettist_function" params="topic">


    <!-- SET ONTOLOGY VARIABLES -->
    <logic:set name="composer"><tm:lookup indicator="http://psi.ontopia.net/music/composer"/></logic:set>

    <logic:set name="normal"><tm:lookup indicator="http://psi.ontopia.net/basename/normal"/></logic:set>
    <logic:set name="nom-de-plume"><tm:lookup indicator="http://psi.ontopia.net/basename/nom-de-plume"/></logic:set>

    <logic:set name="born-in"><tm:lookup indicator="http://psi.ontopia.net/biography/born-in"/></logic:set>
    <logic:set name="died-in"><tm:lookup indicator="http://psi.ontopia.net/biography/died-in"/></logic:set>
    <logic:set name="libretto-by"><tm:lookup indicator="http://psi.ontopia.net/literature/libretto-by"/></logic:set>
    <logic:set name="composed-by"><tm:lookup indicator="http://psi.ontopia.net/music/composed-by"/></logic:set>
    <logic:set name="born"><tm:lookup indicator="http://psi.ontopia.net/biography/date-of-birth"/></logic:set>
    <logic:set name="died"><tm:lookup indicator="http://psi.ontopia.net/biography/date-of-death"/></logic:set>
    <logic:set name="premiere-date"><tm:lookup indicator="http://psi.ontopia.net/opera/premiere-date"/></logic:set>



    <h1><output:name of="topic" basenameScope="normal"/></h1>

    <!-- GET RELATED TOPICS -->
    <logic:set name="birth-place">
      <tm:associated from="topic" type="born-in"/>
    </logic:set>

    <logic:set name="death-place">
      <tm:associated from="topic" type="died-in"/>
    </logic:set>

    <logic:set name="written">
      <tm:associated from="topic" type="libretto-by"/>
    </logic:set>

    <!-- GET OCCURRENCES -->
    <logic:set name="birth">
      <tm:filter instanceOf="born">
      <tm:occurrences of="topic"/>
      </tm:filter>
    </logic:set>

    <logic:set name="death">
      <tm:filter instanceOf="died">
      <tm:occurrences of="topic"/>
      </tm:filter>
    </logic:set>

    <logic:set name="other-name">
      <tm:filter inScopeOf="nom-de-plume">
        <tm:filter inScopeOf="normal">
          <tm:names of="topic"/>
        </tm:filter>
      </tm:filter>
    </logic:set>

    <logic:set name="is-composer">
      <tm:filter instanceOf="composer">
      <tm:topics of="topic"/>
      </tm:filter>
    </logic:set>

    <p>Librettist<logic:if
    name="is-composer"><logic:then> and <output:element name="a"><output:attribute name="href"><output:link of="topicmap"
    template="composer.jsp?id="/><output:objectid/></output:attribute>composer</output:element></logic:then></logic:if>.

    <logic:if name="other-name">
    <logic:then>
      Also known as "<output:name of="other-name"/>".
    </logic:then>
    </logic:if>

    <logic:if name="birth">
    <logic:then>
      Born <output:content of="birth"/>
      <logic:if name="birth-place">
      <logic:then>
      in <output:element name="a"><output:attribute name="href"><output:link of="topicmap" template="city-region.jsp?id="/><output:objectid/></output:attribute><output:name/></output:element>.
      </logic:then>
      </logic:if>
    </logic:then>
    </logic:if>

    <logic:if name="death">
    <logic:then>
      Died <output:content of="death"/>
      <logic:if name="death-place">
      <logic:then>
      in <output:element name="a"><output:attribute name="href"><output:link of="topicmap" template="city-region.jsp?id="/><output:objectid/></output:attribute><output:name/></output:element>.
      </logic:then>
      </logic:if>
    </logic:then>
    </logic:if>
    </p>
    <p><b>Wrote libretto for:</b></p>
    <!-- fixme: this could be made a little prettier -->
    <ul><logic:foreach name="written" set="work">
        <logic:set name="composer"><tm:associated type="composed-by"/></logic:set>
        <li><output:element name="a"><output:attribute name="href"><output:link
         of="topicmap" template="composer.jsp?id="/><output:objectid
         of="composer"/></output:attribute><output:name of="composer"
         basenameScope="normal"/></output:element>: <b><i><output:element
         name="a"><output:attribute name="href"><output:link of="topicmap"
         template="opera.jsp?id="/><output:objectid/></output:attribute>
         <output:name/></output:element></i></b>
      </li>
      </logic:foreach></ul>
    <hr /><br />

  </function>

</module>
