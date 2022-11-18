<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" omit-xml-declaration="no" include-content-type="no" indent="yes"/>
    <xsl:template match="/">
        <body>
            <xsl:apply-templates select="//references/book"/>
        </body>
    </xsl:template>
    <xsl:template match="book">
        <book n="{@n}">
            <xsl:apply-templates select="chapter"/>
        </book>
    </xsl:template>
    
    <xsl:template match="chapter">
        <chapter n="{@n}">
            <xsl:apply-templates select="ref"/>
        </chapter>
    </xsl:template>
    
    <xsl:template match="ref">
        <ref xml:id="wp-ref{count(preceding::ref) + 1}" song="{@song}">
            <xsl:apply-templates/>
        </ref>
    </xsl:template> 
</xsl:stylesheet>
