<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">
<!--    Vanilla multipurpose template -->
    
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="no"/>
    
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:hi[ancestor::tei:rdg[@wit='#I']][not(@rend)]">
        <hi><xsl:attribute name="rend">decoration color:red</xsl:attribute><xsl:apply-templates select="@*|node()"/></hi>
    </xsl:template>
    
    
    
</xsl:stylesheet>