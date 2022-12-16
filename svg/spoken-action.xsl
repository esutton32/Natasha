<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/2000/svg" version="3.0">
    <xsl:output method="xml" indent="yes"/>

    <xsl:variable name="barWidth" as="xs:double" select="50"/>
    <xsl:variable name="barSpacing" as="xs:double" select="$barWidth div 2"/>
    <xsl:variable name="totalBarWidth" as="xs:double" select="($barWidth + $barSpacing) * 2"/>
    <xsl:variable name="yScale" as="xs:double" select="10"/>
    <xsl:variable name="maxHeight" as="xs:double" select="60 * $yScale"/>
    <xsl:variable name="maxWidth" as="xs:double"
        select="$totalBarWidth * count(distinct-values(//@speaker))"/>


    <xsl:template match="/">
        <svg height="{$maxHeight + 150}" viewBox="-100 -100 3000 100" width="100%">
            <xsl:for-each select="1 to 6">
                <xsl:variable name="height" as="xs:double" select=". * 10 * $yScale"/>
                <line x1="0" y1="-{$height}" x2="-10" y2="-{$height}" stroke="black"/>
                <line x1="0" y1="-{$height}" x2="{$maxWidth}" y2="-{$height}" stroke="lightgray"/>
                <text x="-20" y="-{$height}" text-anchor="end" dominant-baseline="central">
                    <xsl:value-of select=". * 10"/>
                </text>
            </xsl:for-each>
            <xsl:apply-templates select="//stanza/@speaker"></xsl:apply-templates>
            <line x1="0" y1="0" x2="{$maxWidth}" y2="0" stroke="black" stroke-linecap="square"/>
            <line x1="0" y1="0" x2="0" y2="-{$maxHeight}" stroke="black" stroke-linecap="square"/>
            <text x="{$maxWidth div 2}" y="{10 * $yScale}" text-anchor="middle" font-size="larger"
                >number of instances of spoken action</text>
            <text x="-60" y="-{$maxHeight div 2}" writing-mode="tb" text-anchor="middle"
                font-size="larger">yasssss characters</text>
        </svg>
    </xsl:template>

    <xsl:template match="@speaker">
        <!-- Full rectangle will be two large rectangles; self1st is one and then 3rd person is self1st+self3rd -->
        <xsl:variable name="self1st" as="xs:integer"
            select="count(//s-action[@kind = 'self' and @type = '1st']/ancestor::stanza[@speaker = current()])"/>
        <xsl:variable name="self3rd" as="xs:integer"
            select="count(//s-action[@kind = 'self' and @type = '3rd']/ancestor::stanza[@speaker = current()])"/>
        <xsl:variable name="longrect" as="xs:integer" select="$self1st + $self3rd"/>
        <xsl:variable name="totalLength" as="xs:double" select="$totalBarWidth * 2 + 60"/>

        <xsl:variable name="xPos" as="xs:double" select="
                ($totalLength div 2) +
                (position() - 1) * ($barWidth + $barSpacing)"/>

        <rect x="{$totalBarWidth * (position()-1)}" y="-{$longrect * $yScale}" width="{$barWidth}"
            height="{$longrect * $yScale}" fill="green"/>
        <rect x="{$totalBarWidth * (position()-1)}" y="-{$self1st * $yScale}" width="{$barWidth}"
            height="{$self1st * $yScale}" fill="red"/>
        <rect x="{$totalBarWidth * (position()-1) + 60}" y="-{$self1st * $yScale}"
            width="{$barWidth}" height="{$self1st * $yScale}" fill="pink"/>

        <!-- LABELING EACH BAR -->
        <text x="{$xPos}" y="{5 * $yScale}" text-anchor="middle" font-size="smaller">
            <xsl:value-of select="current()"/>
        </text>
        <!--<text x="{$xPos + $barWidth div 2}" y="-{$refPercentage*10 + 5}" text-anchor="middle">
            <xsl:value-of select="round-half-to-even($refPercentage)"/><xsl:text>%</xsl:text>
        </text> -->
        <!-- labeling each rect w name of song 
        <text x="{$xPos + $barWidth div 2}" y="{5 * $yScale}" text-anchor="middle">
            <xsl:value-of select="@title"/>
        </text>-->
    </xsl:template>

</xsl:stylesheet>
