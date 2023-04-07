<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:comet="http://natasha.obdurodon.org/" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="#all" version="3.0" xmlns="http://www.w3.org/2000/svg"
  xmlns:map="http://www.w3.org/2005/xpath-functions/map">
  <!-- ================================================================== -->
  <xsl:output method="xml" indent="yes"/>
  <!-- ================================================================== -->
  <!-- Stylesheet variables                                               -->
  <!-- ================================================================== -->
  <xsl:variable name="book8" as="document-node()"
    select="document('../XML/War-And-Peace_Book-Eight.xml')"/>
  <xsl:variable name="allSongs" as="document-node()+"
    select="collection('../XML/xml_lyrics?match=\d.*\.xml')"/>
  <xsl:variable name="novel-characters-count" as="xs:integer" select="count($book8//chara)"/>
  <xsl:variable name="song-characters-count" as="xs:integer" select="count($allSongs//chara)"/>
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
  <xsl:variable name="maxCount" as="xs:integer" select="
      map:for-each(map:merge(($novel-characters, $song-characters)), function ($k, $v) {
        $v
      }) => max()"/>
  <xsl:variable name="barWidth" as="xs:double" select="30"/>
  <xsl:variable name="barSpacing" as="xs:double" select="$barWidth div 2"/>
  <xsl:variable name="totalBarWidth" as="xs:double" select="$barWidth + $barSpacing"/>
  <xsl:variable name="yScale" as="xs:double" select="5"/>
  <xsl:variable name="maxHeight" as="xs:double" select="100 * $yScale"/>
  <xsl:variable name="maxWidth" as="xs:double"
    select="($barWidth + $totalBarWidth) * count(map:keys($novel-characters))"/>
  <!-- ================================================================== -->
  <!-- User-defined functions                                             -->
  <!-- ================================================================== -->
  <xsl:function name="comet:titleCase" as="xs:string">
    <!-- ================================================================ -->
    <!-- Capitalize first letter of each word in phrase                   -->
    <!--                                                                  -->
    <!-- Parameter:                                                       -->
    <!--   $input as xs:string : phrase to be initial-capitalized         -->
    <!--                                                                  -->
    <!-- Result: xs:string                                                -->
    <!-- ================================================================ -->
    <xsl:param name="input" as="xs:string"/>
    <xsl:value-of select="
        tokenize($input)
        ! (substring(., 1, 1) ! upper-case(.) || lower-case(substring(., 2)))"/>
  </xsl:function>
  <xsl:function name="comet:round-up-to-integer" as="xs:integer">
    <!-- ================================================================ -->
    <!-- Round double up to closest multiple of specified integer         -->
    <!--                                                                  -->
    <!-- Parameters:                                                      -->
    <!--   $input as xs:double : value to be rounded up                   -->
    <!--   $rounding-target as xs:integer : integer for multiple target   -->
    <!--                                                                  -->
    <!-- Result: xs:integer                                               -->
    <!--                                                                  -->
    <!-- If input is already integer multiple of rounding target, return  -->
    <!-- Else integer division finds greatest lower multiple, add         -->
    <!--   rounding-target to bring to lowest higher multiple             -->
    <!-- ================================================================ -->
    <xsl:param name="input" as="xs:double"/>
    <xsl:param name="rounding-target" as="xs:integer"/>
    <xsl:sequence select="
        if ($input mod $rounding-target eq 0) then
          $input cast as xs:integer
        else
          $input idiv $rounding-target * $rounding-target + $rounding-target"/>
  </xsl:function>
  <!-- ================================================================== -->
  <!-- Templates                                                          -->
  <!-- ================================================================== -->
  <xsl:template name="xsl:initial-template">
    <svg viewBox="-150 -{$maxHeight + 25} {$maxWidth + 300} {$maxHeight + 300}" width="100%"
      style="background-color:#FED69A;">
      <!-- ============================================================== -->
      <!-- Horizontal ruling lines, tick marks, labels                    -->
      <!--                                                                -->
      <!-- Ruling line Y positions should range by threes from 0 to max   -->
      <!--   height rounded up to the nearest multiple of three (e.g.,    -->
      <!--   27.8 would be rounded up to 30                               -->
      <!--                                                                -->
      <!-- Tops of bars are plotted by count, but they must be labeled    -->
      <!--   by percentage. This means that positions of ruling lines     -->
      <!--   must be computed by inverting the function, that is, by      -->
      <!--   by going from 3%, 6%, etc. to a value corresponding to the   -->
      <!--   count that would land at that height                         -->
      <!--                                                                -->
      <!-- Formula for **bar** percentage label is p = 100 * c / t        -->
      <!--   p = percentage, c = count for character,                     -->
      <!--   t = count for all characters                                 -->
      <!-- Invert as p * t / 100 = c                                      -->
      <!--   E.g.: 3% * 1058 / 100 = y-pos for 3%                         -->
      <!--                                                                -->
      <!-- Interim variables                                              -->
      <!--   $max-novel-pct : highest character percentage value in novel -->
      <!--   $y-ruling-max : highest y position for ruling line (integers -->
      <!--     evenly divisible by three)                                 -->
      <!--   $y-ruling-range : integer percentages for y ruling           -->
      <!-- ============================================================== -->
      <xsl:variable name="max-novel-pct" as="xs:double"
        select="$novel-characters?* => max() div $novel-characters-count * 100"/>
      <xsl:variable name="y-ruling-max" as="xs:integer"
        select="comet:round-up-to-integer($max-novel-pct, 3)"/>
      <xsl:variable name="y-ruling-range" as="xs:integer+"
        select="(0 to $y-ruling-max)[. mod 3 eq 0]"/>
      <xsl:for-each select="$y-ruling-range">
        <xsl:variable name="yPos" as="xs:double" select=". * $novel-characters-count div 100"/>
        <line x1="0" y1="-{$yPos}" x2="{$maxWidth + $barSpacing}" y2="-{$yPos}" stroke="silver"
          stroke-width="1"/>
        <text x="-5" y="-{$yPos}" text-anchor="end" dominant-baseline="central" font-size="smaller">
          <xsl:value-of select="."/>
        </text>
      </xsl:for-each>
      <!-- ============================================================== -->
      <!-- Bars and bar labels (names, percentages)                       -->
      <!-- ============================================================== -->
      <xsl:for-each select="map:keys($novel-characters)">
        <xsl:sort/>
        <!-- ============================================================ -->
        <!-- Local variables                                              -->
        <!-- ============================================================ -->
        <xsl:variable name="xPos" as="xs:double"
          select="$barSpacing + (position() - 1) * (2 * $barWidth + $barSpacing)"/>
        <xsl:variable name="yPos" as="xs:double" select="$novel-characters(.)"/>
        <xsl:variable name="xPos2" as="xs:double" select="$xPos + $barWidth"/>
        <xsl:variable name="yPos2" as="xs:double" select="$song-characters(.)"/>
        <!-- ============================================================ -->
        <!-- Plot bars and bar names                                      -->
        <!-- ============================================================ -->
        <rect x="{$xPos}" y="-{$yPos}" width="{$barWidth}" height="{$yPos}" fill="navy"/>
        <text x="{$xPos2}" y="10" writing-mode="tb">
          <xsl:value-of select="comet:titleCase(.)"/>
        </text>
        <rect x="{$xPos2}" y="-{$yPos2}" width="{$barWidth}" height="{$yPos2}" fill="crimson"/>
        <!-- ============================================================ -->
        <!-- Plot bar percentage labels                                   -->
        <!-- ============================================================ -->
        <xsl:variable name="novel-chara-percent" as="xs:double"
          select="100 * $novel-characters(.) div $novel-characters-count"/>
        <text x="{$xPos + ($barWidth div 2)}" y="-{$yPos + 5}" text-anchor="middle" font-size="12">
          <xsl:value-of select="(round($novel-chara-percent, 2))"/>% </text>
        
        <xsl:variable name="song-chara-percent" as="xs:double" select="100 * $song-characters(.) div $song-characters-count"/>
        <text x="{$xPos2 + ($barWidth div 2)}" y="-{$yPos2 + 5}" text-anchor="middle" font-size="12">
          <xsl:value-of select="(round($song-chara-percent, 2))"/>% </text>
      </xsl:for-each>
      <!-- ======================================================== -->
      <!-- Axes                                                     -->
      <!-- ======================================================== -->
      <line x1="0" y1="0" x2="{$maxWidth + $barSpacing}" y2="0" stroke="black"
        stroke-linecap="square"/>
      <line x1="0" y1="0" x2="0" y2="-{$maxHeight - 200}" stroke="black" stroke-linecap="square"/>
      <!-- ======================================================== -->
      <!-- Chart Labels                                              -->
      <!-- ======================================================== -->
      <text x="{$maxWidth div 2}" y="{$yScale * 35}" text-anchor="middle"
        font-size="large">Characters</text>
      <text x="-80" y="-{$maxHeight div 2}" writing-mode="tb" text-anchor="-end"
        font-size="large">
        <tspan>Frequency of Character</tspan>
      </text>
      <text x="-110" y="-{$maxHeight div 2}" writing-mode="tb" text-anchor="-end"
        font-size="large">
        <tspan>References by Percentage</tspan>
      </text>
      <!-- ======================================================== -->
      <!-- Key                                                      -->
      <!-- ======================================================== -->
      <text x="{$maxWidth div 2}" y="{$yScale * -70}" text-anchor="middle" font-size="large">Comparing the Percentage of Character References between Novel and Musical</text>
      <rect x="{$maxWidth + 50}" y="{$yScale * -40}" width="300" height="100" fill="white"/>
      <text
        x="{$maxWidth + 60}" y="-{$yScale * 34}" font-size="large">
        <tspan>KEY:</tspan>
      </text>
      <text
        x="{$maxWidth + 100}" y="-{$yScale * 28}" text-anchor="-end" font-size="small">
        <tspan>"The Great Comet"</tspan>
      </text>
      <text
        x="{$maxWidth + 100}" y="-{$yScale * 23}" text-anchor="-end" font-size="small" font-style="italic">
        <tspan>War and Peace</tspan> 
      </text>
      <rect x="{$maxWidth + 60}" y="-{$yScale * 26}" width="15" height="15" fill="crimson"/>
      <rect x="{$maxWidth + 60}" y="-{$yScale * 31}" width="15" height="15" fill="navy"/>
    </svg>
  </xsl:template>
</xsl:stylesheet>
