<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">    
    
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="no" />
    
    <xsl:param name="manuscript">#D</xsl:param>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:pb">
        <xsl:choose>
            <xsl:when test="./@edRef = $manuscript"><pb xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates select="@* | node()"/></pb></xsl:when>
            <xsl:otherwise></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:cb">
        <xsl:choose>
            <xsl:when test="./@edRef = $manuscript"><cb xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates select="@* | node()"/></cb></xsl:when>
            <xsl:otherwise></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:l">
        <l xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates select="@* | node()"></xsl:apply-templates></l>
    </xsl:template>
    
    <xsl:template match="tei:rdg">
        <xsl:choose>
            <xsl:when test="./@wit= $manuscript"><rdg xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates select="@n | @xml:id | @wit | @type | @rend | node()"/></rdg></xsl:when>
            <xsl:otherwise></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    
    <xsl:template match="tei:lg"><xsl:apply-templates select="node()"></xsl:apply-templates></xsl:template>
    
    <xsl:template match="@xml:space">preserve</xsl:template>
    
    
    
    
    
</xsl:stylesheet>