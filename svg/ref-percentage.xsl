<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/2000/svg" version="3.0">
    <!-- ================================================================ -->
    <!-- Run with no input                                                -->
    <!-- Assumes: specific path from XSLT to individual song files        -->
    <!--          all filenames in song-file directory that begin with a  -->
    <!--            digit are songs; filenames that don't begin with a    -->
    <!--            are not                                               -->
    <!-- ================================================================ -->
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <!-- ================================================================ -->
    <!-- Stylesheet variables                                             -->
    <!-- ================================================================ -->
    <xsl:variable name="allSongs" as="document-node()+"
        select="collection('../XML/xml_lyrics?match=\d.*\.xml')"/>
    <xsl:variable name="barWidth" as="xs:double" select="30"/>
    <xsl:variable name="barSpacing" as="xs:double" select="$barWidth div 2"/>
    <xsl:variable name="totalBarWidth" as="xs:double" select="$barWidth + $barSpacing"/>
    <xsl:variable name="yScale" as="xs:double" select="5"/>
    <xsl:variable name="maxHeight" as="xs:double" select="100 * $yScale"/>
    <xsl:variable name="maxWidth" as="xs:double" select="$totalBarWidth * count($allSongs//song)"/>
    <!-- ================================================================ -->
    <!-- Templates                                                        -->
    <!-- ================================================================ -->
    <xsl:template name="xsl:initial-template">
        <svg viewBox="-100 -{$maxHeight + 25} {$maxWidth + 125} {$maxHeight + 300}" width="100%"
            style="background-color:#FED69A;">
            <xsl:for-each select="0 to 10">
                <!-- ==================================================== -->
                <!-- Horizontal ruling lines, tick marks, labels          -->
                <!-- ==================================================== -->
                <xsl:variable name="yPos" as="xs:double" select=". * 10 * $yScale"/>
                <line x1="0" y1="-{$yPos}" x2="-10" y2="-{$yPos}" stroke="black"/>
                <line x1="0" y1="-{$yPos}" x2="{$maxWidth}" y2="-{$yPos}" stroke="silver"/>
                <text x="-20" y="-{$yPos}" text-anchor="end" dominant-baseline="central">
                    <xsl:value-of select=". * 10"/>
                </text>
            </xsl:for-each>
            <!-- ======================================================== -->
            <!-- Bars and labels for songs                                -->
            <!-- Songs are in a collection, and therefore unspecified     -->
            <!--   order, so sort by filenames (which begin with digits   -->
            <!--   that reflect performance order)                        -->
            <!-- ======================================================== -->
            <xsl:apply-templates select="$allSongs//song">
                <xsl:sort select="base-uri(.)"/>
            </xsl:apply-templates>
            <!-- ======================================================== -->
            <!-- Axes                                                     -->
            <!-- ======================================================== -->
            <line x1="0" y1="0" x2="{$maxWidth}" y2="0" stroke="black" stroke-linecap="square"/>
            <line x1="0" y1="0" x2="0" y2="-{$maxHeight}" stroke="black" stroke-linecap="square"/>
            <!-- ======================================================== -->
            <!-- Axis labels                                              -->
            <!-- ======================================================== -->
            <text x="{$maxWidth div 2}" y="{35 * $yScale}" text-anchor="middle" font-size="larger"
                >Songs</text>
            <text x="-70" y="-{$maxHeight div 2}" writing-mode="tb" text-anchor="middle"
                font-size="larger">
                <tspan>Percentage of song lines drawn from </tspan>
                <tspan font-style="italic">War and Peace</tspan>
            </text>
        </svg>
    </xsl:template>
    <xsl:template match="song">
        <xsl:message select="base-uri(.)"/>
        <!-- ============================================================ -->
        <!-- Template variables                                           -->
        <!--                                                              -->
        <!-- Lines from War and peace have a <wp-ref> ancestor            -->
        <!-- ============================================================ -->
        <xsl:variable name="allLines" as="xs:integer" select="count(descendant::line)"/>
        <xsl:variable name="refLines" as="xs:integer"
            select="count(descendant::line[ancestor::wp-ref])"/>
        <xsl:variable name="refPercentage" as="xs:double" select="$refLines div $allLines * 100"/>
        <xsl:variable name="barHeight" as="xs:double" select="$refPercentage * $yScale"/>
        <xsl:variable name="xPos" as="xs:double" select="
                ($barSpacing div 2) (: Offset all bars from left by half of bar width :) +
                (position() - 1) * ($totalBarWidth)"/>
        <xsl:variable name="barCenterXPos" as="xs:double" select="$xPos + $barWidth div 2"/>
        <!-- ============================================================ -->
        <!-- Bar                                                          -->
        <!-- ============================================================ -->
        <rect x="{$xPos}" y="-{$barHeight}" width="{$barWidth}" height="{$barHeight}" fill="red"/>
        <!-- ============================================================ -->
        <!-- Bar label (song and percentage)                              -->
        <!-- ============================================================ -->
        <text x="{$xPos + $barWidth div 2}" y="5" text-anchor="start" dominant-baseline="middle"
            font-size="smaller" writing-mode="tb">
            <xsl:value-of select="@title"/>
        </text>
        <text x="{$barCenterXPos}" y="-{$barHeight + 5}" text-anchor="middle">
            <xsl:value-of select="round-half-to-even($refPercentage)"/>
            <xsl:text>%</xsl:text>
        </text>
    </xsl:template>
</xsl:stylesheet>
