xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";

(:THIS SCRIPT ADDS <w> TAGS TO ALL WORDS AND CONSIDERS THE TAGS ALREADY IN PLACE:)

let $document :=  doc("/Applications/XAMPP/xamppfiles/htdocs/konrad/TEI/DWL_Synoptische_Transkription.xml")

for $rdg in $document//tei:rdg
return
    if ($rdg[@type="missing"]) then
    $rdg
    else
    <rdg>
    <w><orig>{
    for $node in $rdg/node()
    return 
        if ($node instance of text()) then
            replace($node, "\s", '</orig></w> <w><orig>')
        else
            $node
          }</orig><reg></reg></w>
    </rdg>