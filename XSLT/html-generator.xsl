<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:html="http://www.w3.org/1999/xhtml">
    <xsl:output method="html" omit-xml-declaration="yes" encoding="UTF-8" indent="yes"/>
    <xsl:variable name="title">
        <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title/tei:title[@type='text-title']"/>
    </xsl:variable>
    
    <xsl:variable name="title_abbr">
        <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='title-abbreviation']"/>
    </xsl:variable>
    
    <xsl:variable name="witnesses">
        <xsl:for-each select="//tei:witness">
            <option><xsl:attribute name="value"><xsl:value-of select="//tei:title[@type='title-abbreviation']"/>_<xsl:value-of select="./@xml:id"/></xsl:attribute><xsl:value-of select="./@xml:id"/> - <xsl:value-of select="./tei:msDesc/tei:msIdentifier/tei:settlement"/></option>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:variable name="guide_ms">
        <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:profileDesc/tei:creation/tei:ref"/>
    </xsl:variable>
    
    <xsl:template match="/tei:TEI">
        <html>
            <head> 
                <title><xsl:value-of select="$title"/></title> 
                <meta charset="UTF-8"/> 
                <link rel="stylesheet" type="text/css" href="https://code.jquery.com/ui/1.9.1/themes/base/jquery-ui.css"/> 
                <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.11.3.min.js"/> 
                <script src="https://code.jquery.com/jquery-1.8.2.js"/> 
                <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.9.1/jquery-ui.min.js"/> 
                <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.js"/> 
                <xsl:comment>Bootstrap</xsl:comment> 
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/> 
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"/> 
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"/> 
                <meta name="viewport" content="width=device-width, initial-scale=1"/> 
                <xsl:comment>My templates</xsl:comment> 
                <link rel="stylesheet" type="text/css" href="CSS/dropdown-submenu-fix.css"/> 
                <link rel="stylesheet" type="text/css" href="CSS/edition.css"/> 
                <script src="JS/edition.js" type="text/javascript"/> 
            </head>
            <body>
                <nav class="navbar navbar-inverse navbar-fixed-top" id="title">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-2">
                                <div class="dropdown">
                                    <button class="btn btn-primary dropdown-toggle title-options" type="button" data-toggle="dropdown">
                                        <span id="options-span"></span>
                                    </button>
                                    <ul class="dropdown-menu" role="menu">
                                        <li class="dropdown-submenu">
                                            <a tabindex="-1">
                                                <span lang="en" class="lang hidden">Number of columns</span>
                                                <span lang="de" class="lang hidden">Spaltenzahl</span>
                                                <span lang="es" class="lang hidden">Número de columnas</span>
                                            </a>
                                            <form class="dropdown-menu">
                                                <div class="radio">
                                                    <label><input type="radio" name="number-cols" value="2"/>2</label>
                                                </div>
                                                <div class="radio">
                                                    <label><input type="radio" name="number-cols" value="3"/>3</label>
                                                </div>
                                                <div class="radio">
                                                    <label><input type="radio" name="number-cols" value="4"/>4</label>
                                                </div>
                                                <div class="radio">
                                                    <label><input type="radio" name="number-cols" value="6"/>6</label>
                                                </div>
                                                <div class="radio">
                                                    <label><input type="radio" name="number-cols" value="12"/>12</label>
                                                </div>
                                            </form>
                                        </li>
                                        <li>
                                            <form><span lang="en" class="lang hidden">Show empty verses</span><span lang="de" class="lang hidden">Leere Verse zeigen</span><span class="lang hidden" lang="es">Mostrar versos vacíos</span>&#160;&#160;<input type="checkbox" id="extensive-edition-toggle"/></form>
                                        </li>
                                        <li>
                                            <form><span lang="en" class="lang hidden">Group scrolling</span><span class="lang hidden" lang="de">Gruppen Scrollen</span><span class="lang hidden" lang="es">Desplazamiento conjunto</span>&#160;&#160;<input type="checkbox" id="group-scroll"/></form>
                                        </li>
                                        <li class="dropdown-submenu">
                                            <a class="test" tabindex="-1">
                                                <span class="lang" lang="en">Visualization </span>
                                                <span class="lang" lang="de">Visualisierung</span>
                                                <span class="lang" lang="es">Visualización</span>
                                            </a>
                                            <ul class="dropdown-menu">
                                                <li>
                                                    <form>
                                                        <input type="checkbox" name="global_punktion" checked="checked"/>
                                                        <span class="lang" lang="en">Punctuation</span>
                                                        <span class="lang" lang="de">Punktion</span>
                                                        <span class="lang" lang="es">Puntuación</span>
                                                    </form>
                                                </li>
                                                <li>
                                                    <form>
                                                        <input type="checkbox" name="global_abbreviaturen"/>
                                                        <span class="lang" lang="en">Resolve Abbreviations</span>
                                                        <span class="lang" lang="de">Abbreviaturen auflösen</span>
                                                        <span class="lang" lang="es">Resolver abreviaturas</span>
                                                    </form>
                                                </li>
                                                <li>
                                                    <form>
                                                        <input type="checkbox" name="global_korrekturen"/>
                                                        <span data-toggle="tooltip">
                                                            <span lang="en" class="lang">Paleographic view</span>
                                                            <span lang="de" class="lang">Paleographische Ansicht</span>
                                                            <span lang="es" class="lang">Vista paleográfica</span>
                                                        </span>
                                                    </form>
                                                </li>
                                                <li>
                                                    <form>
                                                        <input type="checkbox" name="global_notes"/>
                                                        <span class="lang" lang="en">Right Margin References</span>
                                                        <span class="lang" lang="de">Referenzen am Rand</span>
                                                        <span class="lang" lang="es">Referencias en el margen</span>
                                                    </form>
                                                </li>
                                            </ul>
                                        </li>
                                        <li class="dropdown-submenu">
                                            <a class="test" tabindex="-1">
                                                <span class="lang" lang="en">Numbering</span>
                                                <span class="lang" lang="de">Numerierung</span>
                                                <span class="lang" lang="es">Numeración</span>
                                            </a>
                                            <form class="dropdown-menu">
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio" name="global_numerierung" value="manuscript"/>
                                                        <span class="lang" lang="en">Manuscript</span>
                                                        <span class="lang" lang="de">Handschrift</span>
                                                        <span class="lang" lang="es">Manuscrito</span>
                                                    </label>
                                                </div>
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio" name="global_numerierung" value="edition"/>
                                                        <span class="lang" lang="en">Edition</span>
                                                        <span class="lang" lang="de">Edition</span>
                                                        <span class="lang" lang="es">Edición</span>
                                                    </label>
                                                </div>
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio" name="global_numerierung" value="alt_ed"/>
                                                        <span class="lang" lang="en">Edition Schröder</span>
                                                        <span class="lang" lang="de">Edition Schröder</span>
                                                        <span class="lang" lang="es">Edición Schröder</span>
                                                    </label>
                                                </div>
                                            </form>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-md-7">
                                <h1 id="maereTitle">
                                    <xsl:value-of select="$title"/>
                                </h1>
                            </div>
                            <div class="col-md-3">
                                <button type="button" class="btn button-default title-options pull-left">
                                    <span lang="en" class="lang hidden">
                                        <a href="index.html">Home</a>
                                    </span>
                                    <span lang="de" class="lang hidden">
                                        <a href="../index.html">Startseite</a>
                                    </span>
                                    <span lang="es" class="lang hidden">
                                        <a href="index.html">Inicio</a>
                                    </span>
                                </button>
                                <p class="pull-right" id="languages"><a class="language-selector" id="en">English</a>&#160;&#160;<a class="language-selector" id="es">Español</a>&#160;&#160;<a class="language-selector" id="de">Deutsch</a></p>
                            </div>
                        </div>
                    </div>
                </nav>
                <nav class="navbar navbar-inverse navbar-fixed-top" id="text-titles-nav">
                    <div class="container-fluid" id="text-titles-nav-div">
                        <xsl:for-each select="(//node())[12 >= position()]">
                            <div class="col-md-3 text-title">
                             <!--   <xsl:if test="position() &gt; 4">
                                    <xsl:attribute name="class">col-md-3 text-title hidden</xsl:attribute>
                                </xsl:if>-->
                                <div class="pull-left text-selector">
                                    <select class="form-control pull-left">
                                        <option value="default" hidden="hidden"/>
                                        <optgroup>
                                            <option>
                                                <xsl:attribute name="value"><xsl:value-of select="$title_abbr"/>_krit</xsl:attribute>
                                                <xsl:attribute name="label"><xsl:value-of select="$guide_ms"/></xsl:attribute>
                                            </option>
                                            <option>
                                                <xsl:attribute name="value"><xsl:value-of select="$title_abbr"/>_app</xsl:attribute>
                                            </option>
                                        </optgroup>
                                        <optgroup>
                                            <xsl:copy-of select="$witnesses"/>
                                        </optgroup>
                                        <optgroup>
                                            <option value="ref_ref"></option>
                                            <option>
                                                <xsl:attribute name="value"><xsl:value-of select="$title_abbr"/>_wit</xsl:attribute>
                                            </option>
                                        </optgroup>
                                    </select>
                                </div>
                                <div class="dropdown pull-right visualisation-options">
                                    <button class="btn btn-primary dropdown-toggle visual-options" type="button" data-toggle="dropdown">
                                        <span class="glyphicon glyphicon-eye-open"/>
                                    </button>
                                    <ul class="dropdown-menu" role="menu">
                                        <li class="dropdown-submenu" type="visualization">
                                            <a class="test" tabindex="-1">
                                                <span class="lang" lang="en">Visualization</span>
                                                <span class="lang" lang="de">Visualisierung</span>
                                                <span class="lang" lang="es">Visualización</span>
                                            </a>
                                            <ul class="dropdown-menu">
                                                <li>
                                                    <form>
                                                        <input type="checkbox" name="punktion" checked="checked"/>
                                                        <span class="lang" lang="en">Punctuation</span>
                                                        <span class="lang" lang="de">Punktion</span>
                                                        <span class="lang" lang="es">Puntuación</span>
                                                    </form>
                                                </li>
                                                <li>
                                                    <form>
                                                        <input type="checkbox" name="abbreviaturen"/>
                                                        <span class="lang" lang="en">Resolve Abbreviations</span>
                                                        <span class="lang" lang="de">Abbreviaturen auflösen</span>
                                                        <span class="lang" lang="es">Resolver abreviaturas</span>
                                                    </form>
                                                </li>
                                                <li>
                                                    <form>
                                                        <input type="checkbox" name="korrekturen" checked="checked"/>
                                                        <span data-toggle="tooltip">
                                                            <span lang="en" class="lang">Paleographic view</span>
                                                            <span lang="de" class="lang">Paleographische Ansicht</span>
                                                            <span lang="es" class="lang">Vista paleográfica</span>
                                                        </span>
                                                    </form>
                                                </li>
                                                <li>
                                                    <form>
                                                        <input type="checkbox" name="notes" checked="checked"/>
                                                        <span class="lang" lang="en">Right Margin References</span>
                                                        <span class="lang" lang="de">Referenzen am Rand</span>
                                                        <span class="lang" lang="es">Referencias en el margen</span>
                                                    </form>
                                                </li>
                                            </ul>
                                        </li>
                                        <li class="dropdown-submenu">
                                            <a class="test" tabindex="-1">
                                                <span class="lang" lang="en">Numbering</span>
                                                <span class="lang" lang="de">Numerierung</span>
                                                <span class="lang" lang="es">Numeración</span>
                                            </a>
                                            <form class="dropdown-menu">
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio" name="numerierung" value="manuscript"/>
                                                        <span class="lang" lang="en">Manuscript</span>
                                                        <span class="lang" lang="de">Handschrift</span>
                                                        <span class="lang" lang="es">Manuscrito</span>
                                                    </label>
                                                </div>
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio" name="numerierung" value="edition"/>
                                                        <span class="lang" lang="en">Edition</span>
                                                        <span class="lang" lang="de">Edition</span>
                                                        <span class="lang" lang="es">Edición</span>
                                                    </label>
                                                </div>
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio" name="numerierung" value="alt_ed"/>
                                                        <span class="lang" lang="en">Edition Schröder</span>
                                                        <span class="lang" lang="de">Edition Schröder</span>
                                                        <span class="lang" lang="es">Edición Schröder</span>
                                                    </label>
                                                </div>
                                            </form>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </xsl:for-each>
                    </div>
                </nav>
                
                <!--                Text Columns-->
                <div class="container-fluid" id="text_container">
                    <div class="row" id="text-row">
                        <div class="col-md-3 edition-text">
                            <div class="text-container scrollable"/>
                        </div>
                        <div class="col-md-3 edition-text">
                            <div class="text-container scrollable"/>
                        </div>
                        <div class="col-md-3 edition-text">
                            <div class="text-container scrollable"/>
                        </div>
                        <div class="col-md-3 edition-text">
                            <div class="text-container scrollable"/>
                        </div>
                        <div class="col-md-3 edition-text">
                            <div class="text-container scrollable"/>
                        </div>
                        <div class="col-md-3 edition-text">
                            <div class="text-container scrollable"/>
                        </div>
                        <div class="col-md-3 edition-text">
                            <div class="text-container scrollable"/>
                        </div>
                        <div class="col-md-3 edition-text">
                            <div class="text-container scrollable"/>
                        </div>
                        <div class="col-md-3 edition-text">
                            <div class="text-container scrollable"/>
                        </div>
                        <div class="col-md-3 edition-text">
                            <div class="text-container scrollable"/>
                        </div>
                        <div class="col-md-3 edition-text">
                            <div class="text-container scrollable"/>
                        </div>
                        <div class="col-md-3 edition-text">
                            <div class="text-container scrollable"/>
                        </div>
                    </div>
                    <div class="row" id="row_introduction">
                        <div lang="en" class="lang">
                            <h2>Welcome to the Digital Edition of <xsl:value-of select="$title"/>!</h2>
                            <p>To display the transcriptions, the critical text and/or the apparatus use the selectors above. </p>
                            <p>You can change the visualisation of each text using the using the symbol <span class="glyphicon glyphicon-eye-open"/> next to the selector. To change global options (including number of columns to display and visualisations for all texts) go to "Options" in the top left corner of the screen.</p>
                        </div>
                        <div class="lang" lang="es">
                            <h2 style="text-align:center">¡Bienvenido a la Edición Digital de <xsl:value-of select="$title"/>!</h2>
                            <p>Para ver las transcripciones, el texto crítico o el aparato, utiliza los seleccionadores aquí arriba.</p>
                            <p>Es posible cambiar la forma de visualización de cada texto usando el símbolo <span class="glyphicon glyphicon-eye-open"/> junto al menú. Para cambiar opciones globales (incluyendo el número de columnas y visualizaciones para todos los testimonios) utiliza el menú con las "Opciones" en la esquina superior izquierda de la pantalla</p>
                        </div>
                        <div class="lang" lang="de">
                            <h2 style="text-align:center">Willkommen in der digitalen Edition von <xsl:value-of select="$title"/>!</h2>
                            <p>Um die Trankriptionen, den kritischen Text oder den Apparat zu sehen, benutzen Sie die Auswählmöglichkeiten oben.</p>
                            <p>Die Visualisierung jedes Textes kann anhand des Symbols <span class="glyphicon glyphicon-eye-open"/> verändert werden. Um die globalen Optionen zu ändern (Spaltenzahl und Visualisierung aller Texte) kann man "Optionen" am oberen linken Rand benutzen.</p>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
