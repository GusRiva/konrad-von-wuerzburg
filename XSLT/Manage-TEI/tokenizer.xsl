<?xml version="1.0" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">
    
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
<!--    ES NECESARIO LUEGO REEMPLAZAR LOS SÍMBOLES LT; Y GT; POR < >-->
    <xsl:template name="text-node"><xsl:value-of select='replace(., "\s", "lt;/origgt;lt;/wgt;lt;space/gt;lt;wgt;lt;origgt;")'/></xsl:template>
    
    <xsl:template match="tei:rdg[not(@type='missing')]">
        <rdg><xsl:apply-templates select="@*"/><w><orig><xsl:apply-templates select="node()"/></orig></w></rdg>
    </xsl:template>
    
    <xsl:template match="tei:rdg[not(@type='missing')]/node()">
        <xsl:choose>
            <xsl:when test="self::text()">
            <xsl:call-template name="text-node"/>
        </xsl:when>
            <xsl:otherwise>
                <xsl:copy><xsl:apply-templates select="@* | node()"/></xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>