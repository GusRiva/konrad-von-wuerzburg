declare namespace tei="http://www.tei-c.org/ns/1.0";

let $document :=  doc("Herz_Synoptische_Transkription.xml")
for $l in $document//tei:div/tei:lg[1]/tei:l[1]
where $l/not(@type = "missing")
return $l

