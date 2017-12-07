<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:php="http://php.net/xsl">
    
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    
    
    <xsl:template name="table-row">
        <td class="line_number"><span class="line"><xsl:value-of select="./@n"/></span><span class="corresp_line hidden">s<xsl:value-of select="substring-after(./@xml:id, '_')"/></span>
        </td>
        <td class="verse">    
            <xsl:apply-templates select="tei:app | tei:note"/>
        </td>
    </xsl:template>
    
<!--    This recursive template searchs for the last word in a string, to be able to write "post" when word were added at the end of a verse-->
    <xsl:template name="post">
        <xsl:param name="preceding-word"/>
        <xsl:variable name="new_preceding-word"><xsl:copy-of select="php:function('strtok', ' ')"/></xsl:variable>
        <xsl:choose>
            <xsl:when test="$new_preceding-word != 'false'">
                <xsl:call-template name="post"><xsl:with-param name="preceding-word" select="$new_preceding-word"/></xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <span class="ex">post</span>&#160;<xsl:value-of select="$preceding-word"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:div">
        <table class="text">
            <xsl:for-each select="tei:head">
                <thead><xsl:call-template name="table-row"/></thead>
            </xsl:for-each>
            <xsl:for-each select="tei:l">
                <xsl:choose>
                    <xsl:when test="./tei:app">
                        <tr><xsl:call-template name="table-row"/></tr>
                    </xsl:when>
                    <xsl:when test="./tei:note">
                        <tr><xsl:call-template name="table-row"/></tr>
                    </xsl:when>
                    <xsl:otherwise></xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </table>
    </xsl:template>
    
    
    <xsl:template match="tei:note">
        <span class="note-in-app">
            <xsl:choose>
                <xsl:when test="@type = 'missing'">
                    <span class="ex">h. v. om.</span>&#160;<xsl:apply-templates  select="node()"/><br/>
                </xsl:when>
                <xsl:when test="@type = 'transposed'">
                    <span class="ex">transp.</span>&#160;<xsl:apply-templates  select="node()"/><br/>
                </xsl:when>
                <xsl:when test="@type = 'alternative'">
                    <xsl:if test="./tei:seg[@type='text' or @type='comment']">
                        <span class="ex"><xsl:value-of select="./tei:seg[@type='wit']"/>:</span>&#160;<xsl:value-of select="./tei:seg[@type='text']"/>; <xsl:value-of select="./tei:seg[@type='comment']"></xsl:value-of>
                    </xsl:if>
                </xsl:when>
                <xsl:when test="@type = 'addition'">
                    <span class="ex"><xsl:value-of select="./tei:seg[@type='wit']"/> add. :</span>&#160;<xsl:value-of select="./tei:seg[@type = 'text']"/><br/>
                    <xsl:value-of select="./tei:seg[@type = 'comment']"/>
                </xsl:when>
                <xsl:when test="@type = 'ending'">
                    <span class="ex">exp. <xsl:value-of select="."/></span>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates  select="node()"/><br/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    
    <xsl:template match="attribute::xml:lang">
        <xsl:attribute name="lang"><xsl:value-of select="."/></xsl:attribute>
    </xsl:template>
    
    <xsl:template match="tei:app">
        <xsl:for-each select="descendant::tei:lem">
            <xsl:choose>
            <!--  If the entire verse is missing (that is, it has a witness atribute and no rdg), do not write in the apparatus, just call the function for the descendants             -->
                <xsl:when test="./@wit and not(parent::tei:app/tei:rdg)">
                    <span class="ex">lemma h.v.: <xsl:value-of select="translate(./@wit, '#', '')"/></span><br/>    
                </xsl:when>
                <xsl:otherwise>
                <!--  Write in the apparatus                  -->
                    <span class="lemma-ref">
                        <xsl:choose>
                            <xsl:when test="./node()">
                                <!--  when there is not omission                  -->
                                <xsl:for-each select="./node()">
                                    <xsl:if test="self::text()">
                                        <xsl:value-of select="."/>
                                    </xsl:if>
                                    <xsl:if test="self::tei:app">
                                        <xsl:value-of select="./tei:lem/text()"/>
                                    </xsl:if>&#160;
                                </xsl:for-each>
                                <!--       When the lem has a wit attribute include this info             -->
                                <xsl:if test="./@wit">
                                    <span class="ex"><xsl:value-of select="translate(./@wit, '#', '')"/></span>&#160;    
                                </xsl:if>
                            </xsl:when>
                            <!--     Empty Lemma , so get the next or previous word          -->
                            <xsl:otherwise>
                                <!--Variable that gets the next word -->
                                <xsl:variable name="following-string"><xsl:copy-of select="./../following-sibling::text()"/></xsl:variable>
                                <xsl:variable name="following-word"><xsl:copy-of select="php:function('strtok', $following-string, ' ')"/></xsl:variable>
                                <xsl:choose>
                                    <xsl:when test="$following-word != 'false'">
                                        <span class="ex">ante</span>&#160;<xsl:value-of select="$following-word"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <!-- preceding word                           -->
                                        <xsl:variable name="preceding-string"><xsl:copy-of select="./../preceding-sibling::text()"/></xsl:variable>
                                        <xsl:variable name="preceding-word"><xsl:copy-of select="php:function('strtok', $preceding-string, ' ')"/></xsl:variable>
                                        <xsl:call-template name="post"><xsl:with-param name="preceding-word" select="$preceding-word"/></xsl:call-template>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>]</span>&#160; 
                    <xsl:for-each select="following-sibling::tei:rdg">
                        <xsl:choose>
                            <xsl:when test="not(./text())">
                                <span class="ex">om. &#160;<xsl:value-of select="translate(./@wit, '#', '')"/>,</span>&#160;
                            </xsl:when>
                            <xsl:otherwise><span><xsl:value-of select="./text()"/>&#160;</span><span class="ex"><xsl:value-of select="translate(./@wit, '#', '')"/>,</span>&#160;</xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                    <br/>
                </xsl:otherwise>
            </xsl:choose>
            
        </xsl:for-each>
    </xsl:template>   
    
    
    <xsl:template match="@xml:id"><xsl:attribute name="id"><xsl:value-of select="."/></xsl:attribute></xsl:template>
    
    
    <xsl:template match="tei:head"></xsl:template>
    
    <xsl:template match="tei:pc"></xsl:template>
    <xsl:template match="tei:l"></xsl:template>
    
    
    
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