<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    version="3.0" xmlns="http://www.w3.org/2000/svg" xmlns:map="http://www.w3.org/2005/xpath-functions/map">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="allSongs" as="document-node()+"
            select="collection('../XML/xml_lyrics?match=\d.*\.xml')"/>
    <xsl:template name="xsl:initial-template">
        <xsl:variable name="song-characters" as="map(*)">
            <!--Ideal key/value in map: key for each character name, value represents total time tagged as speaker (times
            on stage) plus referenced by others (social weight of character). HOWEVER, sometimes speaker is tagged as ALL, 
            so we need to +1 to count value for each character (to accurately reflect total character occurrences in musical).-->
            <xsl:map>
                <xsl:for-each-group select="$allSongs//chara/@ref" group-by=".">
                    <xsl:map-entry key="current-grouping-key()">
                        <xsl:value-of select="count(current-group())"/>
                    </xsl:map-entry>
                </xsl:for-each-group>
            </xsl:map>
        </xsl:variable>
        <svg viewBox="0 -300 300 330" height="350" width="500">
            <xsl:for-each select="map:keys($song-characters)">
                <xsl:sort/>
                <xsl:variable name="xPos" as="xs:double" select="position() * 30"/>
                <xsl:variable name="yPos" as="xs:double" select="$song-characters(.)"/> 
                <!--<name><xsl:value-of select="."/></name>
                <count><xsl:value-of select="$novel-characters(.)"/></count>-->
                <rect x="{$xPos}" y="-{$yPos}" width="20"
                    height="{$yPos}" fill="blue"/>
                <text x="{$xPos + 10}" y="10" text-anchor="middle">
                    <xsl:value-of select="."/>
                </text>
            </xsl:for-each>
        </svg>
    </xsl:template>
</xsl:stylesheet>