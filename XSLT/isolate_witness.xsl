<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">
    
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />
    
    <xsl:param name="manuscript">#P</xsl:param>
    
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
                <xsl:for-each select="key('pagebreak', @xml:id)">
                    <xsl:if test="./@edRef =$manuscript"><pb xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates select="@*|node()"/></pb></xsl:if>
                </xsl:for-each>
                <xsl:for-each select="key('columnbreak', @xml:id)">
                    <xsl:if test="./@edRef =$manuscript"><cb xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates select="@*|node()"/></cb></xsl:if>
                </xsl:for-each>
                <head xmlns="http://www.tei-c.org/ns/1.0"><app><rdg><xsl:apply-templates select="@*|node()"/></rdg></app></head>
            </xsl:for-each>
            <xsl:for-each select="//tei:l">
<!--                Sort the lines according to the attribute n , which is the order in the manuscript. -->
                <xsl:sort select="translate(./tei:app/tei:rdg[@wit=$manuscript]/@n, translate(./tei:app/tei:rdg[@wit=$manuscript]/@n,'0123456789',''), '')" data-type="number"/>
                <xsl:for-each select="key('pagebreak', @xml:id)">
                    <xsl:if test="./@edRef =$manuscript"><pb xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates select="@*|node()"/></pb></xsl:if>
                </xsl:for-each>
                <xsl:for-each select="key('columnbreak', @xml:id)">
                    <xsl:if test="./@edRef =$manuscript"><cb xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates select="@*|node()"/></cb></xsl:if>
                </xsl:for-each>
                <l xmlns="http://www.tei-c.org/ns/1.0" xml:space="preserve"><xsl:attribute name="xml:id"><xsl:value-of select="@xml:id"/></xsl:attribute><xsl:apply-templates select="@*|node()"/></l>
            </xsl:for-each>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:rdg">
        <xsl:choose>
            <xsl:when test="./@wit=$manuscript">
                <rdg xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates  select="@*|node()"/></rdg>
            </xsl:when>
            <xsl:otherwise></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:teiHeader"></xsl:template>
    
    <xsl:template match="tei:l"></xsl:template>
    
</xsl:stylesheet>