<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">    
    
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="no" />
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:key name="pagebreak" match="tei:pb" use="following::tei:l[1]/@xml:id" />
    <xsl:key name="columnbreak" match="tei:cb" use="following::tei:l[1]/@xml:id"/>
    
    <xsl:template match="//tei:div">
        <div xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:for-each select="//tei:head">
                <!--<xsl:for-each select="tei:pb">
                    <pb xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates select="@*|node()"/></pb>
                </xsl:for-each>
                <xsl:for-each select="tei:cb">
                    <cb xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates select="@*|node()"/></cb>
                </xsl:for-each>-->
                <head xmlns="http://www.tei-c.org/ns/1.0"><app><rdg><xsl:apply-templates select="@*|node()"/></rdg></app></head>
            </xsl:for-each>
            <xsl:for-each select="//tei:l">
<!--                Sort the lines according to the attribute n , which is the order in the manuscript. -->
                <xsl:sort select="translate(./tei:app/tei:rdg/@n, translate(./tei:app/tei:rdg/@n,'0123456789',''), '')" data-type="number"/>
                <xsl:for-each select="key('pagebreak', @xml:id)">
                    <pb xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates select="@*|node()"/></pb>
                </xsl:for-each>
                <xsl:for-each select="key('columnbreak', @xml:id)">
                    <cb xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates select="@*|node()"/></cb>
                </xsl:for-each>
                <l xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates select="@*|node()"/></l>
            </xsl:for-each>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:rdg">
        <rdg xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates  select="@n | @wit | @xml:id | @type  | @rend |node()"/></rdg>
    </xsl:template>
    
    <xsl:template match="tei:pb"></xsl:template>
    <xsl:template match="tei:cb"></xsl:template>
    
    
    
    
</xsl:stylesheet>