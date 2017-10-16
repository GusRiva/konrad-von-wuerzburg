<?php

/*
 * PHP XSL - How to transform XML to HTML using PHP
 */


$manuscript = $_GET['manuscript'];
$text = $_GET['text'];
$kind = '';
if  ($manuscript == '#krit' or $manuscript == '#app'){
    $kind = 'Kritischer_Text'}
    else{
    $kind = 'Synoptische_Transkription'};

// Load the XML source
$xml = new DOMDocument;
$xml->load('../TEI/HvK_Synoptische_Transkription.xml');

//Load XSL file
$xsl = new DOMDocument;
$xsl->load('../XSLT/isolate_witness.xsl');
$xsl1 = new DOMDocument;
$xsl1->load('../XSLT/transform_isolated_witness.xsl');

// Configure the transformer
$proc = new XSLTProcessor;
$proc->importStyleSheet($xsl); // attach the xsl rules

$proc->setParameter('', 'manuscript', $manuscript);

$isolated = $proc->transformToDoc($xml);

$proc1 = new XSLTProcessor;
$proc1->importStyleSheet($xsl1);

echo $proc1->transformToXML($isolated);
?>