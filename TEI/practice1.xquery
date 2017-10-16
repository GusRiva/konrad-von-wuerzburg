xquery version "1.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace functx = "http://www.functx.com";

(:THIS SCRIPT ADDS <w> TAGS TO ALL WORDS AND CONSIDERS THE TAGS ALREADY IN PLACE:)

let $document :=  doc("practice-excerpt.xml")
for $rdg in $document//rdg
return
    if ($rdg[@type="missing"]) then
    $rdg
    else
    <rdg>
    <w>{
    for $node in $rdg/node()
    return 
        if ($node instance of text()) then
            replace($node, "\s", '</w> <w>')
        else
            $node
          }</w>
    </rdg>