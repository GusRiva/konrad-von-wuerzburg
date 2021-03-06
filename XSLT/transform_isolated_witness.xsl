﻿<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">
    
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="no" />
    
    <xsl:template match="@*|node()">
        <xsl:copy >
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:key name="pagebreak" match="tei:pb" use="following::tei:rdg[1]/@n" />
    <xsl:key name="columnbreak" match="tei:cb" use="following::tei:rdg[1]/@n"/>
    
    
    <xsl:template name="table-row">
        <td class="line_number">
            <span class="ms_line"><xsl:value-of select="./@n"/></span><span class="edit_line hidden"><xsl:value-of select="substring(ancestor::tei:l[1]/@xml:id,3)"/></span><span class="corresp_line hidden">s<xsl:value-of select="substring-after(ancestor::tei:l[1]/@corresp, '_')"/></span>
        </td>
        <td class="verse">    
            <xsl:apply-templates select="node()"/>
        </td>
        <td class="folioetc">
            <!--                This first when is for the texts with columns, the second for those without-->
            <xsl:choose>
                <xsl:when test="preceding::tei:cb">
                    <a target="_blank">
                        <xsl:attribute name="href">
                            <xsl:for-each select="key('columnbreak', @n)">
                                <xsl:value-of select="./@ed"/>
                            </xsl:for-each>
                        </xsl:attribute>
                        <xsl:for-each select="key('columnbreak', @n)">
                            <xsl:value-of select="substring(./@facs, 4)"/>
                        </xsl:for-each>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <a target="_blank">
                        <xsl:attribute name="href">
                            <xsl:for-each select="key('pagebreak', @n)">
                                <xsl:value-of select="./@ed"/>
                            </xsl:for-each>
                        </xsl:attribute>
                        <xsl:for-each select="key('pagebreak', @n)">
                            <xsl:value-of select="substring(./@facs, 4)"/>
                        </xsl:for-each>
                    </a>
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
    
    <xsl:template match="tei:w"><span class="tei_w"><xsl:apply-templates select="tei:orig"/></span></xsl:template>
    <xsl:template match="tei:c[@type='space']">&#xA0;</xsl:template>
    
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
    
    
    <xsl:template match="tei:choice"><span class="tei_choice"><xsl:apply-templates select="@*|node()"/></span></xsl:template>
    <xsl:template match="tei:abbr"><span class="tei_abbr"><xsl:apply-templates select="@*|node()" /></span></xsl:template>
    <xsl:template match="tei:expan"><span class="tei_expan hidden"><xsl:apply-templates select="@*|node()" /></span></xsl:template> 
    <xsl:template match="tei:am"><span class="tei_am"><xsl:apply-templates select="@*|node()"/></span></xsl:template>
    <xsl:template match="tei:ex"><span class="tei_ex"><xsl:apply-templates select="@*|node()"/></span></xsl:template>
    
    <xsl:template match="tei:lb"><br/></xsl:template>
    
    <xsl:template match="tei:subst"><xsl:apply-templates select="@*|node()"/></xsl:template>
    
    <xsl:template match="tei:add[not(@place='inline')]">
        <span class="tei_add">[</span><xsl:apply-templates select="node()"/><span class="tei_add">]</span>
    </xsl:template>
    
    <xsl:template match="tei:add[@place='inline']">
        <span class="tei_add_inline"><xsl:apply-templates select="node()"/></span>
    </xsl:template>
    
    <xsl:template match="tei:corr">
        <span class="tei_corr"><xsl:apply-templates select="@*|node()"/></span>
    </xsl:template>
    
    <xsl:template match="tei:del">
        <span><xsl:attribute name="class">tei_del <xsl:value-of select="./@rend"></xsl:value-of></xsl:attribute><xsl:attribute name="title">deleted</xsl:attribute><xsl:apply-templates  select="node()"/></span>
    </xsl:template>
    
    <xsl:template match="tei:metamark[@function='cue_initial']">
        <span class="cue_initial">[</span><xsl:value-of select="."/><span class="cue_initial">]</span>
    </xsl:template>
    
    <xsl:template match="tei:metamark[not(@function='cue_initial')]">
        <span class="tei_metamark"><xsl:apply-templates select="@* | node()"/></span><span class="tei_metamark_space">&#xA0;</span>
    </xsl:template>
    
    <xsl:template match="tei:note[@place = 'margin']">
        <span class="marginalia" title="marginalia">[<xsl:apply-templates select="node()"/>]</span>
    </xsl:template>
    
    <xsl:template match="tei:pc">
        <span class="tei_pc"><xsl:apply-templates select="@*|node()" /></span>
    </xsl:template>
    
    <xsl:template match="tei:sic">
        <span class="tei_sic"><xsl:apply-templates select="@*|node()"/></span>
    </xsl:template>
    
    <xsl:template match="tei:supplied">
        <span class="tei_supplied">(<xsl:apply-templates select="@*|node()" />)</span>
    </xsl:template>
    
    <xsl:template match="tei:unclear">
        <span class="tei_unclear">/*</span><xsl:apply-templates select="node()"/><span class="tei_unclear">*\</span>        
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