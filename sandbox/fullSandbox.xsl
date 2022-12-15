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
                <link rel="stylesheet" type="text/css" href="../css/text_display.css"/>
                <link rel="icon" type="image/jpeg" href="img/IMG-1339.jpeg"/>
            </head>
            <body>
                <div class="topnav">
                    <h1>War and Peace in Adaptation</h1>
                    <hr/>
                    <ul class="navbar">
                        <li class="navlist">
                            <a href="../index.xhtml">HOME</a>
                        </li>
                        <li class="navlist">
                            <a href="../natasha_about.xhtml">ABOUT</a>
                        </li>
                        <li class="navlist">
                            <a href="../natasha_methodology.xhtml">METHODOLOGY</a>
                        </li>
                        <li class="navlist">
                            <a href="../natasha_text.xhtml">TEXT</a>
                        </li>
                        <li class="navlist">
                            <a href="../natasha_wiki.xhtml">WIKI</a>
                        </li>
                        <li class="navlist">
                            <a href="../natasha_analysis.xhtml">ANALYSIS</a>
                        </li>

                    </ul>
                </div>
                <div class="sidenav">
                    <img src="../img/IMG-1339.jpeg" height="160" width="160"/>
                    <p>Choose a song!</p>
                    <a href="prologue.xhtml">Prologue</a>
                    <a href="pierre.xhtml">Pierre</a>
                    <a href="moscow.xhtml">Moscow</a>
                    <a href="life_of_the_house.xhtml">The Private and Intimate Life of the House</a>
                    <a href="natasha_bolkonskys.xhtml">Natasha and Bolkonskys</a>
                    <a href="no_one_else.xhtml">No One Else</a>
                    <a href="opera.xhtml">The Opera</a>
                    <a href="natasha_anatole.xhtml">Natasha and Anatole</a>
                    <a href="duel.xhtml">The Duel</a>
                    <a href="dust_ashes.xhtml">Dust and Ashes</a>
                    <a href="sunday_morning.xhtml">Sunday Morning</a>
                    <a href="charming.xhtml">Charming</a>
                    <a href="ball.xhtml">The Ball</a>
                    <a href="letters.xhtml">Letters</a>
                    <a href="sonya_natasha.xhtml">Sonya and Natasha</a>
                    <a href="sonya_alone.xhtml">Sonya Alone</a>
                    <a href="preparations.xhtml">Preparations</a>
                    <a href="balaga.xhtml">Balaga</a>
                    <a href="abduction.xhtml">Abduction</a>
                    <a href="my_house.xhtml">In My House</a>
                    <a href="call_pierre.xhtml">A Call to Pierre</a>
                    <a href="find_anatole.xhtml">Find Anatole</a>
                    <a href="pierre_anatole.xhtml">Pierre and Anatole</a>
                    <a href="very_ill.xhtml">Natasha Very Ill</a>
                    <a href="pierre_andrey.xhtml">Pierre and Andrey</a>
                    <a href="pierre_natasha.xhtml">Pierre and Natasha</a>
                    <a href="great_comet.xhtml">The Great Comet of 1812</a>
                </div>
                <div class="main">
                    <h2>Texts</h2>
                    <p>There are no references to <em>War and Peace</em> in this song. The prologue introduces all of the characters, as well as the events leading up to Book Eight.</p>
                    <div class="flex-container">
                        <div class="flex-child">
                            <xsl:apply-templates/>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="metadata">
        <h3 class="flex-header">
            <q>
                <xsl:apply-templates select="name"/>
            </q>
        </h3>
        <xsl:apply-templates select="characters"/>
    </xsl:template>
    <xsl:template match="metadata/characters">
        <p class="flex-para">Featured Characters: <xsl:apply-templates
                select="c => string-join(', ')"/>
        </p>
    </xsl:template>
    <xsl:template match="stanza">
        <p class="flex-para">
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
    <!--Adding class that matches refs in W&P to refs in lyrics-->
    <xsl:template match="wp-ref">
        <span class="{@id}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <!--Adding class that differentiates descriptions of self and others-->
    <xsl:template match="s-action">
        <xsl:choose>
            <xsl:when test="@kind eq 'self'">
                <span class="{@kind}">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@kind eq 'other'">
                <span class="{@kind}">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="line">
        <xsl:apply-templates/>
        <br/>
        <xsl:text>&#x0a;</xsl:text>
    </xsl:template>
</xsl:stylesheet>
