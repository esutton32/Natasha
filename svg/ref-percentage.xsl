<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/2000/svg" version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="barWidth" as="xs:double" select="100"/>
    <xsl:variable name="barSpacing" as="xs:double" select="$barWidth div 2"/> 
    <xsl:variable name="totalBarWidth" as="xs:double" select="$barWidth + $barSpacing"/>
        <xsl:template match="/">     
            <svg viewBox="0 -100 4100 100" width="100%"> 
            <xsl:apply-templates select="//song"/>
        </svg>
    </xsl:template>
    <xsl:template match="song">      
        <xsl:variable name="allLines" as="xs:integer" select="count(descendant::line)"/>
        <xsl:variable name="refLines" as="xs:integer" select="count(descendant::line[ancestor::wp-ref])"/>
        <xsl:variable name="refPercentage" as="xs:double" select="$refLines div $allLines * 100"/>
        <rect x="{$totalBarWidth * (position()-1)}" y="-{$refPercentage}" width="{$barWidth}" height="{$refPercentage}" fill="red"></rect>
    </xsl:template>
</xsl:stylesheet>
