<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">    
    
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="no" />
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@n | @xml:id | @n | @edRef | @wit | @corresp | @rend | @type | @cause |node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@xml:space">default</xsl:template>
    
</xsl:stylesheet>