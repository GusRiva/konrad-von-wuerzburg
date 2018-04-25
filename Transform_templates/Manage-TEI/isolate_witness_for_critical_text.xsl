<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">    
    
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="no" />
    
    <xsl:param name="manuscript">#M</xsl:param>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:pb"></xsl:template>
    
    <xsl:template match="tei:cb"></xsl:template>
    
    <xsl:template match="tei:l">
        <l xmlns="http://www.tei-c.org/ns/1.0"><xsl:attribute name="n"><xsl:value-of select="./tei:app/tei:rdg[@wit=$manuscript]/@n"/></xsl:attribute><xsl:apply-templates select="@* | node()"></xsl:apply-templates></l>
    </xsl:template>
    
    <xsl:template match="tei:app"><xsl:apply-templates select="node()"/></xsl:template>
    
    <xsl:template match="tei:rdg">
        <xsl:choose>
            <xsl:when test="./@wit= $manuscript"><xsl:apply-templates select="node()"/></xsl:when>
            <xsl:otherwise></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:choice"><xsl:apply-templates select="node()"/></xsl:template>
    <xsl:template match="tei:abbr"></xsl:template>
    <xsl:template match="tei:expan"><xsl:apply-templates select="node()"/></xsl:template>
    <xsl:template match="tei:ex"><xsl:apply-templates select="node()"/></xsl:template>
    <xsl:template match="tei:hi"><xsl:apply-templates select="node()"/></xsl:template>
    
    <xsl:template match="tei:lg"><xsl:apply-templates select="node()"></xsl:apply-templates></xsl:template>
    
   <xsl:template match="tei:note"></xsl:template>
    
    
    
</xsl:stylesheet>