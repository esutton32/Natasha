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
        <br/> Placeholder (percentage in W+P): 
    </xsl:template>
    <xsl:template match="stanza">
        <p>
                <xsl:text>[</xsl:text>
                <xsl:apply-templates select="@speaker"/>
                <xsl:text>]</xsl:text><br/>   
            <xsl:for-each select="wp-ref">            
                    <xsl:apply-templates select="line" mode="ref"/>
            </xsl:for-each>
            <!--<xsl:for-each select="s-action">            
                <xsl:apply-templates select="line" mode="action"/>
            </xsl:for-each>-->
            <xsl:apply-templates select="line"/>
            <br/>
        </p>
    </xsl:template>
    <xsl:template match="line">
            <xsl:apply-templates/><br/>
    </xsl:template>
    <xsl:template match="line" mode="ref">     
            <span id="{@id}" class="ref">
            <xsl:apply-templates/><br/>
                <xsl:for-each select="s-action">            
                    <xsl:apply-templates select="line" mode="action"/>
                </xsl:for-each>
            </span>
    </xsl:template>
    <xsl:template match="line" mode="action">
       
            <span class="action">
                <xsl:apply-templates/></span><br/>
        
    </xsl:template>
</xsl:stylesheet>
