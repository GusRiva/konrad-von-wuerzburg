<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">
<!--    This script adds verse numbers to the rdg in a synoptic transcription. 
        It puts correlative numbers and adds letters to the missing verses. It does not consider the transpositions.-->
    
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="no"/>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    
    
    <xsl:template match="tei:rdg[not(@type='missing')]">
        <xsl:variable name="witness"><xsl:value-of select="./@wit"/></xsl:variable>
        <rdg xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="n">
                <xsl:number count="tei:l/tei:app/tei:rdg[@wit=$witness and not(@type='missing')]" level="any"></xsl:number>
            </xsl:attribute>
            <xsl:apply-templates select="@type | @xml:space | @wit | @xml:id | node()" />
        </rdg>    
    </xsl:template>
    
    <xsl:template match="tei:rdg[@type='missing']">
        <xsl:variable name="witness"><xsl:value-of select="@wit"/></xsl:variable>
        <rdg xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="n">
            <xsl:value-of select="preceding::tei:rdg[@wit=$witness and not(@type='missing')][1]/@n"/>
            <xsl:number count="tei:rdg[@wit=$witness and @type='missing']" from="tei:rdg[@wit=$witness and not(@type='missing')]" format="a" level="any"/>
            </xsl:attribute>
            <xsl:apply-templates select="@type | @xml:space | @wit | @xml:id | node()" />
        </rdg>
    </xsl:template>
    
    
</xsl:stylesheet>