<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">
    
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />

    <xsl:template match="@*|node()">
        <xsl:copy >
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:key name="pagebreak" match="tei:pb" use="following::tei:rdg[1]/@n" />
    <xsl:key name="columnbreak" match="tei:cb" use="following::tei:rdg[1]/@n"/>
    
    
    <xsl:template name="table-row">
            <td class="line_number">
                <span class="line"><xsl:value-of select="./@n"/></span><span class="edit_line hidden"><xsl:value-of select="substring(ancestor::tei:l[1]/@xml:id,3)"/></span><span class="corresp_line hidden">s<xsl:value-of select="substring(ancestor::tei:l[1]/@xml:id,3)"/></span>
            </td>
            <td class="verse">    
                <xsl:apply-templates select="@*|node()"/>
            </td>
            <td class="folioetc">
<!--                This first choose is for the cb-->
                <xsl:choose>
                    <xsl:when test="preceding::tei:cb">
                        <xsl:for-each select="key('columnbreak', @n)">
                            <xsl:value-of select="substring(./@facs, 4)"/>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:for-each select="key('pagebreak', @n)">
                            <xsl:value-of select="substring(./@facs, 4)"/>
                        </xsl:for-each>
                    </xsl:otherwise>
                </xsl:choose>
<!--                This inserts other options in the third column-->
                <xsl:choose>
                    <xsl:when test="./@type='transposed'">
                        <span class="glyphicon glyphicon-arrow-left btn-transposed" title="Verse transposed in at least one witness. View apparatus for more details"></span>
                    </xsl:when>
                </xsl:choose>
            </td>
    </xsl:template>

    <xsl:template match="tei:div">
        <table class="text">
            <xsl:for-each select="tei:head/tei:app/tei:rdg">
                <thead><xsl:call-template name="table-row"/></thead>
            </xsl:for-each>
            <xsl:for-each select="tei:l/tei:app/tei:rdg">
                <xsl:choose>
                    <xsl:when test="./@type='missing'">
                        <tr class="hidden toHide"><xsl:call-template name="table-row"/></tr>
                    </xsl:when>
                    <xsl:otherwise>
                        <tr><xsl:call-template name="table-row"/></tr>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </table>
    </xsl:template>
    
    <xsl:template match="@xml:id"><xsl:attribute name="id"><xsl:value-of select="."/></xsl:attribute></xsl:template>
    

    <xsl:template match="tei:head"></xsl:template>
    
    <xsl:template match="tei:hi[contains(@rend,'decoration')]">
        <span><xsl:attribute name="xml:space">preserve</xsl:attribute><xsl:attribute name="class">decoration <xsl:value-of select="substring-after(./@rend,':')"/></xsl:attribute>
            <span class="inner-span-decoration"><xsl:apply-templates select="node()"/></span></span>
    </xsl:template>
    
    <xsl:template match="tei:hi[contains(@rend,'initial')]">
        <span>
            <xsl:variable name="color"><xsl:value-of select="substring-after(./@rend, 'color:')"></xsl:value-of></xsl:variable>
            <xsl:attribute name="class">initial <xsl:value-of select="$color"/></xsl:attribute>
            <xsl:apply-templates select="@*|node()"/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:hi[not(contains(@rend,'initial')) and not(contains(@rend, 'decoration')) and contains(@rend, 'color:red')]">
        <span class="red"><xsl:apply-templates select="@*|node()"></xsl:apply-templates></span>
    </xsl:template>
    
    
    <xsl:template match="tei:choice"><span class="choice"><xsl:attribute name="xml:space">preserve</xsl:attribute><xsl:apply-templates select="@*|node()"/></span></xsl:template>
    <xsl:template match="tei:abbr"><span class="abbr"><xsl:apply-templates select="@*|node()" /></span></xsl:template>
    <xsl:template match="tei:expan"><span class="expansion hidden"><xsl:apply-templates select="@*|node()" /></span></xsl:template> 
    <xsl:template match="tei:am"><span class="am"><xsl:apply-templates select="@*|node()"/></span></xsl:template>
    <xsl:template match="tei:ex"><span class="ex"><xsl:apply-templates select="@*|node()"/></span></xsl:template>
    
    <xsl:template match="tei:lb">
        <br><xsl:apply-templates  select="@*|node()"/></br>
    </xsl:template>
    
    <xsl:template match="tei:subst"><xsl:apply-templates select="@*|node()"/></xsl:template>
    
    <xsl:template match="tei:del">
        <span><xsl:attribute name="class">del <xsl:value-of select="./@rend"></xsl:value-of></xsl:attribute><xsl:attribute name="title">deleted</xsl:attribute><xsl:apply-templates  select="node()"/></span>
    </xsl:template>
    
    <xsl:template match="tei:add">
         <span><xsl:attribute name="title">add <xsl:value-of select="./@place"/></xsl:attribute><span class="bracket">[</span><xsl:apply-templates select="node()"/><span class="bracket">]</span></span>
    </xsl:template>
    
    <xsl:template match="tei:unclear">
        <span><xsl:attribute name="title">unclear</xsl:attribute><span class="bracket">[</span><xsl:apply-templates select="node()"/><span class="bracket">]</span></span>        
    </xsl:template>
    
    <xsl:template match="tei:sic">
        <span class="paleog"><xsl:apply-templates select="@*|node()"/></span>
    </xsl:template>
    
    <xsl:template match="tei:corr">
        <span class="edited hidden"><xsl:apply-templates select="@*|node()"/></span>
    </xsl:template>
    
    <xsl:template match="tei:pc">
        <span class="punctuation"><xsl:apply-templates select="@*|node()" /></span>
    </xsl:template>
    
    <xsl:template match="tei:supplied">
        <span class="expan oculto"><xsl:apply-templates select="@*|node()" /></span>
    </xsl:template>
    
    <xsl:template match="tei:note[@place = 'margin']">
        <span class="marginalia" title="marginalia">[<xsl:apply-templates select="node()"/>]</span>
    </xsl:template>
    
    <xsl:template match="tei:metamark[@function='cue_initial']">
        <span class="cue_initial paleog">[<xsl:value-of select="."/>]</span>
    </xsl:template>
    
    <xsl:template match="tei:space">
        <span class="empty"><xsl:attribute name="title"><xsl:value-of select="./desc"></xsl:value-of></xsl:attribute>[   ]</span>
    </xsl:template>
    
<!--    Borra las etiquetas-->
    <xsl:template match="tei:TEI">
        <xsl:apply-templates select="@*|node()"/>
    </xsl:template>
    
    <xsl:template match="tei:body">
        <xsl:apply-templates select="@*|node()"/>
    </xsl:template>
    
    <xsl:template match="tei:text">
        <xsl:apply-templates select="@*|node()"/>
    </xsl:template>
    
    <xsl:template match="tei:teiHeader"></xsl:template>
    
 
</xsl:stylesheet>