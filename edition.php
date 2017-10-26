<?php

/*
 * PHP XSL - Generate the edition main page
 */

//Dictionary of texts
$textDict = array(
    'dwl' => 'TEI/DWL_Synoptische_Transkription.xml',
    'hvk' => 'TEI/HvK_Synoptische_Transkription.xml',
    'herz' => 'TEI/Herz_Synoptische_Transkription.xml'
);
$textKey = $_GET["source"]; 
$text = $textDict[$textKey];

// Load the XML source
$xml = new DOMDocument;
$xml->load($text);

//Load XSL file
$xsl = new DOMDocument;
$xsl->load('XSLT/html-generator.xsl');

// Configure the transformer
$proc = new XSLTProcessor;
$proc->importStyleSheet($xsl); // attach the xsl rules

echo $proc ->transformToXML($xml);
?>