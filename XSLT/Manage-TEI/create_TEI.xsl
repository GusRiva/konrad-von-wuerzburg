<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">
<!--    Creates the TEI skeleton fot the synoptic view with one witness-->
    
    <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="no"/>
    
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="root">
        <?xml-model href="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"?><TEI xmlns="http://www.tei-c.org/ns/1.0">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title type="file-title">Synoptic edition of <title type="text-title">Herzmaere</title> </title>
                        <title type="title-abbreviation">Herz</title>
                        <author role="orig_author">Konrad von Würzburg</author>
                        <author role="editor" xml:id="GR" ref="https://orcid.org/0000-0002-2202-6354">Gustavo Fernandez Riva</author>
                        <sponsor>CONICET</sponsor>
                    </titleStmt>
                    <publicationStmt>
                        <authority>Gustavo Fernández Riva</authority>
                        <availability><licence target="https://creativecommons.org/licenses/by-nc/4.0/">Creative Commons 4.0 BY-NC (Attribution-NonCommercial)</licence></availability>
                    </publicationStmt>
                    <sourceDesc>
                        <listWit>
                            <witness xml:id="x">
                                <msDesc>
                                    <msIdentifier>
                                        <settlement>XXXX</settlement>
                                        <repository>XXXX</repository>
                                        <idno>XXXXX</idno>
                                        <msName>w</msName>
                                    </msIdentifier>
                                </msDesc>
                            </witness>
                        </listWit>
                    </sourceDesc>
                </fileDesc>
            </teiHeader>
            <text>
                <body>
                    <div>
                            <xsl:apply-templates select="rdg | pb|  cb"/>
                    </div>
                </body>
            </text>
        </TEI>
    </xsl:template>
    
    <xsl:template match="rdg">
        <l><app><rdg><xsl:apply-templates select="node()|@*"/></rdg></app></l>
    </xsl:template>
    
    
    
</xsl:stylesheet>