<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">    
    
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="no" />
    <xsl:strip-space elements="tei:l tei:lg tei:w tei:space tei:rdg tei:choice tei:abbr tei:expan tei:hi tei:subst tei:orig tei:reg tei:add tei:del tei:sic tei:corr tei:cb tei:pb" />
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" />
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>