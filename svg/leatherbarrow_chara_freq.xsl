<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/2000/svg" 
    version="3.0">
    
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:variable name="book8" as="document-node()" 

    <xsl:variable name="barWidth" as="xs:double" select="30"/>
    <xsl:variable name="barSpacing" as="xs:double" select="$barWidth div 2"/>
    <xsl:variable name="totalBarWidth" as="xs:double" select="$barWidth + $barSpacing"/>
    <xsl:variable name="yScale" as="xs:double" select="5"/>
    <xsl:variable name="maxHeight" as="xs:double" select="100 * $yScale"/>
    <xsl:variable name="maxWidth" as="xs:double" select="$totalBarWidth * count($allSongs//song)"/>
    
</xsl:stylesheet>