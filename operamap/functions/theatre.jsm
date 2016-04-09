
<module>

  <function name="theatre_funtion" params="topic">


      <logic:set name="located-in">
        <tm:lookup indicator="http://psi.ontopia.net/geography/located-in"/>
      </logic:set>

      <logic:set name="city-type">
        <tm:lookup indicator="http://psi.ontopia.net/geography/city"/>
      </logic:set>

      <logic:set name="country-type">
        <tm:lookup indicator="http://psi.ontopia.net/geography/country"/>
      </logic:set>

      <logic:set name="premiere-type">
        <tm:lookup indicator="http://psi.ontopia.net/opera/premiere"/>
      </logic:set>

      <logic:set name="city">
        <tm:filter instanceOf="city-type">
          <tm:associated from="topic" type="located-in"/>
        </tm:filter>
      </logic:set>

      <logic:set name="country">
        <tm:filter instanceOf="country-type">
          <tm:associated from="city" type="located-in"/>
        </tm:filter>
      </logic:set>

      <logic:set name="premieres">
        <tm:associated from="topic" type="premiere-type"/>
      </logic:set>

       <p><output:name of="topic"/> is located in
         <logic:if name="city">
         <logic:then>
           <output:element name="a"><output:attribute name="href"><output:link of="topicmap"
           template="city-region.jsp?id="/><tolog:id var="city"/></output:attribute>
           <output:name of="city"/></output:element>
           <logic:if name="country">
           <logic:then>
             <output:element name="a"><output:attribute name="href"><output:link of="topicmap"
             template="country.jsp?id="/><tolog:id var="country"/></output:attribute>
             (<output:name of="country"/>)</output:element>
           </logic:then>
           </logic:if>
         </logic:then>
         <logic:else>
           [unknown location]
         </logic:else>
         </logic:if>

         <logic:if name="premieres">
         <logic:then>
         and hosted the first perfomance of the following opera(s):
         <ul>
           <logic:foreach name="premieres" set="opera">
             <li>
            <output:element name="a"><output:attribute name="href"><output:link of="topicmap"
            template="opera.jsp?id="/><tolog:id var="opera"/></output:attribute>
          <output:name of="opera"/></output:element></li>
           </logic:foreach>
         </ul>
         </logic:then>
         </logic:if>

        <logic:set name="homepage">
          <tm:lookup indicator="http://psi.ontopia.net/opera/homepage"/>
        </logic:set>
        <logic:set name="homepages">
          <tm:filter instanceOf="homepage"><tm:occurrences of="topic"/></tm:filter>
        </logic:set>

        <logic:if name="homepages">
          <logic:then>
            <p>Other sites:
            <ul>
            <logic:foreach name="homepages">
        <li><output:element name="a"><output:attribute name="href"><output:locator/>
        </output:attribute><output:locator/></output:element></li>
      </logic:foreach>
      </ul>
    </logic:then>
    </logic:if>

  </function>

</module>
