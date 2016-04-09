<module>

<!-- DONE SOME WORK ON MIGRATING TO TOLOG TAG LIBRARIES. MUCH REMAINS. -->

<function name="place_link" params="setting">
   <logic:set name="type"><tm:classesOf of="setting"/></logic:set><output:element
     name="a"><output:attribute name="href"><logic:if name="type"
     equals="country"><logic:then><output:link of="topicmap"
     template="country.jsp?id="/></logic:then><logic:else><output:link of="topicmap"
     template="city-region.jsp?id="/></logic:else></logic:if><output:objectid
     of="setting"/></output:attribute><output:name
     of="setting" basenameScope="english"/></output:element><logic:if
   name="sequence-last"><logic:then>.</logic:then></logic:if></function>

<function name="opera_function" params="topic">

  <!-- SET ONTOLOGY VARIABLES -->

  <logic:set name="place"><tm:lookup indicator="http://psi.ontopia.net/geography/place"/></logic:set>
  <logic:set name="city"><tm:lookup indicator="http://psi.ontopia.net/geography/city"/></logic:set>
  <logic:set name="country"><tm:lookup indicator="http://psi.ontopia.net/geography/country"/></logic:set>
  <logic:set name="region"><tm:lookup indicator="http://psi.ontopia.net/geography/region"/></logic:set>
  <!--fixme: workaround because instanceOf attribute on tm:filter doesn't handle
      class hierarchies (behaves as if it were directInstanceOf) -->
  <logic:set name="place">
    <value:union>
      <value:copy of="city"/><value:copy of="country"/><value:copy of="region"/>
    </value:union>
  </logic:set>
  <logic:set name="character"><tm:lookup indicator="http://psi.ontopia.net/literature/character"/></logic:set>
  <logic:set name="aria"><tm:lookup indicator="http://psi.ontopia.net/music/aria"/></logic:set>
  <logic:set name="voices"><tm:lookup indicator="http://psi.ontopia.net/music/voice-type"/></logic:set>

  <logic:set name="normal"><tm:lookup indicator="http://psi.ontopia.net/basename/normal"/></logic:set>
  <logic:set name="english"><tm:lookup indicator="http://www.topicmaps.org/xtm/1.0/language.xtm#en"/></logic:set>
  <logic:set name="appears-in"><tm:lookup indicator="http://psi.ontopia.net/literature/appears-in"/></logic:set>
  <logic:set name="pub"><tm:lookup indicator="http://psi.ontopia.net/literature/published-by"/></logic:set>
  <logic:set name="aria-in-opera"><tm:lookup indicator="http://psi.ontopia.net/music/aria-in-opera"/></logic:set>

  <logic:set name="libretto"><tm:lookup indicator="http://psi.ontopia.net/music/libretto"/></logic:set>
  <logic:set name="synopsis"><tm:lookup indicator="http://psi.ontopia.net/music/synopsis"/></logic:set>
  <logic:set name="sound-clip"><tm:lookup indicator="http://psi.ontopia.net/music/sound-clip"/></logic:set>

  <logic:set name="illustration"><tm:lookup indicator="http://psi.ontopia.net/opera/illustration"/></logic:set>
  <logic:set name="homepage"><tm:lookup indicator="http://psi.ontopia.net/opera/homepage"/></logic:set>
  <logic:set name="desc"><tm:lookup indicator="http://psi.ontopia.net/xtm/occurrence-type/description"/></logic:set>
  <logic:set name="online"><tm:lookup indicator="http://psi.ontopia.net/opera/online"/></logic:set>

  <!-- SET SORTNAME -->
  <logic:set name="sortname">
    <tm:lookup indicator="http://www.topicmaps.org/xtm/1.0/core.xtm#sort"/>
  </logic:set>
  <logic:set name="topicsortname">
    <tm:filter inScopeOf="sortname"><tm:variants of="topic"/></tm:filter>
  </logic:set>

  <!-- GET OCCURRENCES -->
  <logic:set name="occurrences"><tm:occurrences of="topic"/></logic:set>

<!-- OUTPUT INTRODUCTORY PARAGRAPH -->

<p><br />
The opera <i><tolog:out var="name"/></i><tolog:if query='
  topic-name(%topic%, $name),
  scope($name, english)?'>(<tolog:out var="name"/>)</tolog:if>
was composed by <output:element name="a"><output:attribute
name="href"><output:link of="topicmap" template="composer.jsp?id="/><tolog:id
var="composer"/></output:attribute><tolog:out query='
topic-name(%composer%, $composer-name),
scope($composer-name, normal)?'/></output:element>

<tolog:set query='
  libretto-by(%topic% : opera, $librettists : librettist)
  order by $librettists?'/><logic:if
  name="librettists"><logic:then>
    to a libretto by
    <logic:if
    name="librettists" lessThan="2"><logic:then>
      <output:element name="a"><output:attribute name="href"><output:link of="topicmap"
      template="librettist.jsp?id="/><tolog:id var="librettists"/></output:attribute>
      <output:name of="librettists" basenameScope="normal"/></output:element></logic:then><logic:else>
      <logic:if
      name="librettists" lessThan="3"><logic:then>
        <logic:foreach name="librettists" set="librettist" separator=" and ">
        <output:element name="a"><output:attribute name="href"><output:link of="topicmap"
        template="librettist.jsp?id="/><tolog:id var="librettist"/></output:attribute>
        <output:name of="librettist" basenameScope="normal"/></output:element>
        </logic:foreach></logic:then>
      <logic:else>
        <logic:foreach name="librettists" set="librettist" separator=", ">
        <logic:if name="sequence-last"><logic:then>and</logic:then></logic:if>
        <output:element name="a"><output:attribute name="href"><output:link of="topicmap"
        template="librettist.jsp?id="/><tolog:id var="librettist"/></output:attribute><output:name
        of="librettist" basenameScope="normal"/></output:element></logic:foreach>
      </logic:else></logic:if></logic:else></logic:if></logic:then></logic:if>

<tolog:if query='based-on(%topic% : result, $source : source)?'>
based on <tolog:foreach separator=' and ' query='
based-on(%topic% : result, $source : source),
direct-instance-of($source, $type)?'><i><output:name
of="source" basenameScope="type"/></i>
<tolog:if query='
written-by(%source% : work,
$writer : writer)?'>by <output:element name="a"><output:attribute
name="href"><output:link of="topicmap" template="writer.jsp?id="/><tolog:id
var="writer"/></output:attribute><output:name of="writer"
basenameScope="normal"/></output:element></tolog:if></tolog:foreach>.</tolog:if>

<tolog:if query='
premiere(%topic% : work, $place : place)?'>It was first performed at <output:element
name="a"><output:attribute name="href"><output:link of="topicmap"
template="theatre.jsp?id="/><tolog:id var="place"/></output:attribute><tolog:out
var="place"/></output:element><tolog:if query='
located-in(%place% : containee, $city : container),
instance-of($city, city)?'> in <output:element name="a"><output:attribute
name="href"><output:link of="topicmap"
template="city-region.jsp?tm=%topicmap%&amp;id="/><tolog:id
var="city"/></output:attribute><output:name of="city"
basenameScope="english"/></output:element><tolog:if query='
located-in(%city% : containee, $country : container),
instance-of($country, country)?'> (<output:element name="a"><output:attribute
name="href"><output:link of="topicmap"
template="country.jsp?tm=%topicmap%&amp;id="/><tolog:id
var="country"/></output:attribute><output:name of="country"
basenameScope="english"/></output:element>)</tolog:if></tolog:if><tolog:if query='
premiere-date(%topic%, $date)?'> on <tolog:out var="date"/></tolog:if><tolog:if query='
published-by(%topic% : work, $publisher : publisher)?'> and published by
<tolog:out var="publisher"/></tolog:if>.</tolog:if>
<tolog:if query='
takes-place-in(%topic% : opera, $setting : place)?'>The opera is set in
<tolog:foreach separator=" and " query='
  takes-place-in(%topic% : opera, $setting : place)
  order by $setting?'><logic:call name="place_link"/></tolog:foreach>
</tolog:if>

  <logic:set name="description">
    <tm:filter instanceOf="desc"><tm:occurrences of="topic"/></tm:filter>
  </logic:set>
  <logic:if
  name="description">
    <logic:then><p><output:content/></p></logic:then></logic:if>
  </p>

  <!-- Dramatis personae -->

<p><b>Dramatis Personae:</b></p>
<ul><tolog:foreach
query='
  appears-in($char : character, %topic% : work)
  order by $char?'><tolog:set
query='
  {instance-of(%char%, $this) |
  appears-in(%char% : character, $this : work)}?'/>
<li><output:name of="char" basenameScope="this"/><tolog:if
query='descr(%char%, $description)?'>,
<i><tolog:out var="description"/></i></tolog:if>
<tolog:if query='
has-voice(%char% : character, $voice : voice-type)?'>(<tolog:out
var="voice"/>)</tolog:if></li></tolog:foreach></ul>

  <!-- Arias -->

  <logic:set name="arias">
    <tm:filter instanceOf="aria"><tm:associated from="topic" type="aria-in-opera"/></tm:filter>
  </logic:set>
  <logic:if

  name="arias"><logic:then>
    <p><b>Famous Arias:</b></p>
    <ul><logic:foreach name="arias" set="ar">
    <li><output:name of="ar"/></li>
    </logic:foreach></ul>
    </logic:then></logic:if>

  <!-- Synopses (online only) -->

  <logic:set name="synopses">
    <tm:filter inScopeOf="online">
      <tm:filter instanceOf="synopsis">
        <tm:occurrences of="topic"/>
      </tm:filter>
    </tm:filter>
  </logic:set>
  <logic:if

  name="synopses"><logic:then>
    <p><b>Synopsis:</b></p>
    <ul><logic:foreach name="synopses">
      <li><output:element name="a"><output:attribute name="href"><output:locator/>
      </output:attribute><output:locator/></output:element></li>
    </logic:foreach></ul></logic:then></logic:if>

  <!-- Libretti (online only) -->

  <logic:set name="libretti">
    <tm:filter inScopeOf="online">
      <tm:filter instanceOf="libretto">
        <tm:occurrences of="topic"/>
      </tm:filter>
    </tm:filter>
  </logic:set>
  <logic:if

  name="libretti"><logic:then>
    <p><b>Libretto:</b></p>
    <ul><logic:foreach name="libretti">
      <li><output:element name="a"><output:attribute name="href"><output:locator/>
      </output:attribute><output:locator/></output:element></li>
    </logic:foreach></ul></logic:then></logic:if>

  <!-- Sound clips (online only) -->

  <logic:set name="sound-clips">
    <tm:filter inScopeOf="online">
      <tm:filter instanceOf="sound-clip">
        <tm:occurrences of="topic"/>
      </tm:filter>
    </tm:filter>
  </logic:set>
  <logic:if

  name="sound-clips"><logic:then>
    <p><b>Sound clips:</b></p>
    <ul><logic:foreach name="sound-clips">
      <li><output:element name="a"><output:attribute name="href"><output:locator/>
      </output:attribute><output:locator/></output:element></li>
    </logic:foreach></ul></logic:then></logic:if>

  <!-- Home pages -->

  <logic:set name="homepages">
    <tm:filter instanceOf="homepage"><tm:occurrences of="topic"/></tm:filter>
  </logic:set>
  <logic:if

  name="homepages"><logic:then>
    <p><b>Other pages:</b></p>
    <ul><logic:foreach name="homepages" set="page">
      <li><output:element name="a"><output:attribute name="href"><output:locator/>
      </output:attribute><output:locator/></output:element></li>
    </logic:foreach></ul></logic:then></logic:if>

<tolog:if query='
  audio-recording(%topic%, $audio)?'><b>Recordings:</b> <tolog:foreach
  separator=', ' query='
  audio-recording(%topic%, $audio)
  order by $audio?'><tolog:out var='audio'/></tolog:foreach></tolog:if>

<br/>
<hr/>
<p>Search OperaBase for performances of <i><output:name/>:</i></p>
  <form method="get" action="operabase.jsp">

    <logic:if name="topicsortname">
    <logic:then>
      <output:element name="input">
  <output:attribute name="type">hidden</output:attribute>
  <output:attribute name="name">opera</output:attribute>
  <output:attribute name="value"><output:name of="topicsortname"/></output:attribute>
      </output:element>
    </logic:then>
    <logic:else>
      <output:element name="input">
  <output:attribute name="type">hidden</output:attribute>
  <output:attribute name="name">opera</output:attribute>
  <output:attribute name="value"><output:name of="topic"/></output:attribute>
      </output:element>
    </logic:else>
    </logic:if>
    <logic:if name="composersortname">
    <logic:then>
      <output:element name="input">
  <output:attribute name="type">hidden</output:attribute>
  <output:attribute name="name">composer</output:attribute>
  <output:attribute name="value"><output:name of="composersortname"/></output:attribute>
      </output:element>
    </logic:then>
    <logic:else>
      <output:element name="input">
  <output:attribute name="type">hidden</output:attribute>
  <output:attribute name="name">composer</output:attribute>
  <output:attribute name="value"><output:name of="composersortname"/></output:attribute>
      </output:element>
    </logic:else>
    </logic:if>
      <output:element name="input">
  <output:attribute name="type">radio</output:attribute>
  <output:attribute name="name">sort</output:attribute>
  <output:attribute name="value">V</output:attribute>
      </output:element>City
      <output:element name="input">
  <output:attribute name="type">radio</output:attribute>
  <output:attribute name="name">sort</output:attribute>
  <output:attribute name="value">G</output:attribute>
      </output:element>Country
      <output:element name="input">
  <output:attribute name="type">radio</output:attribute>
  <output:attribute name="name">sort</output:attribute>
  <output:attribute name="value">D</output:attribute>
  <output:attribute name="checked"></output:attribute>
      </output:element>Date
      <output:element name="input">
  <output:attribute name="type">submit</output:attribute>
  <output:attribute name="value">search</output:attribute>
      </output:element>
  </form>
</function>

<!--
select $type, $topic from
occurrence($topic, $occ),
type($occ, $type),
instance-of($topic, opera)
order by $type, $topic?
-->

</module>
