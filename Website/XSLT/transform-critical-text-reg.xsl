<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">
    
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="no" />
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    
    
    <xsl:template name="table-row">
        <td class="line_number">
            <span class="ms_line"><xsl:value-of select="./@n"/></span><span class="edit_line hidden"><xsl:value-of select="substring-after(./@xml:id, '_')"/></span><span class="corresp_line hidden">s<xsl:value-of select="substring-after(./@corresp, '_')"/></span>
        </td>
        <td class="verse">   
            <xsl:apply-templates select="tei:w | tei:space | tei:pc | tei:app | tei:rdg | tei:lem | text()"/>
        </td>
        <td class="folioetc">
            <xsl:apply-templates select="tei:note"></xsl:apply-templates>
        </td>
    </xsl:template>
    
    <xsl:template match="tei:div">
        <table class="text">
            <xsl:for-each select="tei:head">
                <thead><xsl:call-template name="table-row"/></thead>
            </xsl:for-each>
            <xsl:for-each select="tei:l">
                <xsl:choose>
                    <xsl:when test="not(descendant::text())">
                        <tr class="hidden toHide"><xsl:call-template name="table-row"/></tr>
                    </xsl:when>
                    <xsl:otherwise>
                        <tr><xsl:call-template name="table-row"/></tr>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </table>
    </xsl:template>
    
    
    <xsl:template match="tei:note">
        <xsl:choose>
            <xsl:when test="./@type='editorial'">
                <span class="glyphicon glyphicon-asterisk btn-edit_note"/>
            </xsl:when>
            <xsl:when test="./@type='missing'">
                <span class="glyphicon glyphicon-remove btn-missing"/><xsl:value-of select="./tei:seg[@type='wit']"/>   
            </xsl:when>
            <xsl:when test="./@type='addition'">
                <span class="glyphicon glyphicon-plus btn-extra"/>&#160;<xsl:value-of select="./@n"/>&#160;<xsl:value-of select="./tei:seg[@type='wit']"/>
            </xsl:when>
            <xsl:when test="./@type='transposed'">
                <span class="glyphicon glyphicon-refresh btn-transposed"></span><xsl:value-of select="."/>
            </xsl:when>
            <xsl:when test="./@type='alternative'">
                <xsl:if test="not(preceding-sibling::tei:note[@type='alternative'])"> 
                    <!--                    if is neccessary to avoid the same symbol many times-->
                    <span class="btn-alternative"><xsl:attribute name="title"><xsl:value-of select="./seg"/></xsl:attribute>≠</span>&#160;<xsl:value-of select="./tei:seg[@type='wit']"/><xsl:for-each select="./following-sibling::tei:note/tei:seg[@type='wit']">&#160;<xsl:value-of select="."/></xsl:for-each>
                </xsl:if> 
            </xsl:when>
            <xsl:when test="./@type='ending'"><span class="glyphicon glyphicon-stop btn-stop"/> <xsl:value-of select="."/></xsl:when>
        </xsl:choose>
    </xsl:template>
    <!--<xsl:template match="@xml:id"><xsl:attribute name="id"><xsl:value-of select="."/></xsl:attribute></xsl:template>-->
    
    <xsl:template match="tei:head"></xsl:template>
    
    <xsl:template match="tei:w"><xsl:apply-templates select="tei:reg"/></xsl:template>
    <xsl:template match="tei:reg">&#160;<xsl:value-of select="."/></xsl:template>
    
    <!--<xsl:template match="tei:space"><xsl:value-of select="' '"/></xsl:template>-->
    
    <xsl:template match="tei:pc">
        <span class="tei:pc"><xsl:apply-templates select="@*|node()" /></span>
    </xsl:template>
    
    <xsl:template match="tei:app"><xsl:apply-templates select="@*|node()"/></xsl:template>
    <xsl:template match="tei:rdg"></xsl:template>
 <!--   <xsl:template match="tei:lem">
        <span class="tei:lem"><xsl:apply-templates select="@*|node()"/></span>
    </xsl:template>-->
    
    <xsl:template match="tei:lem[not(parent::tei:app[@type='variation'])]"><span class="tei:lem italic"><xsl:variable name="variant"><xsl:for-each select="following-sibling::tei:rdg/tei:w"><xsl:value-of select="./tei:reg"/>&#160;</xsl:for-each></xsl:variable><xsl:attribute name="title"><xsl:value-of select="$variant"/></xsl:attribute><xsl:apply-templates select="@*|node()"/></span></xsl:template>
    <xsl:template match="tei:lem[parent::tei:app[@type='variation']]"><span class="tei:lem"><xsl:variable name="variant"><xsl:for-each select="following-sibling::tei:rdg/tei:w"><xsl:value-of select="./tei:reg"/>&#160;</xsl:for-each></xsl:variable><xsl:attribute name="title"><xsl:value-of select="$variant"/></xsl:attribute><xsl:apply-templates select="@*|node()"/></span></xsl:template>
    
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