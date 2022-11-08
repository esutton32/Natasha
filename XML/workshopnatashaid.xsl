<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" omit-xml-declaration="no" include-content-type="no" indent="yes"/>

    <xsl:template match="/">
        <body>
            <xsl:apply-templates select="//chapter/ref"/>
        </body>
    </xsl:template>
    
    <xsl:template match="chapter/ref">
        <ref xml:id="wp-ref-{count(preceding::ref) + 1}">
            <!--<xsl:value-of select="count(preceding::fn) + 1"/> -->
            <xsl:apply-templates/>
        </ref>
        <!--<ref>
            <xsl:value-of select="count(preceding::ref) + 1"/>
            <xsl:apply-templates/>
        </ref> -->
    </xsl:template>
</xsl:stylesheet>
