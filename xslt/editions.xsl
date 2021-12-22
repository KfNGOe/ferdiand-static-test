<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select="normalize-space(string-join(.//tei:title[@type='sub']//text()))"/>
        </xsl:variable>
        <xsl:variable name="xml_path">
            <xsl:value-of select="concat('data/band_01/', tokenize(base-uri(), '/')[last()])"/>
        </xsl:variable>
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <xsl:call-template name="html_head">
                <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
            </xsl:call-template>
            
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="container-fluid">                        
                        <div class="card">
                            <div class="card-header" style="text-align:center">
                                <h1><xsl:value-of select="$doc_title"/></h1>
                                <!--<h3>
                                    <a>
                                        <xsl:attribute name="href"><xsl:value-of select="$xml_path"/></xsl:attribute>
                                        <i class="fas fa-file-download"></i>
                                    </a>
                                </h3>-->
                            </div>
                            <div class="card-body">
                                <div class="card-header">
                                    <h3>Briefkopf</h3>
                                </div>
                                <div class="card-body" style="font-style:italic">
                                    <xsl:apply-templates select="//tei:div[@type='letter_header']"/>
                                </div>
                                <div class="card-header">
                                    <h3>Regest <small>de</small></h3>
                                </div>
                                <div class="card-body" style="font-style:italic">
                                    <xsl:apply-templates select="//tei:p[@rend='Regest Deutsch']"/>
                                </div>
                                <div class="card-header">
                                    <h3>Regest <small>en</small></h3>
                                </div>
                                <div class="card-body" style="font-style:italic">
                                    <xsl:apply-templates select="//tei:p[@rend='Regest Englisch']"/>
                                </div>
                                <div class="card-header">
                                    <h3>Archiv- und Druckvermerk</h3>
                                </div>
                                <div class="card-body" style="font-style:italic">
                                    <xsl:for-each select=".//tei:p[@rend='Archiv- und Druckvermerk']">
                                        <xsl:apply-templates select="."/>
                                    </xsl:for-each>
                                </div>
                                <xsl:apply-templates select=".//tei:div[@type='transcription']"/>
                                <div class="card-header">
                                    <h3>Kommentare</h3>
                                    <xsl:for-each select="//tei:p[@rend='Kommentar']">
                                        <xsl:apply-templates select="."></xsl:apply-templates>
                                    </xsl:for-each>
                                </div>
                            </div>
                        </div>                       
                    </div>
                    <xsl:call-template name="html_footer"/>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="tei:p">
        <p id="{generate-id()}"><xsl:apply-templates/></p>
    </xsl:template>
    <xsl:template match="tei:div">
        <div id="{generate-id()}"><xsl:apply-templates/></div>
    </xsl:template>
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    <xsl:template match="tei:unclear">
        <abbr title="unclear"><xsl:apply-templates/></abbr>
    </xsl:template>
    <xsl:template match="tei:del">
        <del><xsl:apply-templates/></del>
    </xsl:template>
    <xsl:template match="tei:hi[@rend='italic']">
        <i><xsl:apply-templates/></i>
    </xsl:template>
    <xsl:template match="tei:hi[@rend='superscript']">
        <sup><xsl:apply-templates/></sup>
    </xsl:template>     
    <xsl:template match="tei:persName[@key]">
        <abbr>
            <xsl:attribute name="title"><xsl:value-of select="@key"/></xsl:attribute>
            <xsl:apply-templates/>
        </abbr>
    </xsl:template>
    <xsl:template match="tei:placeName[@key]">
        <abbr>
            <xsl:attribute name="title"><xsl:value-of select="@key"/></xsl:attribute>
            <xsl:apply-templates/>
        </abbr>
    </xsl:template>
    <xsl:template match="tei:table">
        <xsl:element name="table">
            <xsl:attribute name="class">
                <xsl:text>table table-bordered table-striped table-condensed table-hover</xsl:text>
            </xsl:attribute>
            <xsl:element name="tbody">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:row">
        <xsl:element name="tr">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:cell">
        <xsl:element name="td">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>