<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all" version="3.0"
    xmlns="http://www.w3.org/2000/svg" xmlns:map="http://www.w3.org/2005/xpath-functions/map">
    <!-- ================================================================ -->   
    <xsl:output method="xml" indent="yes"/>
    <!-- ================================================================ -->
    <!-- Stylesheet variables                                             -->
    <!-- ================================================================ -->
    <xsl:variable name="book8" as="document-node()"
        select="document('../XML/War-And-Peace_Book-Eight.xml')"/>
    <xsl:variable name="allSongs" as="document-node()+"
        select="collection('../XML/xml_lyrics?match=\d.*\.xml')"/>
    <xsl:template name="xsl:initial-template">       
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
        <xsl:variable name="barWidth" as="xs:double" select="30"/>
        <xsl:variable name="barSpacing" as="xs:double" select="$barWidth div 2"/>
        <xsl:variable name="totalBarWidth" as="xs:double" select="$barWidth + $barSpacing"/>
        <xsl:variable name="yScale" as="xs:double" select="5"/>
        <xsl:variable name="maxHeight" as="xs:double" select="100 * $yScale"/>
        <xsl:variable name="maxWidth" as="xs:double" select="$totalBarWidth * count($novel-characters)"/>        
        <!-- ================================================================ -->
        <!-- SVG                                                        -->
        <!-- ================================================================ --> 
        <svg viewBox="-150 -{$maxHeight + 25} {$maxWidth + 800} {$maxHeight + 300}" width="100%"
            style="background-color:#FED69A;">
            <xsl:for-each select="map:keys($novel-characters)">
                <xsl:sort/>
                <!-- ==================================================== -->
                <!-- Horizontal ruling lines, tick marks, labels          -->
                <!-- ==================================================== -->    
                
                <xsl:variable name="yPos" as="xs:double" select="$novel-characters(.)"/> 
                <line x1="0" y1="-{$yPos}" x2="-10" y2="-{$yPos}" stroke="black"/>
                <text x="-20" y="-{$yPos}" text-anchor="end" dominant-baseline="central">
                   <xsl:value-of select="$novel-characters(.)"/>
                </text>

                <!-- ======================================================== -->
                <!-- Axes                                                     -->
                <!-- ======================================================== -->
                <line x1="0" y1="0" x2="{$maxWidth}" y2="0" stroke="black" stroke-linecap="square"/>
                <line x1="0" y1="0" x2="0" y2="-{$maxHeight}" stroke="black" stroke-linecap="square"/>
                <!-- ======================================================== -->
                <!-- Axis labels                                              -->
                <!-- ======================================================== -->
                <text x="{$maxWidth div 2}" y="{$yScale * 35}" text-anchor="" font-size="larger"
                    >Characters</text>
                <text x="-80" y="-{$maxHeight div 2}" writing-mode="tb" text-anchor="middle"
                    font-size="larger">
                    <tspan>Frequency of Character References</tspan>
                </text>
                <text x="-110" y="-{$maxHeight div 2}" writing-mode="tb" text-anchor="middle"
                    font-size="larger">
                    <tspan>by Percentage</tspan>
                </text>
                <!--<name><xsl:value-of select="."/></name>
                <count><xsl:value-of select="$novel-characters(.)"/></count>-->
               
            <xsl:variable name="xPos" as="xs:double" select="position() * 50"/>
                <rect x="{$xPos}" y="-{$yPos}" width="20"
                    height="{$yPos}" fill="blue"/>
                <text x="{$xPos + 10}" y="20" text-anchor="middle">
                    <xsl:value-of select="."/>
                </text>
                <xsl:variable name="xPos2" as="xs:double" select="25 + position() * 50"/>
                <xsl:variable name="yPos2" as="xs:double" select="$song-characters(.)"/>
                <rect x="{$xPos2}" y="-{$yPos2}" width="20"
                    height="{$yPos2}" fill="red"/>
                <text x="{$xPos2 + 10}" y="20" text-anchor="middle">
                    <xsl:value-of select="."/>
                </text>

                <!-- ============================================================ -->
                <!-- Bar label (song and percentage)                              -->
                <!-- ============================================================ -->
                <text x="{$xPos + $barWidth div 2}" y="5" text-anchor="start" dominant-baseline="middle"
                    font-size="smaller" writing-mode="tb">
                    <!--<xsl:value-of select="@title"/>-->
                </text>
                <xsl:variable name="barCenterXPos" as="xs:double" select="$xPos + $barWidth div 2"/>
                <xsl:variable name="barHeight" as="xs:double" select="20 * $yScale"/>
                <text x="{$barCenterXPos}" y="-{$barHeight + 5}" text-anchor="middle">
                    <xsl:value-of  select="$novel-characters(.)"/>
                    <xsl:text>%</xsl:text>
                </text>
            </xsl:for-each>
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
