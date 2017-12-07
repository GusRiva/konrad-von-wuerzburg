<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">
    
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes" />
    
    <xsl:param name="source"></xsl:param>
    
    <xsl:template name="wit_desc">
        <xsl:for-each select="tei:witness">
            <li>
                <xsl:value-of select="./@xml:id"/> = 
                <xsl:value-of select="./tei:msDesc/tei:msIdentifier/tei:settlement"/>,
                <xsl:value-of select="./tei:msDesc/tei:msIdentifier/tei:repository"/>,
                <xsl:value-of select="./tei:msDesc/tei:msIdentifier/tei:idno"/>,
            </li>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="list_witness">
        <xsl:choose>
            <xsl:when test="./@xml:id">
                <ul>
                    <li><span class="lang" lang="en">Witness group:</span><span class="lang" lang="es">Grupo de testimonios:</span><span class="lang" lang="de">Zeugnisgruppe:</span><xsl:value-of select="./@xml:id"/>
                        <ul>
                            <xsl:call-template name="wit_desc"/>
                        </ul>
                    </li>
                </ul>
            </xsl:when>
            <xsl:otherwise>
                <ul>
                    <xsl:call-template name="wit_desc"/>
                </ul>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:for-each select="tei:listWit">
            <xsl:call-template name="list_witness"/>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="tei:sourceDesc">
      <xsl:for-each select="tei:listWit">
          <xsl:call-template name="list_witness"/>
      </xsl:for-each>
        
    </xsl:template>
    
    <xsl:template match="tei:body"></xsl:template>
    <xsl:template match="tei:titleStmt"></xsl:template>
    <xsl:template match="tei:publicationStmt"></xsl:template>
    <xsl:template match="tei:profileDesc">
        <xsl:for-each select="tei:creation">
            <span class="lang" lang="en">Guide manuscript</span><span class="lang" lang="es">Manuscrito guía</span><span class="lang" lang="de">Leithandschrift</span>: <xsl:value-of select="./tei:ref"/>
        </xsl:for-each>
    </xsl:template>
    
    
    
  
    
</xsl:stylesheet>