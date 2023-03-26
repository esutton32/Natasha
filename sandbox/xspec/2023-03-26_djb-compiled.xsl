<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="#all"
                version="3.0">
   <!-- the tested stylesheet -->
   <xsl:import href="file:/Users/djb/repos/Natasha/sandbox/2023-03-26_djb.xsl"/>
   <!-- XSpec library modules providing tools -->
   <xsl:include href="file:/Users/djb/Library/Preferences/com.oxygenxml/extensions/v25.1/frameworks/com.oxygenxml.xspec.XSpecSupportFramework/xspec.support-2.2.6/src/common/runtime-utils.xsl"/>
   <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}stylesheet-uri"
                 as="Q{http://www.w3.org/2001/XMLSchema}anyURI">file:/Users/djb/repos/Natasha/sandbox/2023-03-26_djb.xsl</xsl:variable>
   <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}xspec-uri"
                 as="Q{http://www.w3.org/2001/XMLSchema}anyURI">file:/Users/djb/repos/Natasha/sandbox/2023-03-26_djb.xspec</xsl:variable>
   <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}is-external"
                 as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                 select="false()"/>
   <xsl:variable xmlns:xs="http://www.w3.org/2001/XMLSchema"
                 name="Q{urn:x-xspec:compile:impl}thread-aware"
                 as="xs:boolean"
                 select="(system-property('Q{http://www.w3.org/1999/XSL/Transform}product-name') eq 'SAXON') and starts-with(system-property('Q{http://www.w3.org/1999/XSL/Transform}product-version'), 'EE ')"
                 static="yes"/>
   <xsl:variable name="Q{urn:x-xspec:compile:impl}logical-processor-count"
                 as="Q{http://www.w3.org/2001/XMLSchema}integer"
                 use-when="$Q{urn:x-xspec:compile:impl}thread-aware"
                 select="Q{java:java.lang.Runtime}getRuntime() =&gt; Q{java:java.lang.Runtime}availableProcessors()"/>
   <xsl:variable name="Q{urn:x-xspec:compile:impl}thread-count"
                 as="Q{http://www.w3.org/2001/XMLSchema}integer"
                 select="1"
                 use-when="$Q{urn:x-xspec:compile:impl}thread-aware =&gt; not()"/>
   <!-- the main template to run the suite -->
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}main"
                 as="empty-sequence()">
      <xsl:context-item use="absent"/>
      <!-- info message -->
      <xsl:message>
         <xsl:text>Testing with </xsl:text>
         <xsl:value-of select="system-property('Q{http://www.w3.org/1999/XSL/Transform}product-name')"/>
         <xsl:text> </xsl:text>
         <xsl:value-of select="system-property('Q{http://www.w3.org/1999/XSL/Transform}product-version')"/>
      </xsl:message>
      <!-- set up the result document (the report) -->
      <xsl:result-document format="Q{{http://www.jenitennison.com/xslt/xspec}}xml-report-serialization-parameters">
         <xsl:element name="report" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:attribute name="xspec" namespace="">file:/Users/djb/repos/Natasha/sandbox/2023-03-26_djb.xspec</xsl:attribute>
            <xsl:attribute name="stylesheet" namespace="">file:/Users/djb/repos/Natasha/sandbox/2023-03-26_djb.xsl</xsl:attribute>
            <xsl:attribute name="date" namespace="" select="current-dateTime()"/>
            <!-- invoke each compiled top-level x:scenario -->
            <xsl:for-each select="1 to 2">
               <xsl:choose>
                  <xsl:when test=". eq 1">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x7cf26cd5-ff1b-3b97-891d-d3ff1bc7f6ed"/>
                  </xsl:when>
                  <xsl:when test=". eq 2">
                     <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}xdd472123-629c-36a9-9fc7-659e3cd4cec9"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:for-each>
         </xsl:element>
      </xsl:result-document>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x7cf26cd5-ff1b-3b97-891d-d3ff1bc7f6ed"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>Scenarios for testing function titleCase</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x7cf26cd5-ff1b-3b97-891d-d3ff1bc7f6ed</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/Users/djb/repos/Natasha/sandbox/2023-03-26_djb.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Scenarios for testing function titleCase</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="comet">http://natasha.obdurodon.org/</xsl:namespace>
               <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
               <xsl:attribute name="function" namespace="">comet:titleCase</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:for-each select="1 to 1">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x6e9e06f9-c292-3ede-834b-f120a6ab724e"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x6e9e06f9-c292-3ede-834b-f120a6ab724e"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..two-word phrase capitalizes both words</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x6e9e06f9-c292-3ede-834b-f120a6ab724e</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/Users/djb/repos/Natasha/sandbox/2023-03-26_djb.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>two-word phrase capitalizes both words</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="comet">http://natasha.obdurodon.org/</xsl:namespace>
               <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:namespace name="comet">http://natasha.obdurodon.org/</xsl:namespace>
                  <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
                  <xsl:attribute name="name" namespace="">input</xsl:attribute>
                  <xsl:attribute name="select" namespace="">'natasha rostova'</xsl:attribute>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable xmlns:comet="http://natasha.obdurodon.org/"
                          xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          name="Q{}input"
                          select="'natasha rostova'"/>
            <xsl:sequence xmlns:comet="http://natasha.obdurodon.org/"
                          xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          select="Q{http://natasha.obdurodon.org/}titleCase($Q{}input)"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x6e9e06f9-c292-3ede-834b-f120a6ab724e-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x6e9e06f9-c292-3ede-834b-f120a6ab724e-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>Capitalizes both words</xsl:message>
      <xsl:variable xmlns:comet="http://natasha.obdurodon.org/"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d55e7"
                    select="'Natasha Rostova'"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d55e7, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x6e9e06f9-c292-3ede-834b-f120a6ab724e-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Capitalizes both words</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d55e7"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}xdd472123-629c-36a9-9fc7-659e3cd4cec9"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>Scenarios for testing function round-up-to-integer</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">xdd472123-629c-36a9-9fc7-659e3cd4cec9</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/Users/djb/repos/Natasha/sandbox/2023-03-26_djb.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>Scenarios for testing function round-up-to-integer</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="comet">http://natasha.obdurodon.org/</xsl:namespace>
               <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
               <xsl:attribute name="function" namespace="">comet:round-up-to-integer</xsl:attribute>
            </xsl:element>
         </xsl:element>
         <xsl:for-each select="1 to 3">
            <xsl:choose>
               <xsl:when test=". eq 1">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x755f1b1a-598a-3ef7-aade-be293e1d11b1"/>
               </xsl:when>
               <xsl:when test=". eq 2">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x47c80a63-6192-3f1c-8648-cc6d93e01f94"/>
               </xsl:when>
               <xsl:when test=". eq 3">
                  <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x3279f0b9-c964-32d7-ab1e-5cfe61c3ed3d"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:message terminate="yes">ERROR: Unhandled scenario invocation</xsl:message>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x755f1b1a-598a-3ef7-aade-be293e1d11b1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..with double input not equal to integer multiple</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x755f1b1a-598a-3ef7-aade-be293e1d11b1</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/Users/djb/repos/Natasha/sandbox/2023-03-26_djb.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>with double input not equal to integer multiple</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="comet">http://natasha.obdurodon.org/</xsl:namespace>
               <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:namespace name="comet">http://natasha.obdurodon.org/</xsl:namespace>
                  <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
                  <xsl:attribute name="name" namespace="">input</xsl:attribute>
                  <xsl:attribute name="select" namespace="">28.6</xsl:attribute>
               </xsl:element>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:namespace name="comet">http://natasha.obdurodon.org/</xsl:namespace>
                  <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
                  <xsl:attribute name="name" namespace="">rounding-target</xsl:attribute>
                  <xsl:attribute name="select" namespace="">3</xsl:attribute>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable xmlns:comet="http://natasha.obdurodon.org/"
                          xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          name="Q{}input"
                          select="28.6"/>
            <xsl:variable xmlns:comet="http://natasha.obdurodon.org/"
                          xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          name="Q{}rounding-target"
                          select="3"/>
            <xsl:sequence xmlns:comet="http://natasha.obdurodon.org/"
                          xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          select="Q{http://natasha.obdurodon.org/}round-up-to-integer($Q{}input, $Q{}rounding-target)"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x755f1b1a-598a-3ef7-aade-be293e1d11b1-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x755f1b1a-598a-3ef7-aade-be293e1d11b1-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>28.6 rounds up to 30</xsl:message>
      <xsl:variable xmlns:comet="http://natasha.obdurodon.org/"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d55e14"
                    select="30"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d55e14, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x755f1b1a-598a-3ef7-aade-be293e1d11b1-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>28.6 rounds up to 30</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d55e14"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x47c80a63-6192-3f1c-8648-cc6d93e01f94"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..with double input equal to integer multiple</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x47c80a63-6192-3f1c-8648-cc6d93e01f94</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/Users/djb/repos/Natasha/sandbox/2023-03-26_djb.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>with double input equal to integer multiple</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="comet">http://natasha.obdurodon.org/</xsl:namespace>
               <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:namespace name="comet">http://natasha.obdurodon.org/</xsl:namespace>
                  <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
                  <xsl:attribute name="name" namespace="">input</xsl:attribute>
                  <xsl:attribute name="select" namespace="">27.0</xsl:attribute>
               </xsl:element>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:namespace name="comet">http://natasha.obdurodon.org/</xsl:namespace>
                  <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
                  <xsl:attribute name="name" namespace="">rounding-target</xsl:attribute>
                  <xsl:attribute name="select" namespace="">3</xsl:attribute>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable xmlns:comet="http://natasha.obdurodon.org/"
                          xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          name="Q{}input"
                          select="27.0"/>
            <xsl:variable xmlns:comet="http://natasha.obdurodon.org/"
                          xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          name="Q{}rounding-target"
                          select="3"/>
            <xsl:sequence xmlns:comet="http://natasha.obdurodon.org/"
                          xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          select="Q{http://natasha.obdurodon.org/}round-up-to-integer($Q{}input, $Q{}rounding-target)"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x47c80a63-6192-3f1c-8648-cc6d93e01f94-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x47c80a63-6192-3f1c-8648-cc6d93e01f94-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>27.0 returns 27</xsl:message>
      <xsl:variable xmlns:comet="http://natasha.obdurodon.org/"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d55e19"
                    select="27"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d55e19, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x47c80a63-6192-3f1c-8648-cc6d93e01f94-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>27.0 returns 27</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d55e19"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x3279f0b9-c964-32d7-ab1e-5cfe61c3ed3d"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}scenario)">
      <xsl:context-item use="absent"/>
      <xsl:message>..with integer input equal to integer multiple</xsl:message>
      <xsl:element name="scenario" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x3279f0b9-c964-32d7-ab1e-5cfe61c3ed3d</xsl:attribute>
         <xsl:attribute name="xspec" namespace="">file:/Users/djb/repos/Natasha/sandbox/2023-03-26_djb.xspec</xsl:attribute>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>with integer input equal to integer multiple</xsl:text>
         </xsl:element>
         <xsl:element name="input-wrap" namespace="">
            <xsl:element name="x:call" namespace="http://www.jenitennison.com/xslt/xspec">
               <xsl:namespace name="comet">http://natasha.obdurodon.org/</xsl:namespace>
               <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:namespace name="comet">http://natasha.obdurodon.org/</xsl:namespace>
                  <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
                  <xsl:attribute name="name" namespace="">input</xsl:attribute>
                  <xsl:attribute name="select" namespace="">27.0</xsl:attribute>
               </xsl:element>
               <xsl:element name="x:param" namespace="http://www.jenitennison.com/xslt/xspec">
                  <xsl:namespace name="comet">http://natasha.obdurodon.org/</xsl:namespace>
                  <xsl:namespace name="xsl">http://www.w3.org/1999/XSL/Transform</xsl:namespace>
                  <xsl:attribute name="name" namespace="">rounding-target</xsl:attribute>
                  <xsl:attribute name="select" namespace="">3</xsl:attribute>
               </xsl:element>
            </xsl:element>
         </xsl:element>
         <xsl:variable name="Q{http://www.jenitennison.com/xslt/xspec}result" as="item()*">
            <xsl:variable xmlns:comet="http://natasha.obdurodon.org/"
                          xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          name="Q{}input"
                          select="27.0"/>
            <xsl:variable xmlns:comet="http://natasha.obdurodon.org/"
                          xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          name="Q{}rounding-target"
                          select="3"/>
            <xsl:sequence xmlns:comet="http://natasha.obdurodon.org/"
                          xmlns:x="http://www.jenitennison.com/xslt/xspec"
                          select="Q{http://natasha.obdurodon.org/}round-up-to-integer($Q{}input, $Q{}rounding-target)"/>
         </xsl:variable>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
            <xsl:with-param name="report-name" select="'result'"/>
         </xsl:call-template>
         <!-- invoke each compiled x:expect -->
         <xsl:call-template name="Q{http://www.jenitennison.com/xslt/xspec}x3279f0b9-c964-32d7-ab1e-5cfe61c3ed3d-expect1">
            <xsl:with-param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                            select="$Q{http://www.jenitennison.com/xslt/xspec}result"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
   <xsl:template name="Q{http://www.jenitennison.com/xslt/xspec}x3279f0b9-c964-32d7-ab1e-5cfe61c3ed3d-expect1"
                 as="element(Q{http://www.jenitennison.com/xslt/xspec}test)">
      <xsl:context-item use="absent"/>
      <xsl:param name="Q{http://www.jenitennison.com/xslt/xspec}result"
                 as="item()*"
                 required="yes"/>
      <xsl:message>27 (integer) returns itself</xsl:message>
      <xsl:variable xmlns:comet="http://natasha.obdurodon.org/"
                    xmlns:x="http://www.jenitennison.com/xslt/xspec"
                    name="Q{urn:x-xspec:compile:impl}expect-d55e24"
                    select="27"><!--expected result--></xsl:variable>
      <xsl:variable name="Q{urn:x-xspec:compile:impl}successful"
                    as="Q{http://www.w3.org/2001/XMLSchema}boolean"
                    select="Q{urn:x-xspec:common:deep-equal}deep-equal($Q{urn:x-xspec:compile:impl}expect-d55e24, $Q{http://www.jenitennison.com/xslt/xspec}result, '')"/>
      <xsl:if test="not($Q{urn:x-xspec:compile:impl}successful)">
         <xsl:message>      FAILED</xsl:message>
      </xsl:if>
      <xsl:element name="test" namespace="http://www.jenitennison.com/xslt/xspec">
         <xsl:attribute name="id" namespace="">x3279f0b9-c964-32d7-ab1e-5cfe61c3ed3d-expect1</xsl:attribute>
         <xsl:attribute name="successful"
                        namespace=""
                        select="$Q{urn:x-xspec:compile:impl}successful"/>
         <xsl:element name="label" namespace="http://www.jenitennison.com/xslt/xspec">
            <xsl:text>27 (integer) returns itself</xsl:text>
         </xsl:element>
         <xsl:call-template name="Q{urn:x-xspec:common:report-sequence}report-sequence">
            <xsl:with-param name="sequence" select="$Q{urn:x-xspec:compile:impl}expect-d55e24"/>
            <xsl:with-param name="report-name" select="'expect'"/>
         </xsl:call-template>
      </xsl:element>
   </xsl:template>
</xsl:stylesheet>
