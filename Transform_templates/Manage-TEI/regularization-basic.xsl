<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">
    
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:w">
        <w><xsl:apply-templates select="@*|node()"/><reg><xsl:choose>
            <xsl:when test="./tei:orig/tei:choice">
                <xsl:value-of select="./tei:orig/tei:choice/tei:expan"/>
            </xsl:when>
            <xsl:when test="./tei:orig/tei:subst">
                <xsl:value-of select="./tei:orig/tei:subst/tei:add"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="./tei:orig"/>
            </xsl:otherwise>
        </xsl:choose></reg></w>
    </xsl:template>
</xsl:stylesheet>