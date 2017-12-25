<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://www.ascc.net/xml/schematron">
    <sch:ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
    <sch:pattern name="Attributes">
        <sch:rule context="tei:rdg">
            <sch:assert test="@wit">The element rdg must have a wit attribute</sch:assert>
            <sch:assert test="@type='missing' or not(@type) or contains(./@type, 'alternative') or @type='transposed'">The element rdg can only have attribute type empty, "missing", "alternative"</sch:assert>
           <!-- <sch:assert test="@xml:id or @type='missing'">The element rdg must have an xml:id</sch:assert>-->
          <!--  <sch:assert test="@xml:space='preserve'">The element rdg must have the attribute xml:space set to 'preserve'</sch:assert>-->
            <sch:assert test="@n or @type='missing'">The element rdg must have a n attribute</sch:assert>
            <sch:assert test="@rend='indent' or not(@rend)">The element rdg can have attribute type rend = 'indent'</sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern name="Structure">
        <sch:rule context="tei:add">
            <sch:assert test="parent::tei:orig or parent::tei:rdg or parent::tei:sic or parent::tei:subst">Invalid parent for add (valid: orig, reg, sic, subst)</sch:assert>
            <sch:assert test="@place='adapted' or @place='overwritten' or @place='inline' or @place='above' or @place='below' or @place='margin'">Invalid @place attribute for element add</sch:assert>
            <sch:assert test="count(*) = count(tei:choice | tei:hi | tei:metamark | tei:space | tei:w )">Invalid element inside add (valid elements: choice, hi, metamark, space, w)</sch:assert>
        </sch:rule>
        <sch:rule context="tei:abbr">
            <sch:assert test="parent::tei:choice">Invalid parent for abbr (valid: choice)</sch:assert>
            <sch:assert test="count(@*) = 0">abbr can not have any attributes</sch:assert>
            <sch:assert test="count(*) = count(tei:am | tei:hi | tei:unclear)">Invalid child for abbr (valid: am, hi)</sch:assert>
        </sch:rule>
        <sch:rule context="tei:am">
            <sch:assert test="ancestor::tei:abbr">am outside of abbr</sch:assert>
            <sch:assert test="parent::tei:abbr or parent::tei:hi or parent::tei:unclear">forbidden parent for am</sch:assert>
            <sch:assert test="count(@*) = 0">am can not have any attributes</sch:assert>
            <sch:assert test="count(*) = 0">am is a text-node</sch:assert>
        </sch:rule>
        <sch:rule context="tei:app">
            <sch:assert test="parent::tei:l or parent::tei:head">Invalid parent for app (valid: l or head)</sch:assert>
            <sch:assert test="count(@*) = 0">app can not have any attributes</sch:assert>
            <sch:assert test="count(*) = count(tei:note | tei:rdg)">Invalid element inside app (valid: note, rdg)</sch:assert>
        </sch:rule>
        <sch:rule context="tei:c">
            <sch:assert test="parent::tei:add or parent::tei:corr or parent::tei:rdg or parent::tei:hi or parent::tei:del or parent::tei:sic or parent::tei:subst">Invalid parent for c  element (valid: add, del, hi, rdg, sic)</sch:assert>
            <sch:assert test="count(@*) = count(@type) and @type='space'">c element must have attribute @type='space'</sch:assert>
            <sch:assert test="count(node()) = 0">space is an empty element</sch:assert>
        </sch:rule>
        <sch:rule context="tei:cb">
            <sch:assert test="parent::tei:div or preceding-sibling::tei:l">The element cb must be outside the lg, unless it is between two l</sch:assert>
            <sch:assert test="(@edRef and @facs and count(@*) = 2 ) or (@edRef and @facs and @ed and count(@*) = 3 )">Wrong attributes in cb (@edRef and @facs are obligatory, @ed possible)</sch:assert>
            <sch:assert test="count(node()) = 0">cb is an empty element</sch:assert>
        </sch:rule>
        <sch:rule context="tei:corr">
            <sch:assert test="parent::tei:choice">Invalid parent for app (valid: choice)</sch:assert>
            <sch:assert test="@resp">Invalid attribute for corr (valid: @resp)</sch:assert>
            <sch:assert test="count(*) = count(tei:choice | tei:hi | tei:w | tei:space | tei:supplied)">Invalid element inside corr (valid: choice, hi, space, supplied, w)</sch:assert>
        </sch:rule>
        <sch:rule context="tei:choice">
            <sch:assert test="parent::tei:add | parent::tei:corr | parent::tei:del | parent::tei:orig | parent::tei:rdg | parent::tei:sic">Invalid parent for choice (valid: corr, orig, sic)</sch:assert>
            <sch:assert test="count(@*) = 0">choice can not contain attributes</sch:assert>
            <sch:assert test="count(*) = 2 and ((count(tei:abbr) = 1 and count(tei:expan)= 1) or (count(tei:sic) = 1 and count(tei:corr) = 1))">The element choice must have either one abbr and one expan or one orig and one corr</sch:assert>
        </sch:rule>
        <sch:rule context="tei:damage">
            <sch:assert test="parent::tei:orig | parent::tei:rdg | parent::tei:sic">Invalid parent for damage (valid: orig, rdg)</sch:assert>
            <sch:assert test="@agent or count(@*) = 0">Invalid attribute for damage (valid: @agent, none)</sch:assert>
            <sch:assert test="count(*) = 0">damage is an only text-node</sch:assert>
        </sch:rule>
        <sch:rule context="tei:del">
            <sch:assert test="parent::tei:orig | parent::tei:rdg | parent::tei:subst">Invalid parent for del</sch:assert>
            <sch:assert test="@rend='overstrike' or @rend='overstrike color:red' or @rend='underlined' or @rend='overdottet' or @rend='adapted' or @rend='overwritten'or @rend='erased'  or @rend='overstrike overdotted color:red'">del must have @rend attribute</sch:assert>
            <sch:assert test="count(@*) = count(@rend)">invalid attribute for del</sch:assert>
            <sch:assert test="count(*) = count(tei:choice | tei:lb | tei:space | tei:unclear | tei:w)">Invalid element inside del (valid: choice, lb, space, unclear, w)</sch:assert>
        </sch:rule>
        <sch:rule context="tei:div">
            <sch:assert test="parent::tei:body">Invalid parent for div</sch:assert>
            <sch:assert test="count(@*) = 0">div can not have any attributes</sch:assert>
            <sch:assert test="count(*) = count(tei:cb | tei:head | tei:lg | tei:note | tei:pb )">Only pb, cb, head, lg and note allowed as children of the main div</sch:assert>
        </sch:rule>
        <sch:rule context="tei:emph">
            <sch:assert test="parent::tei:note">Invalid parent for emph</sch:assert>
            <sch:assert test="count(@*) = 0 or @xml:lang">Invalid attribute for emph (valid: xml:lang)</sch:assert>
            <sch:assert test="count(*) = 0">emph is a text-node</sch:assert>
        </sch:rule>
        <sch:rule context="tei:ex">
            <sch:assert test="ancestor::tei:expan">ex outside of abbr</sch:assert>
            <sch:assert test="parent::tei:expan or parent::tei:hi or parent::tei:unclear">forbidden parent for ex</sch:assert>
            <sch:assert test="count(@*) = 0">ex can not have any attributes</sch:assert>
            <sch:assert test="count(*) = 0">ex is a text-node</sch:assert>
        </sch:rule>
        <sch:rule context="tei:expan">
            <sch:assert test="parent::tei:choice">Invalid parent for expan (valid: choice)</sch:assert>
            <sch:assert test="count(@*) = 0">expan can not have any attributes</sch:assert>
            <sch:assert test="count(*) = count(tei:ex | tei:hi | tei:unclear)">Invalid child for expan (valid: ex, hi, unclear)</sch:assert>
        </sch:rule>
        <sch:rule context="tei:gap">
            <sch:assert test="parent::tei:rdg">Invalid parent for gap (valid: rdg)</sch:assert>
            <sch:assert test="count(@*) = 3 and @reason and @extent and @unit">gap can not have any attributes</sch:assert>
            <sch:assert test="count(node()) = 0">gap is an empty element</sch:assert>
        </sch:rule>
        <sch:rule context="tei:head">
            <sch:assert test="parent::tei:div">Invalid parent for head (valid: div)</sch:assert>
            <sch:assert test="count(@*) = 0">head can not have any attributes</sch:assert>
            <sch:assert test="count(*) = count(tei:app | tei:note)"></sch:assert>
        </sch:rule>
        <sch:rule context="tei:hi">
            <sch:assert test=" parent::tei:abbr | parent::tei:add | parent::tei:corr | parent::tei:expan | parent::tei:metamark | parent::tei:orig | parent::tei:rdg | parent::tei:sic">Invalid parent for hi</sch:assert>
            <sch:assert test="@rend">Invalid attribute for hi (valid and obligatory: @rend)</sch:assert>
            <sch:assert test="count(*) = count(tei:am | tei:choice | tei:metamark | tei:lb | tei:space | tei:unclear | tei:w)">Invalid element inside hi (valid: choice, metamark, lb, space, w)</sch:assert>
        </sch:rule>
        <sch:rule context="tei:l">
            <sch:assert test="parent::tei:lg">l outside of lg</sch:assert>
            <sch:assert test="count(@*) = 2 and @xml:id and @corresp">Invalid attribute for l (valid and obligatory: xml:id, corresp)</sch:assert>
            <sch:assert test="count(*) = count(tei:app | tei:note)">Invalid element as child of l</sch:assert>
        </sch:rule>
        <sch:rule context="tei:lb">
            <sch:assert test=" parent::tei:del | parent::tei:hi | parent::tei:orig | parent::tei:rdg">Invalid parent for lb (valid: del, hi, orig, rdg)</sch:assert>
            <sch:assert test="@type='above' or @type='below' or @type='in_verse' or @type='prose' or @type='verse'">Invalid attributes for lb (valid: type)</sch:assert>
            <sch:assert test="count(node()) = 0">lb is an empty element</sch:assert>
        </sch:rule>
        <sch:rule context="tei:lg">
            <sch:assert test="parent::tei:div">The element lg must have div for parent</sch:assert>
            <sch:assert test="count(@*) = 0">lg can not have any attributes</sch:assert>
            <sch:assert test="count(*) = count(tei:cb | tei:l | tei:note | tei:pb)">Only l, pb, cb and note allowed as children of lg</sch:assert>
        </sch:rule>
        <sch:rule context="tei:metamark">
            <sch:assert test=" parent::tei:add | parent::tei:rdg | parent::tei:hi | parent::tei:orig | parent::tei:sic">Invalid parent for metamark (valid: add, rdg, hi, orig, sic)</sch:assert>
            <sch:assert test="count(@*) = 0 or @function='addition' or @function='correction' or @function='cue_initial' or @function='link' or @function='uncertain'">Invalid attribute for metamark (valid: @function='addition' o 'correction' o 'cue_initial' o 'link')</sch:assert>
            <sch:assert test="count(*) = count(tei:hi | tei:w)">Invalid element inside metamark (valid: hi, w)</sch:assert>
        </sch:rule>
        <sch:rule context="tei:note">
            <sch:assert test=" parent::tei:app | parent::tei:l | parent::tei:lg | parent::tei:rdg">Invalid parent for note (valid: app, l, rdg)</sch:assert>
            <sch:assert test="count(@*) = count(@type)">Invalid attribute inside note (valid: @type)</sch:assert>
            <sch:assert test="(count(*) = count(tei:emph | tei:seg)) or (@type='gloss' and (count(*) = count(tei:add | tei:choice | tei:damage | tei:del | tei:gap | tei:hi | tei:lb | tei:metamark | tei:pc | tei:space | tei:subst | tei:w)))">Invalid element inside note (valid: emph, seg / dd, choice[sic | corr], damage, del, gap, hi, lb, metamark,pc, space, subst, w)</sch:assert>
        </sch:rule>
        <sch:rule context="tei:orig">
            <sch:assert test="parent::tei:w">The element orig must have w for parent</sch:assert>
            <sch:assert test="count(@*) = 0">orig can not have any attributes</sch:assert>
            <sch:assert test="count(*) = count(tei:add | tei:choice | tei:damage | tei:del | tei:hi | tei:lb | tei:metamark | tei:sic | tei:subst | tei:unclear)">Only add, choice, damage, del, hi, lb, metamark, sic, subst and unclear allowed as children of orig</sch:assert>
        </sch:rule>
        <sch:rule context="tei:pb">
            <sch:assert test="parent::tei:div or preceding-sibling::tei:l">The element pb must be outside the lg, unless it is between two l</sch:assert>
            <sch:assert test="(@edRef and @facs and count(@*) = 2 ) or (@edRef and @facs and @ed and count(@*) = 3 )">Wrong attributes in pb (@edRef and @facs are obligatory, @ed possible)</sch:assert>
            <sch:assert test="count(node()) = 0">pb is an empty element</sch:assert>
        </sch:rule>
        <sch:rule context="tei:pc">
            <sch:assert test="parent::tei:rdg">Invalid parent for pc (valid: rdg)</sch:assert>
            <sch:assert test="count(@*) = 0">pc can not have any attributes</sch:assert>
            <sch:assert test="count(*) = 0">pc is text-node only</sch:assert>
        </sch:rule>
        <sch:rule context="tei:reg">
            <sch:assert test="parent::tei:w">The element reg must have w for parent</sch:assert>
            <sch:assert test="count(@*) = 0">reg can not have any attributes</sch:assert>
            <sch:assert test="count(*) = 0">reg is text-node only</sch:assert>
        </sch:rule>
        <sch:rule context="tei:rdg">
            <sch:assert test="count(*) = count(tei:add | tei:choice | tei:damage | tei:del | tei:gap | tei:hi | tei:lb | tei:metamark | tei:note | tei:pc | tei:space | tei:subst | tei:w | tei:witEnd | tei:witStart)">Only add, choice, damage, del, gap, hi, lb, pc, sic, space, subst, note, metamark, w, witEnd, witStart allowed as children of rdg</sch:assert>
        </sch:rule>
        <sch:rule context="tei:sic">
            <sch:assert test="parent::tei:choice | parent::tei:orig">Invalid parent for sic (valid: choice, orig)</sch:assert>
            <sch:assert test="count(@*) = 0">No attributes allowed for sic</sch:assert>
            <sch:assert test="count(*) = count(tei:add | tei:choice | tei:damage | tei:hi | tei:metamark | tei:space | tei:unclear |  tei:w )">Invalid element inside sic (valid: add, choice, damage, hi, metamark, w)</sch:assert>
        </sch:rule>
        <sch:rule context="tei:seg">
            <sch:assert test="parent::tei:note">Invalid parent for seg (valid: note)</sch:assert>
            <sch:assert test="@type='lang' and @xml:lang">Invalid attribute for seg (valid: @type='lang', @xml:lang)</sch:assert>
            <sch:assert test="count(*) = 0">seg is text-node only</sch:assert>
        </sch:rule>
        <!--<sch:rule context="tei:space">
            <sch:assert test="parent::tei:add or parent::tei:corr or parent::tei:rdg or parent::tei:hi or parent::tei:del or parent::tei:sic or parent::tei:subst">The element space must have add, del, hi, rdg, sic or subst for parent</sch:assert>
            <sch:assert test="count(@*) = 0">space element can't have any attributes</sch:assert>
            <sch:assert test="count(node()) = 0">space is an empty element</sch:assert>
        </sch:rule>-->
        <sch:rule context="tei:subst">
            <sch:assert test=" parent::tei:orig | parent::tei:rdg">Invalid parent for subst (valid: orig, rdg)</sch:assert>
            <sch:assert test="count(@*) = 0">subst element can't have any attributes</sch:assert>
            <sch:assert test="count(*) = count(tei:add | tei:del)">Invalid element inside subst (valid: add, del)</sch:assert>
        </sch:rule>
        <sch:rule context="tei:supplied">
            <sch:assert test=" parent::tei:corr | parent::tei:orig | parent::tei:rdg">Invalid parent for supplied (valid: corr, orig, rdg)</sch:assert>
            <sch:assert test="count(@*) = count(@resp)">Invalid attribute for supplied (valid: @resp)</sch:assert>
            <sch:assert test="count(*) = count(tei:w | tei:pc)">Invalid element inside supplied (valid: pc, w or text-node)</sch:assert>
        </sch:rule>
        <sch:rule context="tei:unclear">
            <sch:assert test=" parent::tei:abbr | parent::tei:del | parent::tei:hi | parent::tei:orig | parent::tei:sic">Invalid parent for unclear (valid: abbr, del,hi, orig, sic)</sch:assert>
            <sch:assert test="count(@*) = 0">unclear element can't have any attributes</sch:assert>
            <sch:assert test="count(*) = count(tei:am | tei:choice | tei:w)">Invalid element inside unclear (valid: am, choice, w)</sch:assert>
        </sch:rule>
        <sch:rule context="tei:w">
            <sch:assert test="parent::tei:add | parent::tei:del | parent::tei:hi | parent::tei:rdg | parent::tei:sic | parent::tei:corr | parent::tei:note[@type='gloss']">Invalid parent for w</sch:assert>
            <sch:assert test="count(@*) = count(@lemma | @lemmaRef)">Invalid attribute for w (valid: @lemma, @lemmaRef)</sch:assert>
            <sch:assert test="count(*) = count(tei:orig | tei:reg)">Invalid element inside w (valid: orig, reg)</sch:assert>
        </sch:rule>
        <sch:rule context="tei:witEnd">
            <sch:assert test="parent::tei:rdg">Invalid parent for witEnd (valid: rdg)</sch:assert>
            <sch:assert test="count(@*) = count(@wit)">witEnd can't have any attributes</sch:assert>
            <sch:assert test="count(node()) = 0">witEnd is an empty element</sch:assert>
        </sch:rule>
        <sch:rule context="tei:witStart">
            <sch:assert test="parent::tei:rdg">Invalid parent for witStart (valid: rdg)</sch:assert>
            <sch:assert test="count(@*) = count(@wit)">witStart can't have any attributes</sch:assert>
            <sch:assert test="count(node()) = 0">witStart is an empty element</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>