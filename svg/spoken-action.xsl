<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/2000/svg" version="3.0">
    <xsl:output method="xml" indent="yes"/>

    <xsl:variable name="barWidth" as="xs:double" select="50"/>
    <xsl:variable name="barSpacing" as="xs:double" select="$barWidth div 2"/>
    <xsl:variable name="totalBarWidth" as="xs:double" select="($barWidth + $barSpacing) * 2"/>
    <xsl:variable name="yScale" as="xs:double" select="50"/>
    <xsl:variable name="maxHeight" as="xs:double" select="20 * $yScale"/>
    <xsl:variable name="maxWidth" as="xs:double"
        select="$totalBarWidth * count(distinct-values(//stanza[descendant::s-action]/@speaker)) + $totalBarWidth div 2"/>
    <xsl:variable name="combinedChBarWidth" as="xs:double" select="$totalBarWidth * 2 + 60"/>
    <xsl:variable name="bar-color" as="map(*)" select="
        map {
        'NATASHA': '#8A07E4',
        'PIERRE': '#B65D5D',
        'BOLKONSKY': '#065143',
        'ALL': '#FABC2A',
        'OPERA': '#98D2EB',
        'ANDREY': '#6B351C',
        'HÉLÈNE': '#02BFAB',
        'DOLOKHOV': '#1D5413',
        'ANATOLE': '#F17412'
        }"/>

    <xsl:template match="/">
        <svg viewBox="-100 -{$maxHeight+50} {$maxWidth + 250} {$maxHeight + 250}" width="100%"
            height="{$maxHeight + 250}">
            <xsl:for-each select="0 to 4">
                <xsl:variable name="height" as="xs:double" select=". * 5 * $yScale"/>
                <line x1="0" y1="-{$height}" x2="-10" y2="-{$height}" stroke="black"/>
                <line x1="0" y1="-{$height}" x2="{$maxWidth}" y2="-{$height}" stroke="lightgray"/>
                <text x="-20" y="-{$height}" text-anchor="end" dominant-baseline="central">
                    <xsl:value-of select=". * 5"/>
                </text>
            </xsl:for-each>

            <xsl:for-each-group select="//stanza[descendant::s-action]" group-by="@speaker">
                <xsl:sort select="current-grouping-key()"/>
                <!--  -->
                <xsl:variable name="self1st" as="xs:integer"
                    select="count(current-group()//s-action[@kind = 'self' and @type = '1st'])"/>
                <xsl:variable name="self3rd" as="xs:integer"
                    select="count(current-group()//s-action[@kind = 'self' and @type = '3rd'])"/>
                <!--<xsl:variable name="otherDesc" as="xs:integer" select="count(current-group()//s-action[@kind = 'other'])"/>-->
                <xsl:variable name="otherDesc" select="current-group()//s-action[@kind = 'other']"/>
                <xsl:variable name="longrect" as="xs:integer" select="$self1st + $self3rd"/>

                <xsl:variable name="xPos" as="xs:double" select="
                        $totalBarWidth * position() - $barWidth"/>

                <!--<xsl:message select="string-join((current-grouping-key(), $self1st, $self3rd, $otherDesc), ',')"></xsl:message>-->

                <!-- rectangles -->
                <rect x="{$xPos - $barWidth - 5}" y="-{$longrect * $yScale}" width="{$barWidth}"
                    height="{$longrect * $yScale}" fill="#66DEDC" stroke="black" stroke-width="1"/>
                <rect x="{$xPos - $barWidth - 5}" y="-{$self1st * $yScale}" width="{$barWidth}"
                    height="{$self1st * $yScale}" fill="red" stroke="black" stroke-width="1"/>
                <xsl:for-each select="distinct-values($otherDesc/@descr)">
                    <xsl:sort/>
                    <xsl:variable name="speakerDescrCount" as="xs:integer"
                        select="count($otherDesc[@descr eq current()])"/>
                    <xsl:variable name="prevDescrCount" as="xs:integer"
                        select="count($otherDesc[@descr lt current()])"/>
                    <xsl:message
                        select="string-join((current-grouping-key(), ., $speakerDescrCount, $prevDescrCount), ',')"/>
                    <rect x="{$xPos + 5}" y="-{sum(($speakerDescrCount, $prevDescrCount))* $yScale}"
                        width="{$barWidth}" height="{$speakerDescrCount * $yScale}" fill="{$bar-color(current())}"
                        stroke="black" stroke-width="1">
                        <title>
                            <xsl:value-of select="concat(current(), ' (', $speakerDescrCount, ')')"/>
                        </title>
                    </rect>
                </xsl:for-each>
                <!--<rect x="{$xPos + 5}" y="-{$otherDesc * $yScale}"
                    width="{$barWidth}" height="{$otherDesc * $yScale}" fill="pink"/>-->

                <!-- labels -->
                <text x="{$xPos}" y="20" text-anchor="middle" font-size="smaller">
                    <xsl:value-of select="current-grouping-key()"/>
                </text>             
            </xsl:for-each-group>

            <line x1="0" y1="0" x2="{$maxWidth}" y2="0" stroke="black" stroke-linecap="square"/>
            <line x1="0" y1="0" x2="0" y2="-{$maxHeight}" stroke="black" stroke-linecap="square"/>
            <text x="{$maxWidth div 2}" y="45" text-anchor="middle" font-size="larger"
                >Characters who Perform Spoken Action</text>
            <text x="-60" y="-{$maxHeight div 2}" writing-mode="tb" text-anchor="middle"
                font-size="larger">Number of Instances of Spoken Action</text>
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
        <text x="{$xPos}" y="10" text-anchor="middle" font-size="smaller">
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
