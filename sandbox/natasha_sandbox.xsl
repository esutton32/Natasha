<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" include-content-type="no"
        indent="yes"/>
    <!-- CURRENT PROBLEMS:
    - Type/kind/descr in span class="action" not outputting into elements
    - Lines out of order -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Lyrics</title>
            </head>
            <body>
                <section>
                    <h1>
                        <xsl:apply-templates select="//metadata"/>
                    </h1>
                    <xsl:apply-templates select="//metadata/characters"/>
                    <br/>
                </section>
                <xsl:apply-templates select="//stanza"/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="metadata">
        <xsl:apply-templates select="name"/>
    </xsl:template>
    <xsl:template match="metadata/characters"> Featured Characters: <xsl:apply-templates
            select="c => string-join(', ')"/>
        <br/> Placeholder (percentage in W+P): </xsl:template>
    <xsl:template match="stanza">
        <p>
            <!-- Expressing speaker of a sentence with allowances for multiple speakers -->
            <xsl:text>[</xsl:text>
            <xsl:apply-templates select="@speaker"/>
            <xsl:for-each select="@speaker2">
                <xsl:text>, </xsl:text>
            </xsl:for-each>
            <xsl:apply-templates select="@speaker2"/>
            <xsl:for-each select="@speaker3">
                <xsl:text>, </xsl:text>
            </xsl:for-each>
            <xsl:apply-templates select="@speaker3"/>
            <xsl:text>]</xsl:text>
            <br/>
            <!--Applying templates to transform all lines in their original document order-->
            <xsl:apply-templates/>
            <br/>
        </p>
    </xsl:template>
    <!--Handling specific element types (get rid of non-XHTML attributes later)-->
    <xsl:template match="wp-ref">
        <span id="{@id}" class="ref">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="s-action">
        <span class="action" type="{@type}" kind="{@kind}" descr="{@descr}">
            <xsl:apply-templates select="line"/>
        </span>
    </xsl:template>
    <xsl:template match="chara">
        <span class="chara">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="line">
        <xsl:apply-templates/>
        <br/>
        <xsl:text>&#x0a;</xsl:text>
    </xsl:template>
</xsl:stylesheet>
