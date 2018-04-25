<?xml version="1.0" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">    
    
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="no" />
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>

    <xsl:template match="text()">
        <xsl:variable name="valor"><xsl:analyze-string select="." regex="\s+\n"><xsl:matching-substring/><xsl:non-matching-substring><xsl:value-of select="."/></xsl:non-matching-substring></xsl:analyze-string></xsl:variable>
        <xsl:value-of select="$valor"/>
    </xsl:template>

</xsl:stylesheet>