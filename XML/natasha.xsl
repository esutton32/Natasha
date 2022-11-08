<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" include-content-type="no"
        indent="yes"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Lyrics</title>
            </head>
            <body>
                <h1>
                    <xsl:apply-templates select="//metadata"/>
                </h1>
                <section>
                    <xsl:apply-templates select="//metadata/characters"/>
                    <br/>
                </section>
                <xsl:choose>
                    <xsl:when test="//lyrics/verse">
                        <xsl:apply-templates select="//verse"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="//chorus"/>
                    </xsl:otherwise>
                </xsl:choose>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="metadata">
        <xsl:apply-templates select="name"/>
    </xsl:template>
    <xsl:template match="metadata/characters">
        Featured Characters: <xsl:apply-templates select="c=>string-join(', ')"/>
        <br/>
        Placeholder (percentage in W+P): 
    </xsl:template>
    <xsl:template match="verse">
        <verse>
            <stanza>
                <xsl:apply-templates select="stanza"/>
            </stanza>
        </verse>
    </xsl:template>
    <xsl:template match="chorus">
        <chorus>
            <stanza>
                <xsl:apply-templates select="stanza"/>
            </stanza>
        </chorus>
    </xsl:template>
    <xsl:template match="stanza">
        <div>
            <p> [<xsl:apply-templates select="@speaker"/>] <xsl:apply-templates select="line"/>
            </p>
            <br/>
        </div>
    </xsl:template>
    <xsl:template match="line">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
</xsl:stylesheet>
