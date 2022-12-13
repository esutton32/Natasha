<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/2000/svg" version="3.0">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:variable name="barWidth" as="xs:double" select="100"/>
    <xsl:variable name="barSpacing" as="xs:double" select="$barWidth div 2"/>
    <xsl:variable name="totalBarWidth" as="xs:double" select="$barWidth + $barSpacing"/>
    <xsl:variable name="yScale" as="xs:double" select="10"/>
    <xsl:variable name="maxHeight" as="xs:double" select="100 * $yScale"/>
    <xsl:variable name="maxWidth" as="xs:double" select="$totalBarWidth * count(//song)"/>


    <xsl:template match="/">
        <svg height="{$maxHeight + 150}" viewBox="-100 -100 4100 100" width="100%">
            <xsl:for-each select="1 to 10">
                <xsl:variable name="height" as="xs:double" select=". * 10 * $yScale"/>
                <line x1="0" y1="-{$height}" x2="-10" y2="-{$height}" stroke="black"/>
                <line x1="0" y1="-{$height}" x2="{$maxWidth}" y2="-{$height}" stroke="lightgray"/>
                <text x="-20" y="-{$height}" text-anchor="end" dominant-baseline="central">
                    <xsl:value-of select=". * 10"/>
                </text>
            </xsl:for-each>
            <xsl:apply-templates select="//song"/>
            <line x1="0" y1="0" x2="{$maxWidth}" y2="0" stroke="black" stroke-linecap="square"/>
            <line x1="0" y1="0" x2="0" y2="-{$maxHeight}" stroke="black" stroke-linecap="square"/>
            <text x="{$maxWidth div 2}" y="{10 * $yScale}" text-anchor="middle" font-size="larger"
                >SONGS</text>
            <text x="-60" y="-{$maxHeight div 2}" writing-mode="tb" text-anchor="middle"
                font-size="larger">PERCENTAGE OF SONG LINES THAT COME FROM WAR AND PEACE</text>
        </svg>
    </xsl:template>

    <xsl:template match="song">
        <xsl:variable name="allLines" as="xs:integer" select="count(descendant::line)"/>
        <xsl:variable name="refLines" as="xs:integer"
            select="count(descendant::line[ancestor::wp-ref])"/>
        <xsl:variable name="refPercentage" as="xs:double" select="$refLines div $allLines * 100"/>
        <xsl:variable name="xPos" as="xs:double" select="
            ($barSpacing div 2) +
            (position() - 1) * ($barWidth + $barSpacing)"/>
        
        <rect x="{$totalBarWidth * (position()-1)}" y="-{$refPercentage * $yScale}" width="{$barWidth}"
            height="{$refPercentage * $yScale}" fill="red"/>
        <!-- LABELING EACH BAR -->
        <text x="{$xPos + $barWidth div 2}" y="{5 * $yScale}" text-anchor="middle" font-size="smaller">
            <xsl:value-of select="@title"/>
        </text>
        <text x="{$xPos + $barWidth div 2}" y="-{$refPercentage*10 + 5}" text-anchor="middle">
            <xsl:value-of select="round-half-to-even($refPercentage)"/><xsl:text>%</xsl:text>
        </text>
        <!-- labeling each rect w name of song 
        <text x="{$xPos + $barWidth div 2}" y="{5 * $yScale}" text-anchor="middle">
            <xsl:value-of select="@title"/>
        </text>-->
    </xsl:template>

</xsl:stylesheet>
