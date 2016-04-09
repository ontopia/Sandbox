
<module>

  <function name="country_function" params="topic">

    <!-- SET ONTOLOGY VARIABLES -->
    <logic:set name="city"><tm:lookup indicator="http://psi.ontopia.net/geography/city"/></logic:set>
    <logic:set name="region"><tm:lookup indicator="http://psi.ontopia.net/geography/region"/></logic:set>
    <logic:set name="composer"><tm:lookup indicator="http://psi.ontopia.net/music/composer"/></logic:set>
    <logic:set name="writer"><tm:lookup indicator="http://psi.ontopia.net/literature/writer"/></logic:set>
    <logic:set name="librettist"><tm:lookup indicator="http://psi.ontopia.net/music/librettist"/></logic:set>
    <logic:set name="theatre"><tm:lookup indicator="http://psi.ontopia.net/literature/theatre"/></logic:set>

    <logic:set name="normal"><tm:lookup indicator="http://psi.ontopia.net/basename/normal"/></logic:set>
    <logic:set name="english"><tm:lookup indicator="http://www.topicmaps.org/xtm/1.0/language.xtm#en"/></logic:set>

    <logic:set name="located-in"><tm:lookup indicator="http://psi.ontopia.net/geography/located-in"/></logic:set>
    <logic:set name="setting"><tm:lookup indicator="http://psi.ontopia.net/opera/takes-place-in"/></logic:set>
    <logic:set name="died-in"><tm:lookup indicator="http://psi.ontopia.net/biography/died-in"/></logic:set>
    <logic:set name="born-in"><tm:lookup indicator="http://psi.ontopia.net/biography/born-in"/></logic:set>

    <!-- GET RELATED TOPICS -->

    <!-- collect all cities and regions located in this country -->
    <logic:set name="cities-and-regions">
      <value:union>
      <tm:filter instanceOf="city"><tm:associated from="topic" type="located-in"/></tm:filter>
      <tm:filter instanceOf="region"><tm:associated from="topic" type="located-in"/></tm:filter>
      </value:union>
    </logic:set>

    <!-- combined collection of cities and regions with this country -->
    <logic:set name="places">
      <value:union>
      <value:copy of="cities-and-regions"/>
      <value:copy of="topic"/>
      </value:union>
    </logic:set>

    <!-- collect all operas whose setting is this country or one of its cities or regions -->
    <logic:set name="country_operas">
      <tm:associated from="places" type="setting"/>
    </logic:set>
    <logic:if name="country_operas">
    <logic:then>
      <!-- output complete list of operas set in this country -->
      <p><i><output:name of="topic"/> is the setting for the opera(s)</i>
      <logic:foreach name="country_operas">
       <li><output:element name="a"><output:attribute name="href"><output:link of="topicmap"
       template="opera.jsp?tm=%topicmap%&amp;id="/><output:objectid/></output:attribute>
       <output:name/></output:element></li>
    </logic:foreach></p>
    </logic:then>
    </logic:if>

    <!-- ITERATE OVER EACH CITY-OR-REGION -->

    <logic:if name="cities-and-regions" greaterThan="3">
    <logic:then>
      <p><i>The following cities and regions are of interest to the domain
      of Italian opera:</i><br />
      <logic:foreach name="cities-and-regions" separator=", ">
      <output:element name="a"><output:attribute name="href">#<output:objectid/></output:attribute>
      <output:name/></output:element></logic:foreach></p>
    </logic:then>
    </logic:if>

    <!-- list each city or region -->
    <logic:if name="cities-and-regions">
    <logic:then>
      <logic:foreach name="cities-and-regions" set="city-or-region">
      <p><font size="+2"><b><output:element name="a"><output:attribute
      name="name"><output:objectid/></output:attribute></output:element><output:element name="a">
      <output:attribute name="href"><output:link of="topicmap"
      template="city-region.jsp?id="/><output:objectid/></output:attribute>
      <output:name/></output:element></b></font>

      <!-- output opera houses -->
      <logic:set name="theatres">
      <tm:filter instanceOf="theatre"><tm:associated from="city-or-region" type="located-in"/></tm:filter>
      </logic:set>
      <logic:if name="theatres">
      <logic:then>
      <p class="subhead">Contains the following theatre(s):</p>
      <logic:foreach name="theatres" set="theatre">
      <li class="compact"><output:element name="a"><output:attribute name="href"><output:link of="topicmap"
      template="theatre.jsp?id="/><tolog:id var="theatre"/></output:attribute><output:name
      of="theatre"/></output:element></li>
      </logic:foreach>
      </logic:then>
      </logic:if>

      <!-- output the operas that this is the setting for -->
      <logic:set name="operas">
      <tm:associated from="city-or-region" type="setting"/>
      </logic:set>
      <logic:if name="operas">
      <logic:then>
      <p class="subhead">Opera(s) that are set here:</p>
      <logic:foreach name="operas" set="opera">
          <li class="compact"><output:element name="a"><output:attribute name="href"><output:link of="topicmap"
          template="opera.jsp?id="/><tolog:id var="opera" /></output:attribute>
          <output:name of="opera"/></output:element></li>
      </logic:foreach>
      </logic:then>
      </logic:if>

      <!-- output people born here -->
      <logic:set name="births">
      <value:union>
        <tm:filter instanceOf="composer"><tm:associated from="city-or-region" type="born-in"/></tm:filter>
        <tm:filter instanceOf="librettist"><tm:associated from="city-or-region" type="born-in"/></tm:filter>
      </value:union>
      </logic:set>
      <logic:if name="births">
      <logic:then><!--fixme: should sometimes go to librettist.jsp-->
      <p class="subhead">People who were born here:</p>
      <logic:foreach name="births" set="birth">
          <li class="compact"><output:element name="a"><output:attribute name="href"><output:link of="topicmap"
          template="composer.jsp?id="/><tolog:id var="birth" /></output:attribute>
          <output:name of="birth" basenameScope="normal"/></output:element></li>
      </logic:foreach>
      </logic:then>
      </logic:if>

      <!-- output the persons who died here -->
      <logic:set name="deaths">
      <value:union>
        <tm:filter instanceOf="composer"><tm:associated from="city-or-region" type="died-in"/></tm:filter>
        <tm:filter instanceOf="librettist"><tm:associated from="city-or-region" type="died-in"/></tm:filter>
      </value:union>
      </logic:set>
      <logic:if name="deaths">
      <logic:then>
      <p class="subhead">People who died here:</p>
      <logic:foreach name="deaths" set="death">
          <li class="compact"><output:element name="a"><output:attribute name="href"><output:link of="topicmap"
          template="composer.jsp?id="/><tolog:id var="death" /></output:attribute>
          <output:name of="death" basenameScope="normal"/></output:element></li>
      </logic:foreach>
      </logic:then>
      </logic:if>
      </p>
      </logic:foreach>
    </logic:then>
    </logic:if>
    <table>
    <tr><td> </td></tr>
    <tr height="800"><td> </td></tr>
    </table>


  </function>

</module>
