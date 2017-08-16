<?php

/*
 * PHP XSL - How to transform XML to HTML using PHP
 */


$manuscript = $_GET['manuscript'];
$text = $_GET['text'];
$kind = '';
//this dictionary selects the leithandschrift for the different text, to use when loading the critical text
$leithsDict = array( 
    'DWL' => '#M',
    'HvK' => '#P',
    'Herz' => ''
);
$leiths = $leithsDict[$text];

//$kind decides which XML file to load
if  ($manuscript == '#krit' or $manuscript == '#app' or $manuscript == '#wit'){
    $kind = 'Kritischer_Text';
    }
    else{
    $kind = 'Synoptische_Transkription';
    };

// Load the XML source
$xml = new DOMDocument;
$xml->load("../TEI/{$text}_{$kind}.xml");

if ($kind == "Synoptische_Transkription"){
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
}
elseif ($manuscript == '#krit'){
    $xsl = new DOMDocument;
    $xsl->load('../XSLT/transform-critical-text.xsl');
    $proc = new XSLTProcessor;
    $proc->importStyleSheet($xsl);
    $proc->setParameter('','leiths',$leiths); //this is the Leithandschrift
    echo $proc->transformToXML($xml); 
}
elseif($manuscript == '#app'){
    $xsl = new DOMDocument;
    $xsl->load('../XSLT/create-apparatus.xsl');
    $proc = new XSLTProcessor;
    $proc->registerPHPFunctions();
    $proc->importStyleSheet($xsl);
    echo $proc->transformToXML($xml); 
}
elseif($manuscript == '#wit'){
    $xsl = new DOMDocument;
    $xsl->load('../XSLT/list_wit.xsl');
    $proc = new XSLTProcessor;
    $proc->importStyleSheet($xsl);
    echo $proc->transformToXML($xml); 
};


?>