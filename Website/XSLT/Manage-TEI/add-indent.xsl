<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">
<!--    Vanilla multipurpose template -->
    
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="no"/>
    
    <xsl:param name="witness">#P</xsl:param>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    
    <!--    [ancestor::tei:l[ position() = 2] ]-->
    <xsl:template match="tei:rdg[@wit=$witness and not(@type='missing')]">
        <xsl:choose>
            <xsl:when test="./@n mod 2 = 0">
                <xsl:variable name="prev_rend"><xsl:value-of select="./@rend"/></xsl:variable>
                <rdg xmlns="http://www.tei-c.org/ns/1.0" rend="indent"><xsl:apply-templates select="@*|node()"></xsl:apply-templates></rdg>
            </xsl:when>
            <xsl:otherwise><rdg xmlns="http://www.tei-c.org/ns/1.0"><xsl:apply-templates select="@* | node()"/></rdg></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    
    
</xsl:stylesheet>