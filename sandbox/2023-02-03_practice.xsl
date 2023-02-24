<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:comet="http://natasha.obdurodon.org/" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all" version="3.0" xmlns="http://www.w3.org/2000/svg"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map">
    <!-- ================================================================ -->
    <xsl:output method="xml" indent="yes"/>
    <!-- ================================================================ -->
    <!-- Stylesheet variables                                             -->
    <!-- ================================================================ -->
    <xsl:variable name="book8" as="document-node()"
        select="document('../XML/War-And-Peace_Book-Eight.xml')"/>
    <xsl:variable name="allSongs" as="document-node()+"
        select="collection('../XML/xml_lyrics?match=\d.*\.xml')"/>
    <xsl:variable name="novel-characters" as="map(*)">
        <xsl:map>
            <xsl:for-each-group select="$book8//chara/@ref" group-by=".">
                <xsl:map-entry key="current-grouping-key()">
                    <xsl:value-of select="count(current-group())"/>
                </xsl:map-entry>
            </xsl:for-each-group>
        </xsl:map>
    </xsl:variable>
    <xsl:variable name="song-characters" as="map(*)">
        <xsl:map>
            <xsl:for-each-group select="$allSongs//chara/@ref" group-by=".">
                <xsl:map-entry key="current-grouping-key()">
                    <xsl:value-of select="count(current-group())"/>
                </xsl:map-entry>
            </xsl:for-each-group>
        </xsl:map>
    </xsl:variable>
    <xsl:variable name="maxCount" as="xs:integer" select="map:for-each(map:merge(($novel-characters, $song-characters)), function($k, $v) {$v}) => max()"/>
    <xsl:variable name="barWidth" as="xs:double" select="30"/>
    <xsl:variable name="barSpacing" as="xs:double" select="$barWidth div 2"/>
    <xsl:variable name="totalBarWidth" as="xs:double" select="$barWidth + $barSpacing"/>
    <xsl:variable name="yScale" as="xs:double" select="5"/>
    <xsl:variable name="maxHeight" as="xs:double" select="100 * $yScale"/>
    <xsl:variable name="maxWidth" as="xs:double" select="$totalBarWidth * count($novel-characters)"/>
    <!-- User-defined functions -->
    <xsl:function name="comet:titleCase" as="xs:string">
        <xsl:param name="input" as="xs:string"/>
        <!--<xsl:value-of select="substring($input, 1, 1) || lower-case(substring($input, 2))"/>-->
        <xsl:value-of
            select="tokenize($input) ! (substring(., 1, 1) || lower-case(substring(., 2)))"/>
    </xsl:function>
    <!-- Templates -->
    <xsl:template name="xsl:initial-template">
        <!-- ================================================================ -->
        <!-- SVG                                                        -->
        <!-- ================================================================ -->
        <svg viewBox="-150 -{$maxHeight + 25} {$maxWidth + 800} {$maxHeight + 300}" width="100%"
            style="background-color:#FED69A;"> 
            <!-- ==================================================== -->
            <!-- Horizontal ruling lines, tick marks, labels          -->
            <!-- ==================================================== -->
            
            <xsl:for-each select="0 to 10">
                <xsl:variable name="yPos" as="xs:integer" select=". * 20"/>
                <line x1="0" y1="-{$yPos}" x2="300" y2="-{$yPos}" stroke="silver"/>
                <text x="-20" y="-{$yPos}" text-anchor="end" dominant-baseline="central">
                    <xsl:value-of select="$novel-characters(.)"/>
                </text>
            </xsl:for-each>
            <xsl:for-each select="map:keys($novel-characters)">
                <xsl:sort/>

                <!--<name><xsl:value-of select="."/></name>
                <count><xsl:value-of select="$novel-characters(.)"/></count>-->

                <xsl:variable name="xPos" as="xs:double"
                    select="$barSpacing + (position() - 1) * (2 * $barWidth + $barSpacing)"/>
                <xsl:variable name="yPos" as="xs:double" select="$novel-characters(.)"/>
                <xsl:variable name="xPos2" as="xs:double" select="$xPos + $barWidth"/>
                <xsl:variable name="yPos2" as="xs:double" select="$song-characters(.)"/>
                <rect x="{$xPos}" y="-{$yPos}" width="{$barWidth}" height="{$yPos}" fill="blue"/>
                <text x="{$xPos2}" y="10" writing-mode="tb">
                    <xsl:value-of select="comet:titleCase(.)"/>
                </text>
                <rect x="{$xPos2}" y="-{$yPos2}" width="{$barWidth}" height="{$yPos2}" fill="red"/>

                <!-- ============================================================ -->
                <!-- Bar label (percentage)                                       -->
                <!-- ============================================================ -->
                <text x="{$xPos + ($barWidth div 2)}" y="-{$yPos + 5}" text-anchor="middle" font-size="smaller">
                    <xsl:value-of select="$novel-characters(.)"/>
                </text>
                <text x="{$xPos2 + ($barWidth div 2)}" y="-{$yPos2 + 5}" text-anchor="middle" font-size="smaller">
                    <xsl:value-of select="$song-characters(.)"/> 
                </text>
            </xsl:for-each>

            <!-- ======================================================== -->
            <!-- Axes                                                     -->
            <!-- ======================================================== -->
            <line x1="0" y1="0" x2="{$maxWidth}" y2="0" stroke="black" stroke-linecap="square"/>
            <line x1="0" y1="0" x2="0" y2="-{$maxHeight}" stroke="black" stroke-linecap="square"/>
            <!-- ======================================================== -->
            <!-- Axis labels                                              -->
            <!-- ======================================================== -->
            <text x="{$maxWidth div 2}" y="{$yScale * 35}" text-anchor="middle" font-size="larger"
                >Characters</text>
            <text x="-80" y="-{$maxHeight div 2}" writing-mode="tb" text-anchor="middle"
                font-size="larger">
                <tspan>Frequency of Character References</tspan>
            </text>
            <text x="-110" y="-{$maxHeight div 2}" writing-mode="tb" text-anchor="middle"
                font-size="larger">
                <tspan>by Count</tspan>
            </text>
            <!-- <xsl:for-each select="map:keys($song-characters)">
                <xsl:sort/>
                <xsl:variable name="xPos2" as="xs:double" select="25 + position() * 50"/>
                <xsl:variable name="yPos2" as="xs:double" select="$song-characters(.)"/>-->
            <!--<name><xsl:value-of select="."/></name>
                <count><xsl:value-of select="$novel-characters(.)"/></count>-->
            <!--<rect x="{$xPos2}" y="-{$yPos2}" width="20"
                    height="{$yPos2}" fill="purple"/>
                <text x="{$xPos2 + 10}" y="20" text-anchor="middle">
                    <xsl:value-of select="."/>
                </text>
            </xsl:for-each>-->
        </svg>
    </xsl:template>
    <!--Ideal key/value in map: key for each character name, value represents total time tagged as speaker (times
            on stage) plus referenced by others (social weight of character). HOWEVER, sometimes speaker is tagged as ALL, 
            so we need to +1 to count value for each character (to accurately reflect total character occurrences in musical).-->




</xsl:stylesheet>
